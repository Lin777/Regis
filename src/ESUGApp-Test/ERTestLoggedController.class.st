Class {
	#name : #ERTestLoggedController,
	#superclass : #ERTest,
	#category : #'ESUGApp-Test-UnitTest'
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
		user: ERTest testUserAccount) attendeeFromUser.
	self assert: anUser isNil
]
