Class {
	#name : #ERTestLoggedController,
	#superclass : #ERTest,
	#category : #'ESUGApp-Test-UnitTest'
}

{ #category : #tests }
ERTestLoggedController >> testGetAttendeeWhenUserExist [
	self
		shouldnt: [
			| anUserAccountRegistered |
	anUserAccountRegistered := self registerAttendee.
	(ERLoggedController user: anUserAccountRegistered)
		attendeeFromUser]
		raise: ERException.
]

{ #category : #tests }
ERTestLoggedController >> testGetAttendeeWhenUserNotExist [
	self
		should: [
			(ERLoggedController user: ERTest testUserAccount) attendeeFromUser]
		raise: ERException.
]
