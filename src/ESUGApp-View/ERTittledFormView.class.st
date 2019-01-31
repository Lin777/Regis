Class {
	#name : #ERTittledFormView,
	#superclass : #ERTittledView,
	#instVars : [
		'form',
		'callback'
	],
	#category : #'ESUGApp-View'
}

{ #category : #'as yet unclassified' }
ERTittledFormView class >> on: anAttendee withContent: aContent [
	| form |
	form := self new.
	form attendee: anAttendee.
	form content: aContent.
	form initializeForm.
	^ form
]

{ #category : #accessing }
ERTittledFormView >> callback: anObject [
	callback := anObject
]

{ #category : #accessing }
ERTittledFormView >> content: anObject [
	content := anObject
]

{ #category : #initialization }
ERTittledFormView >> initializeForm [
	form := attendee asComponent 
	addDecoration: MAValidationDecoration new;
	addDecoration: 
			(MDLMAFormDecoration 
				buttons: 
					(Array with: 
						#cancel -> 'Cancel'
						with: #save -> 'Accept'));
	 yourself
]

{ #category : #rendering }
ERTittledFormView >> renderPageOn: html [
	html render: form
]

{ #category : #accessing }
ERTittledFormView >> title [
	^ title
]
