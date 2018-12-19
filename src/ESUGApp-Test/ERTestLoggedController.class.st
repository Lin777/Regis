Class {
	#name : #ERTestLoggedController,
	#superclass : #ERTestControllers,
	#category : #'ESUGApp-Test'
}

{ #category : #tests }
ERTestLoggedController >> testGetAttendeeWhenUserExist [
	| anUserAccounRegistered anUser |
	anUserAccounRegistered := self registerAttendee .
	anUser := (ERLoggedController user: anUserAccounRegistered)
		attendeeFromUser.
	self deny: anUser isNil
]

{ #category : #tests }
ERTestLoggedController >> testGetAttendeeWhenUserNotExist [
	|anUser|
	anUser := (ERLoggedController
		user: ERTestControllers testUserAccount) attendeeFromUser.
	self assert: anUser isNil
]
