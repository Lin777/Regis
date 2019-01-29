Class {
	#name : #ERForm,
	#superclass : #ERComponentFactory,
	#instVars : [
		'form'
	],
	#category : #'ESUGApp-Form'
}

{ #category : #'instance creation' }
ERForm class >> on: anAttendee [
	| form |
	form := self new.
	form attendee: anAttendee.
	form initializeForm.
	^ form
]

{ #category : #'as yet unclassified' }
ERForm >> formId [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
ERForm >> formName [
	self subclassResponsibility 
]

{ #category : #initialization }
ERForm >> initializeForm [
	self subclassResponsibility .
]
