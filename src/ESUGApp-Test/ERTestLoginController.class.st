Class {
	#name : #ERTestLoginController,
	#superclass : #ERTestControllers,
	#category : #'ESUGApp-Test'
}

{ #category : #tests }
ERTestLoginController >> testFindUserByEmailWhenUserExist [
	| anUser |
	(ERRegistrationController
		attendee: ERTestControllers testAttendee) save.
	anUser := ERUserAccount
		findUserByEmail: ERTestControllers testAttendee email.
	self deny: anUser isNil
]

{ #category : #tests }
ERTestLoginController >> testFindUserByEmailWhenUserNotExist [
	| anUser |
	
	anUser := ERUserAccount
		findUserByEmail: ERTestControllers testAttendee email.
	self assert: anUser isNil
]

{ #category : #tests }
ERTestLoginController >> testValidateLoginIfUserExist [
	| anUser |
	(ERRegistrationController
		attendee: ERTestControllers testAttendee) save.
	anUser := (ERLoginController
		user: ERTestControllers testUserAccount) validateLogin.
	self deny: anUser isNil
]

{ #category : #tests }
ERTestLoginController >> testValidateLoginIfUserNotExist [
	| anUser |
	anUser := (ERLoginController
		user: ERTestControllers testUserAccount) validateLogin.
	self assert: anUser isNil
]
