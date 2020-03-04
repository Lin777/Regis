"
Principal class to save data in ESUG App
"
Class {
	#name : #ESUGActiveRecord,
	#superclass : #Object,
	#instVars : [
		'id',
		'createdOn',
		'updatedOn',
		'version',
		'isNew'
	],
	#classVars : [
		'Store'
	],
	#classInstVars : [
		'lock'
	],
	#category : #'ESUGApp-Database-Core'
}

{ #category : #accessing }
ESUGActiveRecord class >> atId: anId ifAbsent: aHandler [ 
	"hitting this in a tight loop for a class with subclasses can be very expensive
	because allCaches has to concatenate all the subclasses caches into a new copy
	that contains all subclass records"
	^  Store forClass: self at: anId ifAbsent: aHandler
]

{ #category : #actions }
ESUGActiveRecord class >> commit: aBlock [ 
	^ Store commit: aBlock
]

{ #category : #actions }
ESUGActiveRecord class >> coolDown [

	lock := nil.
	self ensureReady
]

{ #category : #defaults }
ESUGActiveRecord class >> defaultHashSize [
	^ 100
]

{ #category : #defaults }
ESUGActiveRecord class >> defaultIdentityDictionary [

	^ IdentityDictionary new: self defaultHashSize 
]

{ #category : #default }
ESUGActiveRecord class >> defaultStore [

	^ ESUGMemoryStore new
]

{ #category : #enumerating }
ESUGActiveRecord class >> detect: aBlock [
	^ self find: aBlock 
]

{ #category : #enumerating }
ESUGActiveRecord class >> detect: aBlock ifNone: alternateBlock [
	^ self find: aBlock ifAbsent: alternateBlock 
]

{ #category : #enumerating }
ESUGActiveRecord class >> do: aBlock [
	"do on a copy in case the do modifies the collection I'm trying to iterate'"
	Store forClass: self do: aBlock
]

{ #category : #'actions private' }
ESUGActiveRecord class >> ensureReady [

	lock := Monitor new
]

{ #category : #'typing/selecting keys' }
ESUGActiveRecord class >> find: aBlock [ 
	^ self 
		find: aBlock
		ifAbsent: [ nil ]
]

{ #category : #queries }
ESUGActiveRecord class >> find: aBlock ifAbsent: aHandler [ 
	^ Store forClass: self detect: aBlock ifNone: aHandler
]

{ #category : #queries }
ESUGActiveRecord class >> find: aBlock ifPresent: aHandler [ 
	^ Store forClass: self detect: aBlock ifFound: aHandler
]

{ #category : #queries }
ESUGActiveRecord class >> findAll [

	^ (Store forClass: self) values
]

{ #category : #querying }
ESUGActiveRecord class >> findAll: aBlock [

	^ ( Store forClass: self findAll: aBlock ) values
]

{ #category : #initialization }
ESUGActiveRecord class >> initialize [
	
	Store := self defaultStore
]

{ #category : #accessing }
ESUGActiveRecord class >> lock [

	^ lock ifNil: [ lock := Monitor new ]
]

{ #category : #initialization }
ESUGActiveRecord class >> resetStoreForLoad [

	self setStore: self store class new
]

{ #category : #enumerating }
ESUGActiveRecord class >> select: aBlock [

	^ self findAll: aBlock 
]

{ #category : #initialization }
ESUGActiveRecord class >> setStore: aStore [

	Store ifNotNil: [ Store ensureDown ].
	Store := aStore
]

{ #category : #accessing }
ESUGActiveRecord class >> store [

	^ Store
]

{ #category : #accessing }
ESUGActiveRecord class >> values [

	^ self findAll
]

{ #category : #actions }
ESUGActiveRecord class >> warmUp [
	
	self store ensureForClass: self.
	self ensureReady.
	self store recoverForClass: self
]

{ #category : #actions }
ESUGActiveRecord class >> warmUpAllClasses [
	
	ESUGActiveRecord
		allSubclassesDo: [ :each | self store ensureForClass: each ];
		allSubclassesDo: [ :each | each warmUp ]
]

{ #category : #comparing }
ESUGActiveRecord >> = anObject [

	^ (anObject isMemberOf: self class) and: [ id = anObject id ]
]

{ #category : #actions }
ESUGActiveRecord >> abortChanges [

	Store abortChanges: self.
]

{ #category : #converting }
ESUGActiveRecord >> asReferenceMarker [
	"If the object is new, launch a error message when try to save it when the class of the object is not saved. If the object is not new, return the a record marker with the id and the class name of object"

	isNew
		ifTrue: [ self triggerErrorInDatabaseCommit ].
	^ ESUGRecordMarker new
		id: id;
		className: self class name;
		yourself
]

{ #category : #accessing }
ESUGActiveRecord >> createdOn [

	^ createdOn
]

{ #category : #actions }
ESUGActiveRecord >> critical: aBlock [

	^ self class lock critical: aBlock
]

{ #category : #'submorphs-add/remove' }
ESUGActiveRecord >> delete [
	"I'm using monitors for locking so this can be wrapped in larger critical
	in your application code if you want more scope on the critical'"
	self critical: 
		[ self onBeforeDelete.
		Store removeObject: self.
		self onAfterDelete.
		self initialize ]
]

{ #category : #serialization }
ESUGActiveRecord >> esugDeepCopy [

	^ self deepCopyVisits: self class defaultIdentityDictionary
]

{ #category : #serialization }
ESUGActiveRecord >> esugMarkReferences [

	^ self markReferencesVisits: self class defaultIdentityDictionary
]

{ #category : #comparing }
ESUGActiveRecord >> hash [

	^ id hash
]

{ #category : #accessing }
ESUGActiveRecord >> id [

	^ id
]

{ #category : #initialization }
ESUGActiveRecord >> initialize [

	super initialize.
	id ifNil: [ id := UUID new asString36 ].
	createdOn := updatedOn := DateAndTime now.
	version := 0.
	isNew := true
]

{ #category : #testing }
ESUGActiveRecord >> isActiveRecord [

	^ true
]

{ #category : #accessing }
ESUGActiveRecord >> isNew [

	^ isNew ifNil: [ isNew := true ]
]

{ #category : #events }
ESUGActiveRecord >> onAfterDelete [
	"for overriding in subclasses to hook the objects lifecycle"
	
]

{ #category : #events }
ESUGActiveRecord >> onBeforeDelete [
	"for overriding in subclasses to hook the objects lifecycle"
	
]

{ #category : #events }
ESUGActiveRecord >> onBeforeFirstSave [
	"Change creation date and time to the latest"

	createdOn := DateAndTime now
]

{ #category : #events }
ESUGActiveRecord >> onBeforeSave [
	"Update date, version and state"

	updatedOn := DateAndTime now.
	version := version + 1.
	isNew := false
]

{ #category : #events }
ESUGActiveRecord >> onLoad [
	"for overriding in subclasses to hook the objects lifecycle"
	
]

{ #category : #copying }
ESUGActiveRecord >> postCopy [

	super postCopy.
	id := UUID new asString36.
	createdOn := updatedOn := DateAndTime now.
	version := 0.
	isNew := true
]

{ #category : #serialization }
ESUGActiveRecord >> resolveReferences [

	^ self resolveReferencesVisits: self class defaultIdentityDictionary
]

{ #category : #actions }
ESUGActiveRecord >> save [
	"Save the Object in MemoryStore. If the Object exists, it is updated"

	| isFirstSave |	
	^ self critical: [ 
		(isFirstSave := isNew) ifTrue: [ self onBeforeFirstSave ].
		self onBeforeSave.
		isFirstSave 
			ifTrue: [Store storeObject: self] 
			ifFalse: [Store updateObject: self].
		self ]
]

{ #category : #actions }
ESUGActiveRecord >> save: aBlock [

	^ self critical: 
		[ aBlock value.
		self save ]
]

{ #category : #converting }
ESUGActiveRecord >> triggerErrorInDatabaseCommit [
	"Launch error of Database Commit Error with a message"

	ESUGDatabaseCommitError
		signal:
			'An object is being saved while referencing an unsaved record of type '
				, self class name , '. You must save that record first!'
]

{ #category : #accessing }
ESUGActiveRecord >> updatedOn [

	^ updatedOn
]

{ #category : #accessing }
ESUGActiveRecord >> version [

	^ version
]
