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
	isNew
		ifTrue: [ 
			"You may reach this point several times before you get the intended use of this framework. This is 
		expected **by design** to make atomic saves really small and consistent. Commits of active records
		which have other active records as parts (at any depth) are restricted intentionally. They are only 
		allowed when all its sub active records are previously commited.  
		
		Only the programmer knows the proper logical commit order for his data! This is not a relational database
		or an object database, its a filesystem database meant only to make an image crash proof and files
		aren't transactional, if you absolutely need several objects to be atomically saved, then you should make 
		them all part of a single aggregate cluster, all of your objects should not be active records, only your aggregate 
		roots are active records.  
		
		For example, an Order would be an ActiveRecord while its LineItem's would simply inherit from Object.  The
		Order and all its line items would be atomically saved as a single file by Order id.  You could not query for
		a line item directly to update it, you would query for the order, its aggregate root, do your work, and 
		commit the order.  An aggregate root is the natural query and transactional boundry for the domain.
		See Eric Evans Domain Driven Design for more information about this way of thinking.
		
		Do not try to rig your objects up to cascade save, to do so is to be missing the point of this 
		framework: Simplicity. This is not an OODB where you call commit once and you hope everything
		magically saves correctly.  One record should not be saving another.  Saves are something best done
		in your controller methods explicitly.  Save your new objects first, then make one reference the other, then
		save the modified one again. This pattern is simple and it works without magic that will confuse you and it 
		will force you to confront failure scenarios where one record saves successfully but the other doesn't.  Trying 
		to hide this behind cascading saves only hides from the programmer the fact that each save is atomic but multiple 
		saves are not."
			ESUGDatabaseCommitError
				signal:
					'An object is being saved while referencing an unsaved record of type ' , self class name
						, '.  You must save that record first!' ].
	^ (ESUGRecordMarker new)
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
ESUGActiveRecord >> onBeforeFirstSave [

	createdOn := DateAndTime now
]

{ #category : #events }
ESUGActiveRecord >> onBeforeSave [

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

{ #category : #accessing }
ESUGActiveRecord >> updatedOn [

	^ updatedOn
]

{ #category : #accessing }
ESUGActiveRecord >> version [

	^ version
]
