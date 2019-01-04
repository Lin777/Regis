Class {
	#name : #ERContainerBasicInformation,
	#superclass : #ERGeneralContainerView,
	#instVars : [
		'form',
		'actionRegister'
	],
	#category : #'ESUGApp-Components'
}

{ #category : #'as yet unclassified' }
ERContainerBasicInformation class >> on: anAttendee withContent: aContent withAction: aBlock [
	| form |
	form := self new.
	form attendee: anAttendee.
	form content: aContent.
	form actionRegister: aBlock.
	^ form
]

{ #category : #'as yet unclassified' }
ERContainerBasicInformation class >> withAction: aBlock [
	| instance |
	instance := self new.
	instance actionRegister: aBlock.
	^ instance
]

{ #category : #accessing }
ERContainerBasicInformation >> actionRegister: anObject [
	actionRegister := anObject
]

{ #category : #actions }
ERContainerBasicInformation >> cancel [
	self returnToThePreviousState
]

{ #category : #actions }
ERContainerBasicInformation >> content: anObject [
	content := anObject
]

{ #category : #actions }
ERContainerBasicInformation >> renderAcceptButtonOn: html [
	self
		createColoredButton: 'Accept'
		with: actionRegister
		id: 'accept-change-affiliation'
		on: html
]

{ #category : #actions }
ERContainerBasicInformation >> renderButtons: html [
	self renderAcceptButtonOn: html.
	self renderCancelButtonOn: html
]

{ #category : #actions }
ERContainerBasicInformation >> renderCancelButtonOn: html [
	self
		createColoredAnchorButton: 'Cancel'
		with: [ self cancel ]
		id: 'cancel-change-affiliation'
		on: html
]

{ #category : #actions }
ERContainerBasicInformation >> renderFormOn: html [
	html render: (ERBasicInformation on: attendee)
]

{ #category : #actions }
ERContainerBasicInformation >> renderPageOn: html [
	html form
		method: 'post';
		id: 'formAddUser';
		with: [ self renderFormOn: html.
			self renderButtons: html ]
]

{ #category : #actions }
ERContainerBasicInformation >> title [
	^ 'User'
]
