Class {
	#name : #ERGroupRegistrationTab,
	#superclass : #ERContainerTab,
	#instVars : [
		'newAttendee'
	],
	#category : #'ESUGApp-View-Tab'
}

{ #category : #'as yet unclassified' }
ERGroupRegistrationTab class >> on: anAttendee withContent: aContent container: aContainer [
	| form |
	form := self on: anAttendee withContent: aContent.
	form initializeController.
	form initializeFormRegister.
	form container: aContainer.
	^ form
]

{ #category : #accessing }
ERGroupRegistrationTab >> attends [
	^ (ERGroupManagerController new groupOfUser: attendee)
		listAttends
]

{ #category : #actions }
ERGroupRegistrationTab >> cancel [
	self returnToThePreviousState
]

{ #category : #accessing }
ERGroupRegistrationTab >> group [
	^ (ERGroupManagerController new groupOfUser: attendee)
		
]

{ #category : #accessing }
ERGroupRegistrationTab >> groupManager [ 
	^ self group groupManager 
		
]

{ #category : #initialization }
ERGroupRegistrationTab >> initializeController [
	controller := ERGroupManagerController new.
	controller group: (controller groupOfUser: attendee)
]

{ #category : #rendering }
ERGroupRegistrationTab >> initializeFormRegister [
	newAttendee := (ERAttendee new) affiliationInformation: (self groupManager affiliationInformation).
	formRegister := ERContainerTabs
		formRegisterOn: newAttendee
		withCallback: callback
		content: content
]

{ #category : #accessing }
ERGroupRegistrationTab >> listAttendees [ 
	^ self group listAttends  
		
]

{ #category : #accessing }
ERGroupRegistrationTab >> paymentInformation [ 
	^ self group paymentInformation   
		
]

{ #category : #rendering }
ERGroupRegistrationTab >> registerAttendee [
	callback := [ :att | self registerAttendeeToGroupManager: att ].
	self initializeFormRegister.
	content state: formRegister.
	self updateStateTab: self tabName
]

{ #category : #rendering }
ERGroupRegistrationTab >> registerAttendeeToGroupManager: anAttendee [
	controller addAttendee: newAttendee.
	content state: content lastState.
	self updateStateTab: self tabName
]

{ #category : #rendering }
ERGroupRegistrationTab >> returnToThePreviousState [
	content state: content lastState.
	self updateStateTab: self tabName.
]
