"
Abstract class of ESUG
"
Class {
	#name : #ESUGAbstractStore,
	#superclass : #Object,
	#category : #'ESUGApp-Database-Core'
}

{ #category : #actions }
ESUGAbstractStore class >> install [

	[ ESUGActiveRecord
		setStore: self new;
		warmUpAllClasses ] forkAt: Processor userBackgroundPriority named: 'loading new esug store'
]

{ #category : #actions }
ESUGAbstractStore >> abortChanges: anObject [
	self subclassResponsibility
]

{ #category : #accessing }
ESUGAbstractStore >> commit: aBlock [
	self subclassResponsibility
]

{ #category : #defaults }
ESUGAbstractStore >> defaultCacheSize [
	^ 10000
]

{ #category : #actions }
ESUGAbstractStore >> ensureDown [
]

{ #category : #actions }
ESUGAbstractStore >> ensureForClass: aClass [ 

	self subclassResponsibility
]

{ #category : #'instance creation' }
ESUGAbstractStore >> forClass: aClass [ 
	self subclassResponsibility
]

{ #category : #'delegated queries' }
ESUGAbstractStore >> forClass: aClass at: anId ifAbsent: aHandler [
	self subclassResponsibility
]

{ #category : #'delegated queries' }
ESUGAbstractStore >> forClass: aClass detect: aBlock ifFound: aHandler [
	self subclassResponsibility
]

{ #category : #'delegated queries' }
ESUGAbstractStore >> forClass: aClass detect: aBlock ifNone: aHandler [
	self subclassResponsibility
]

{ #category : #'delegated queries' }
ESUGAbstractStore >> forClass: aClass do: aBlock [
	self subclassResponsibility
]

{ #category : #'delegated queries' }
ESUGAbstractStore >> forClass: aClass findAll: aBlock [
	self subclassResponsibility
]

{ #category : #actions }
ESUGAbstractStore >> loadClass: aClass atId: anId [ 
	"Given a class and an Id, the store is expected to load a fresh copy of the object 
	from it's persistent medium'"
	self subclassResponsibility
]

{ #category : #actions }
ESUGAbstractStore >> removeObject: anObject [

	self subclassResponsibility
]

{ #category : #actions }
ESUGAbstractStore >> storeObject: anObject [

	self subclassResponsibility
]

{ #category : #actions }
ESUGAbstractStore >> updateObject: anObject [ 
	self subclassResponsibility
]
