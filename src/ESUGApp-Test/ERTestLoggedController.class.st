Class {
	#name : #ERTestLoggedController,
	#superclass : #ERTestControllers,
	#category : #'ESUGApp-Test'
}

{ #category : #tests }
ERTestLoggedController >> testGetAttendeeWhenUserExist [
	| anUserAccountRegistered anUser |
	anUserAccountRegistered := self registerAttendee.
	anUser := (ERLoggedController user: anUserAccountRegistered)
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
