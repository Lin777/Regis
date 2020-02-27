"
Cache Store for ESUG App
"
Class {
	#name : #ESUGCachedStore,
	#superclass : #ESUGAbstractStore,
	#instVars : [
		'cache'
	],
	#category : #'ESUGApp-Database-Core'
}

{ #category : #actions }
ESUGCachedStore >> abortChanges: anObject [ 
	| diskVersion |
	anObject critical: 
		[ self 
			removeCachedOfClass: anObject class
			from: anObject id.
		diskVersion := self 
			cachedLoadOfClass: anObject class
			from: anObject id.
		diskVersion 
			ifNil: 
				[ self 
					addCachedOfClass: anObject class
					at: anObject id
					put: anObject ]
			ifNotNil: [ anObject becomeForward: diskVersion ] ]
]

{ #category : #adding }
ESUGCachedStore >> addCachedOfClass: aClass at: anId put: anObject [
	(cache at: aClass) at: anId put: anObject
]

{ #category : #actions }
ESUGCachedStore >> ensureForClass: aClass [
	cache 
		at: aClass 
		ifAbsentPut: [ ESUGConcurrentDictionary on: (Dictionary new: self defaultCacheSize) ]
]

{ #category : #'delegated queries' }
ESUGCachedStore >> familyForClass: aClass [ 
	^ aClass allSubclasses 
		inject: (cache at: aClass) 
		into: [ :sum :subclass | sum , (cache at: subclass)  ]
]

{ #category : #'delegated queries' }
ESUGCachedStore >> forClass: aClass [ 
	^ (self familyForClass: aClass) 
]

{ #category : #'delegated queries' }
ESUGCachedStore >> forClass: aClass do: aBlock [
	aClass withAllSubclasses do: [ :class | (cache at: class) do: aBlock ]
]

{ #category : #'delegated queries' }
ESUGCachedStore >> forClass: aClass findAll: aBlock [ 
	| result |
	result := Dictionary new.
	aClass withAllSubclasses do: [:class | 
		result addAll: ((cache at: class) select: aBlock) ].
	^ result
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
