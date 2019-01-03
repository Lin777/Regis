Class {
	#name : #ERRegistrationController,
	#superclass : #ERController,
	#instVars : [
		'attendee'
	],
	#category : #'ESUGApp-Controllers'
}

{ #category : #accessing }
ERRegistrationController class >> attendee: anAtteendee [
	|controller|
	controller := self new.
	controller attendee: anAtteendee .
	^ controller 
]

{ #category : #accessing }
ERRegistrationController >> attendee [
	^ attendee
]

{ #category : #accessing }
ERRegistrationController >> attendee: anObject [
	attendee := anObject 
]

{ #category : #action }
ERRegistrationController >> convertToGroupManager [
	self attendee userAccount role: (Heap new add: 'groupManager'; yourself )
]

{ #category : #initialize }
ERRegistrationController >> initialize [
	super initialize.
	attendee := ERAttendee new.
]

{ #category : #action }
ERRegistrationController >> save [
	| attendeeResult |
	attendeeResult := ERUserAccount
		findUserByEmail: attendee userAccount email.
	attendeeResult
		ifNil: [ attendeeResult := self saveAttendee.
			attendeeResult userAccount isAttendee ifTrue: 
			[conference addAttendee: attendeeResult].
			conference save.
			^ attendeeResult userAccount ].
	^ nil
]

{ #category : #action }
ERRegistrationController >> saveAsGroupManager [
	self convertToGroupManager.
	^ self save
]

{ #category : #action }
ERRegistrationController >> saveAsGroupManagerOn: aConference [
	self convertToGroupManager.
	^ self saveOn: aConference 
]

{ #category : #action }
ERRegistrationController >> saveAttendee [
	| user |
	user := self attendee userAccount save.
	conference addUser: user.
	self attendee userAccount: user.
	^ self attendee save
]

{ #category : #action }
ERRegistrationController >> saveOn: aConference [
	| attendeeResult |
	attendeeResult := ERUserAccount
		findUserByEmail: attendee userAccount email.
	attendeeResult
		ifNil: [ | user |
			user := self attendee userAccount save.
			aConference addUser: user.
			self attendee userAccount: user.
			attendeeResult := self attendee save.
			aConference addAttendee: attendeeResult .
			aConference save.
			^ attendeeResult userAccount ].
	^ nil
]
