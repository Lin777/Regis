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

{ #category : #accessing }
ERGroupRegistrationTab >> attends [
	^ (ERGroupManagerController new groupOfAttendee: attendee)
		listAttends
]

{ #category : #actions }
ERGroupRegistrationTab >> cancel [
	self returnToThePreviousState
]

{ #category : #accessing }
ERGroupRegistrationTab >> group [
	^ (ERGroupManagerController new groupOfAttendee: attendee)
		
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
	(ERRegistrationController attendee: newAttendee) validateRegister.
	controller addAttendee: newAttendee.
	content state: content lastState
]

{ #category : #rendering }
ERGroupRegistrationTab >> returnToThePreviousState [
	content state: content lastState.
	self updateStateTab: self tabName.
]
