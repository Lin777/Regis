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
