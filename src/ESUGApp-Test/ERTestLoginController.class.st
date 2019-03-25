Class {
	#name : #ERTestLoginController,
	#superclass : #ERTest,
	#category : #'ESUGApp-Test-UnitTest'
}

{ #category : #tests }
ERTestLoginController >> testLoginWhenPasswordDontMatch [
	| anUser |
	self registerAttendee.
	anUser := controller validateLoginFor: self class testUserAccount email 
								password: (ERUserAccount hashPassword:
								 'anotherPassword') asString.
	self assert: anUser isNil
]

{ #category : #tests }
ERTestLoginController >> testLoginWhenUserExist [
	| anUser |
	self registerAttendee.
	anUser := controller validateLoginFor: self class testUserAccount email 
								password: (ERUserAccount hashPassword:
								 self class testUserAccount password) asString.
	self deny: anUser isNil
]

{ #category : #tests }
ERTestLoginController >> testLoginWhenUserNotExist [
	| anUser |
	anUser := controller validateLoginFor: ERTest testUserAccount email 
			password: (ERUserAccount hashPassword: '1234567') asString.
	self assert: anUser isNil
]
