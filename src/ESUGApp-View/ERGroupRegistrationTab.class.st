Class {
	#name : #ERGroupRegistrationTab,
	#superclass : #ERContainerTab,
	#category : #'ESUGApp-View-Tab'
}

{ #category : #'as yet unclassified' }
ERGroupRegistrationTab class >> on: anAttendee withContent: aContent container: aContainer [
	| form |
	form := super on: anAttendee withContent: aContent.
	form initializeController.
	form initializeFormRegister.
	form container: aContainer.
	^ form
]

{ #category : #actions }
ERGroupRegistrationTab >> cancel [
	self returnToThePreviousState
]

{ #category : #initialization }
ERGroupRegistrationTab >> initialize [
	super initialize.
]

{ #category : #initialization }
ERGroupRegistrationTab >> initializeController [
	controller := ERGroupManagerController new attendee: attendee
]

{ #category : #rendering }
ERGroupRegistrationTab >> registerAttendee [
	callback := [ self registerAttendeeToGroupManager ].
	super registerAttendee.
	self updateStateTab: self tabName
]

{ #category : #rendering }
ERGroupRegistrationTab >> registerAttendeeToGroupManager [
	| result |
	(ERRegistrationController attendee: newAttendee) validateRegister.
	result := controller addAttendee: newAttendee.
	content state: content lastState
]

{ #category : #rendering }
ERGroupRegistrationTab >> returnToThePreviousState [
	content state: content lastState.
	self updateStateTab: self tabName.
]
