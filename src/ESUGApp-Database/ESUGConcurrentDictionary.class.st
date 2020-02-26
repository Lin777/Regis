"
Concurrency of dictionary
"
Class {
	#name : #ESUGConcurrentDictionary,
	#superclass : #Object,
	#instVars : [
		'lock',
		'dictionary'
	],
	#category : #'ESUGApp-Database-Core'
}

ESUGConcurrentDictionary class >> on: aDictionary [
	^ self new
		dictionary: aDictionary;
		yourself 
]

{ #category : #copying }
ESUGConcurrentDictionary >> , aCollection [ 
	^ lock critical: [ self class on: dictionary , aCollection ]
]

{ #category : #accessing }
ESUGConcurrentDictionary >> associationsDo: aBlock [
	^ lock critical: [ dictionary associationsDo: aBlock ]
]

{ #category : #accessing }
ESUGConcurrentDictionary >> at: aKey [
	^ lock critical: [ dictionary at: aKey ]
]

{ #category : #accessing }
ESUGConcurrentDictionary >> at: aKey ifAbsent: aBlock [ 
	^ lock critical: 
		[ dictionary 
			at: aKey
			ifAbsent: aBlock ]
]

{ #category : #accessing }
ESUGConcurrentDictionary >> at: aKey ifAbsentPut: aBlock [ 
	^ lock critical: 
		[ dictionary 
			at: aKey
			ifAbsentPut: aBlock ]
]

{ #category : #accessing }
ESUGConcurrentDictionary >> at: aKey put: aValue [ 
	^ lock critical: 
		[ dictionary 
			at: aKey
			put: aValue ]
]

{ #category : #accessing }
ESUGConcurrentDictionary >> detect: aBlock ifNone: aHandler [
	^ lock critical: [ dictionary detect: aBlock ifNone: aHandler ]
]

{ #category : #accessing }
ESUGConcurrentDictionary >> dictionary [
	^ dictionary
]

{ #category : #accessing }
ESUGConcurrentDictionary >> dictionary: anObject [
	dictionary := anObject
]

{ #category : #accessing }
ESUGConcurrentDictionary >> do: aBlock [
	^ lock critical: [ dictionary do: aBlock ]
]

{ #category : #testing }
ESUGConcurrentDictionary >> includesKey: aKey [
	^ lock critical: [ dictionary includesKey: aKey ]
]

{ #category : #initialization }
ESUGConcurrentDictionary >> initialize [

	super initialize.
	lock := Monitor new
]

{ #category : #accessing }
ESUGConcurrentDictionary >> keys [
	^ lock critical: [ dictionary keys ]
]

{ #category : #accessing }
ESUGConcurrentDictionary >> keysAndValuesDo: aBlock [
	^ lock critical: [ dictionary keysAndValuesDo: aBlock ]
]

{ #category : #accessing }
ESUGConcurrentDictionary >> keysDo: aBlock [
	^ lock critical: [ dictionary keysDo: aBlock ]
]

{ #category : #removing }
ESUGConcurrentDictionary >> removeAll [
	^ lock
		critical: [self keys copy
				do: [:e | self removeKey: e]]
]

{ #category : #removing }
ESUGConcurrentDictionary >> removeKey: aKey [
	^ lock critical: 
		[ dictionary 
			removeKey: aKey ]
]

{ #category : #removing }
ESUGConcurrentDictionary >> removeKey: aKey ifAbsent: aBlock [ 
	^ lock critical: 
		[ dictionary 
			removeKey: aKey
			ifAbsent: aBlock ]
]

{ #category : #accessing }
ESUGConcurrentDictionary >> select: aBlock [
	^ lock critical: [ dictionary select: aBlock  ]
]

{ #category : #accessing }
ESUGConcurrentDictionary >> values [
	^ lock critical: [ dictionary values ]
]
