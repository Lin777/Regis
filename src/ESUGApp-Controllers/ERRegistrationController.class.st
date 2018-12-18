Class {
	#name : #ERRegistrationController,
	#superclass : #Object,
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
	self attendee userAccount role: 'groupManager'
]

{ #category : #initialize }
ERRegistrationController >> initialize [
	super initialize.
	attendee := ERAttendee new.
]

{ #category : #action }
ERRegistrationController >> save [
	| attendeeResult |
	attendeeResult := ERUserAccount findUserByEmail: attendee userAccount email.
	attendeeResult
		ifNil: [ | user |
			user := self attendee userAccount save.
			self attendee userAccount: user.
			attendeeResult := self attendee save.
			^ attendeeResult userAccount ].
	^ nil
]

{ #category : #action }
ERRegistrationController >> saveAsGroupManager [
"	| attendeeResult group |"
	self convertToGroupManager .
	"attendeeResult := ERUserAccount findUserByEmail: attendee userAccount email.
	attendeeResult
		ifNil: [ | user |
			user := self attendee userAccount save.
			self attendee userAccount: user.
			attendeeResult := self attendee save.
			group := ERGroup groupManager: attendeeResult .
			group save.
			^ attendeeResult userAccount ].
	^ nil"
	^ self save
]
