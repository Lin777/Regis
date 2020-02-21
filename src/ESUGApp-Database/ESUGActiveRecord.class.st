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

{ #category : #defaults }
ESUGActiveRecord class >> defaultIdentityDictionary [

	^ IdentityDictionary new: self defaultHashSize 
]

{ #category : #default }
ESUGActiveRecord class >> defaultStore [

	^ ESUGMemoryStore new
]

{ #category : #'actions private' }
ESUGActiveRecord class >> ensureReady [

	lock := Monitor new
]

{ #category : #initialization }
ESUGActiveRecord class >> initialize [
	
	Store := self defaultStore
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

{ #category : #accessing }
ESUGActiveRecord >> updatedOn [

	^ updatedOn
]

{ #category : #accessing }
ESUGActiveRecord >> version [

	^ version
]
