"
Description
--------------------

I am an abstract component for content with a Title. My subclasses represent the main content of the page.
"
Class {
	#name : #ERTittledView,
	#superclass : #ERContainer,
	#instVars : [
		'title',
		'cancelCallback',
		'controller'
	],
	#category : #'ESUGApp-View-View'
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

{ #category : #accessing }
ERTittledView >> controller [
	^ controller 
]

{ #category : #accessing }
ERTittledView >> controller: anObject [
	controller := anObject
]

{ #category : #initialization }
ERTittledView >> initialize [ 	
	super initialize.
	controller := ERController new.
]

{ #category : #rendering }
ERTittledView >> renderContentPageOn: html [
	html heading level3 with: self title.
	html horizontalRule.
	self renderPageOn: html
]

{ #category : #rendering }
ERTittledView >> renderPageOn: html [
	self subclassResponsibility 
]

{ #category : #accessing }
ERTittledView >> title [
	self subclassResponsibility 
]

{ #category : #accessing }
ERTittledView >> title: anObject [
	title := anObject
]
