"
I am an Observer class 
"
Class {
	#name : #ERObserver,
	#superclass : #Object,
	#instVars : [
		'subject'
	],
	#category : #'ESUGApp-Core'
}

{ #category : #accessing }
ERObserver >> subject: anObject [
	subject := anObject.
	subject addObserver: self
]

{ #category : #updating }
ERObserver >> update [ 
	self subclassResponsibility 
]
