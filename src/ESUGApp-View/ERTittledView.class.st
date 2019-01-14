Class {
	#name : #ERTittledView,
	#superclass : #ERContainer,
	#instVars : [
		'title',
		'cancelCallback'
	],
	#category : #'ESUGApp-View'
}

{ #category : #'as yet unclassified' }
ERTittledView class >> on: anAttendee withContent: aContent [
	| form |
	form := self new.
	form attendee: anAttendee.
	form content: aContent.
	^ form
]

{ #category : #accessing }
ERTittledView >> cancelCallback: anObject [
	cancelCallback := anObject
]

{ #category : #rendering }
ERTittledView >> renderContentPage: html [
	html heading level3 with: self title.
	html horizontalRule.
	self renderPageOn: html
]

{ #category : #rendering }
ERTittledView >> renderPageOn: html [
	self subclassResponsibility 
]

{ #category : #accessing }
ERTittledView >> title: anObject [
	title := anObject
]
