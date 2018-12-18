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
		getAttendee.
	self deny: anUser isNil
]

{ #category : #tests }
ERTestLoggedController >> testGetAttendeeWhenUserNotExist [
	|anUser|
	anUser := (ERLoggedController
		user: ERTestControllers testUserAccount) getAttendee.
	self assert: anUser isNil
]
