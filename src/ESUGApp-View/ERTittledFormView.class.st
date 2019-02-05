Class {
	#name : #ERTittledFormView,
	#superclass : #ERTittledView,
	#instVars : [
		'form',
		'callback',
		'messageComponent',
		'dialog'
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

{ #category : #initialization }
ERTittledFormView >> cancelForm [
	form cancel.
	cancelCallback value
]

{ #category : #accessing }
ERTittledFormView >> content: anObject [
	content := anObject
]

{ #category : #initialization }
ERTittledFormView >> initialize [
	super initialize.
	messageComponent := ERAlert warningAlert id: 'formAlert'.
]

{ #category : #rendering }
ERTittledFormView >> initializeDialog [ 
	dialog := ERDialog cancelDialog 
		idOpen: 'cancel';
		okCallback: [self cancelForm] 
]

{ #category : #initialization }
ERTittledFormView >> initializeForm [
	form := attendee asComponent 
	addDecoration: MAValidationDecoration new;"
	addDecoration: 
			(MDLMAFormDecoration 
				buttons: 
					(Array with: 
						cancelCallback -> 'Cancel'
						with: callback -> 'Accept'));"
	 yourself
]

{ #category : #rendering }
ERTittledFormView >> renderAcceptButtonOn: html [
	self
		createColoredButton: 'Accept'
		with: [ self saveForm ] 
		id: 'accept-change-affiliation'
		on: html
]

{ #category : #rendering }
ERTittledFormView >> renderCancelButtonOn: html [
	self initializeDialog .
	self
		createColoredAnchorButton: 'Cancel'
		id: 'cancel'
		on: html
]

{ #category : #rendering }
ERTittledFormView >> renderPageOn: html [
	html form: [ 
	html render: messageComponent .
	html render: form.
	self renderCancelButtonOn: html.
	self renderAcceptButtonOn: html.
	html render: dialog]
]

{ #category : #initialization }
ERTittledFormView >> saveForm [
	[|object|
	"self halt."
	object := form save.
	callback cull: object model]
	on: ERException 
	do:  [ :exception | 
			messageComponent errorMessage: exception messageText ]
]

{ #category : #accessing }
ERTittledFormView >> title [
	^ title
]
