Class {
	#name : #ERTabContainerPage,
	#superclass : #ERTab,
	#instVars : [
		'messageComponent',
		'content',
		'controller'
	],
	#category : #'ESUGApp-Components'
}

{ #category : #'as yet unclassified' }
ERTabContainerPage class >> on: anAttendee withContent: aContent [
	| form |
	form := self new.
	form attendee: anAttendee.
	form content: aContent .
	^ form
]

{ #category : #accessing }
ERTabContainerPage >> content [
	^ content
]

{ #category : #accessing }
ERTabContainerPage >> content: anObject [
	content := anObject
]

{ #category : #accessing }
ERTabContainerPage >> controller [
	^ controller
]

{ #category : #accessing }
ERTabContainerPage >> controller: anObject [
	controller := anObject
]

{ #category : #rendering }
ERTabContainerPage >> renderContainer: html [
	self subclassResponsibility 
]

{ #category : #rendering }
ERTabContainerPage >> renderContentOn: html [
	html heading level3; with: self title .
	self renderContainer: html
]

{ #category : #accessing }
ERTabContainerPage >> title [
	self subclassResponsibility 
]
