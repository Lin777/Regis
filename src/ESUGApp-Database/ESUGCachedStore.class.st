"
Cache Store for ESUG App
"
Class {
	#name : #ESUGCachedStore,
	#superclass : #ESUGAbstractStore,
	#instVars : [
		'cache'
	],
	#category : #'ESUGApp-Database-Store'
}

{ #category : #actions }
ESUGCachedStore >> addCachedOfClass: aClass at: anId put: anObject [
	"Add class to dictionary and put object by object id"
	
	(cache at: aClass) at: anId put: anObject
]

{ #category : #initialization }
ESUGCachedStore >> initialize [

	super initialize.
	self initializeCache
]

{ #category : #initialization }
ESUGCachedStore >> initializeCache [

	cache := Dictionary new
]

{ #category : #actions }
ESUGCachedStore >> removeCachedOfClass: aClass from: anId [ 
	"Remove object by object id of class in Dictionary cache"

	^ (cache at: aClass) removeKey: anId
		ifAbsent: [ nil ]
]

{ #category : #actions }
ESUGCachedStore >> removeObject: anObject [

	self removeCachedOfClass: anObject class from: anObject id
]

{ #category : #actions }
ESUGCachedStore >> storeObject: anObject [

	self 
		addCachedOfClass: anObject class
		at: anObject id
		put: anObject.
]
