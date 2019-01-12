Class {
	#name : #ERGroupRegistration,
	#superclass : #ERTabContainerPage,
	#category : #'ESUGApp-Components'
}

{ #category : #'as yet unclassified' }
ERGroupRegistration class >> on: anAttendee withContent: aContent [
	| form |
	form := self new.
	form attendee: anAttendee.
	form content: aContent.
	form initializeController.
	form initializeFormRegister.
	^ form
]

{ #category : #actions }
ERGroupRegistration >> cancel [
	self returnToThePreviousState
]

{ #category : #initialization }
ERGroupRegistration >> initialize [
	super initialize.
]

{ #category : #initialization }
ERGroupRegistration >> initializeController [
	controller := ERGroupManagerViewController new attendee: attendee
]

{ #category : #rendering }
ERGroupRegistration >> registerAttendee [
	callback := [ self registerAttendeeToGroupManager ].
	super registerAttendee
]

{ #category : #rendering }
ERGroupRegistration >> registerAttendeeToGroupManager [
	| result |
	(ERRegistrationController attendee: newAttendee) validateRegister.
	result := controller addAttendee: newAttendee.
	content state: content lastState
]

{ #category : #rendering }
ERGroupRegistration >> returnToThePreviousState [
	content state: content lastState
]
