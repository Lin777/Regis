Class {
	#name : #ERBasicInformationView,
	#superclass : #ERTittledView,
	#instVars : [
		'form',
		'actionRegister',
		'dialog'
	],
	#category : #'ESUGApp-View'
}

{ #category : #'as yet unclassified' }
ERBasicInformationView class >> on: anAttendee withContent: aContent withAction: aBlock [
	| form |
	form := self new.
	form attendee: anAttendee.
	form content: aContent.
	form actionRegister: aBlock.
	^ form
]

{ #category : #'as yet unclassified' }
ERBasicInformationView class >> withAction: aBlock [
	| instance |
	instance := self new.
	instance actionRegister: aBlock.
	^ instance
]

{ #category : #accessing }
ERBasicInformationView >> actionRegister: anObject [
	actionRegister := anObject
]

{ #category : #actions }
ERBasicInformationView >> cancel [
	self returnToThePreviousState
]

{ #category : #actions }
ERBasicInformationView >> content: anObject [
	content := anObject
]

{ #category : #actions }
ERBasicInformationView >> renderAcceptButtonOn: html [
	self
		createColoredButton: 'Accept'
		with: actionRegister
		id: 'accept-change-affiliation'
		on: html
]

{ #category : #actions }
ERBasicInformationView >> renderButtons: html [
	self renderAcceptButtonOn: html.
	self renderCancelButtonOn: html
]

{ #category : #actions }
ERBasicInformationView >> renderCancelButtonOn: html [
	dialog := ERDialog new
		title: 'Cancel';
		message: 'Are you sure you want to cancel?';idClose: 'buttonClose';
		idOpen: 'cancelUser';
		okCallback: [ self cancel ].
	self
		createColoredAnchorButton: 'Cancel'
		id: 'cancelUser'
		on: html
]

{ #category : #actions }
ERBasicInformationView >> renderFormOn: html [
	html render: (ERBasicInformationForm on: attendee)
]

{ #category : #actions }
ERBasicInformationView >> renderPageOn: html [
	html form
		method: 'post';
		id: 'formAddUser';
		with: [ self renderFormOn: html.
			self renderButtons: html ].
	html render: dialog
]

{ #category : #actions }
ERBasicInformationView >> title [
	^ 'User'
]
