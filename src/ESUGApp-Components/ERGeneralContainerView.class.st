Class {
	#name : #ERGeneralContainerView,
	#superclass : #ERContainerView,
	#instVars : [
		'title',
		'cancelCallback'
	],
	#category : #'ESUGApp-Components'
}

{ #category : #'as yet unclassified' }
ERGeneralContainerView class >> on: anAttendee withContent: aContent [
	| form |
	form := self new.
	form attendee: anAttendee.
	form content: aContent.
	^ form
]

{ #category : #accessing }
ERGeneralContainerView >> cancelCallback: anObject [
	cancelCallback := anObject
]

{ #category : #rendering }
ERGeneralContainerView >> renderContentPage: html [
	html heading level3 with: self title.
	html horizontalRule.
	self renderPageOn: html
]

{ #category : #rendering }
ERGeneralContainerView >> renderPageOn: html [
	self subclassResponsibility 
]

{ #category : #accessing }
ERGeneralContainerView >> title: anObject [
	title := anObject
]
