Class {
	#name : #ERTestLoginController,
	#superclass : #ERTestControllers,
	#category : #'ESUGApp-Test'
}

{ #category : #tests }
ERTestLoginController >> testFindUserByEmailWhenUserExist [
	| anUser |
	self registerAttendee.
	anUser := ERController new
		findUserByEmail: ERTestControllers testAttendee email.
	self deny: anUser isNil
]

{ #category : #tests }
ERTestLoginController >> testFindUserByEmailWhenUserNotExist [
	| anUser |
	
	anUser := ERController new
		findUserByEmail: ERTestControllers testAttendee email.
	self assert: anUser isNil
]

{ #category : #tests }
ERTestLoginController >> testValidateLoginIfUserExist [
	| anUser |
	self registerAttendee.
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
