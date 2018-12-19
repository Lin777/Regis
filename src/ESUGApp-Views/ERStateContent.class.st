Class {
	#name : #ERStateContent,
	#superclass : #WAComponent,
	#instVars : [
		'content',
		'attendee'
	],
	#category : #'ESUGApp-Views'
}

{ #category : #accessing }
ERStateContent class >> content: aContent [
	| instance |
	instance := self new.
	instance content: aContent.
	^ instance
]

{ #category : #accessing }
ERStateContent >> content [
	^ content
]

{ #category : #accessing }
ERStateContent >> content: anObject [
	content := anObject.
	content state: self
]

{ #category : #rendering }
ERStateContent >> renderContentOn: html [
	self subclassResponsibility 
]
