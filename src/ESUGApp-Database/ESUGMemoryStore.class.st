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

{ #category : #removing }
ESUGMemoryStore >> removeObject: anObject [

	super removeObject: anObject.
	Instances removeKey: anObject id ifAbsent: []
]

{ #category : #actions }
ESUGMemoryStore >> storeObject: anObject [

	super storeObject: anObject.
	Instances
		at: anObject id
		put: anObject esugDeepCopy esugMarkReferences
]

{ #category : #actions }
ESUGMemoryStore >> updateObject: anObject [

	self storeObject: anObject
	
]
