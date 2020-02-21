"
Abstract class of ESUG
"
Class {
	#name : #ESUGAbstractStore,
	#superclass : #Object,
	#category : #'ESUGApp-Database-Store'
}

{ #category : #actions }
ESUGAbstractStore class >> install [

	[ ESUGActiveRecord
		setStore: self new;
		warmUpAllClasses ] forkAt: Processor userBackgroundPriority named: 'loading new esug store'
]

{ #category : #actions }
ESUGAbstractStore >> removeObject: anObject [

	self subclassResponsibility
]

{ #category : #actions }
ESUGAbstractStore >> storeObject: anObject [

	self subclassResponsibility
]
