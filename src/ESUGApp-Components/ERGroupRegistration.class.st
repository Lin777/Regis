Class {
	#name : #ERGroupRegistration,
	#superclass : #ERTabContainerPage,
	#instVars : [
		'formRegister',
		'attenteeRegisterForm'
	],
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

{ #category : #accessing }
ERGroupRegistration >> attenteeRegisterForm: anObject [
	^ attenteeRegisterForm := anObject
]

{ #category : #actions }
ERGroupRegistration >> cancel [
	self returnToThePreviousState
]

{ #category : #initialization }
ERGroupRegistration >> initializeController [
	controller := ERGroupManagerViewController new attendee: attendee
]

{ #category : #initialization }
ERGroupRegistration >> initializeFormRegister [
	formRegister := (ERContainerTabsView
		content: content)
		tabView: (ERTabsView tabs: self tabs)
]

{ #category : #rendering }
ERGroupRegistration >> registerAttendee [
	content state: formRegister
]

{ #category : #rendering }
ERGroupRegistration >> registerAttendeeToGroupManager [
	| result |
	result := controller
		addAttendee: attenteeRegisterForm controller attendee.
	result
		ifNil: [ Transcript show: 'This email already registered' ]
		ifNotNil: [ content state: content lastState ]
]

{ #category : #rendering }
ERGroupRegistration >> returnToThePreviousState [
	content state: content lastState
]

{ #category : #accessing }
ERGroupRegistration >> tabs [
	attenteeRegisterForm
		ifNil: [ attenteeRegisterForm := ERAttendeeRegistrationView withAction: [ self registerAttendeeToGroupManager ] ].
	^ attenteeRegisterForm tabs
]
