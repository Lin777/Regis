Class {
	#name : #StateContent,
	#superclass : #WAComponent,
	#instVars : [
		'content'
	],
	#category : #'ESUGApp-Views'
}

{ #category : #accessing }
StateContent >> content [
	^ content
]

{ #category : #accessing }
StateContent >> content: anObject [
	content := anObject
]

{ #category : #rendering }
StateContent >> renderContentOn: html [
	self subclassResponsibility 
]
