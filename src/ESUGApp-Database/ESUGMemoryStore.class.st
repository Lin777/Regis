"
Memory Store of instances in ESUGApp database
"
Class {
	#name : #ESUGMemoryStore,
	#superclass : #ESUGCachedStore,
	#classVars : [
		'Cache',
		'Instances'
	],
	#category : #'ESUGApp-Database-Store'
}

{ #category : #'class initialization' }
ESUGMemoryStore class >> initialize [

	Instances := Dictionary new
]

{ #category : #actions }
ESUGMemoryStore >> loadClass: aClass atId: anId [

	^ (Instances at: anId) resolveReferences
]

{ #category : #actions }
ESUGMemoryStore >> recoverForClass: aClass [ 


	(Instances associationsSelect: [ :a | a value class == aClass ]) 
		keysDo: [ :e |  self cachedLoadOfClass: aClass from:  e ]
]

{ #category : #removing }
ESUGMemoryStore >> removeObject: anObject [

	super removeObject: anObject.
	Instances removeKey: anObject id ifAbsent: []
]

{ #category : #actions }
ESUGMemoryStore >> storeObject: anObject [
	"Do a deep Copy of the Object and mark the references to store a object by id"

	super storeObject: anObject.
	Instances
		at: anObject id
		put: anObject esugDeepCopy esugMarkReferences
]

{ #category : #actions }
ESUGMemoryStore >> updateObject: anObject [
	"Update the object"

	self storeObject: anObject
	
]
