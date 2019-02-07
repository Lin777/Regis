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
