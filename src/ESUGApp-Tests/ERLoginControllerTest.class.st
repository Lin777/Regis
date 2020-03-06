"
Description
--------------------

A ERTestLoginController is a test class for testing the behavior of Login Controller
"
Class {
	#name : #ERLoginControllerTest,
	#superclass : #ERTest,
	#category : #'ESUGApp-Tests-UnitTest'
}

{ #category : #tests }
ERLoginControllerTest >> testLoginWhenPasswordDontMatch [

	| anUser |
	self registerAttendee.
	anUser := controller conference validateLoginFor: self class testUserAccount email 
								password: (ERUserAccount hashPassword:
								 'anotherPassword') asString.
	self assert: anUser isNil
]

{ #category : #tests }
ERLoginControllerTest >> testLoginWhenUserExist [

	| anUser |
	self registerAttendee.
	anUser := controller conference validateLoginFor: self class testUserAccount email 
								password: (ERUserAccount hashPassword:
								 self class testUserAccount password) asString.
	self deny: anUser isNil
]

{ #category : #tests }
ERLoginControllerTest >> testLoginWhenUserNotExist [

	| anUser |
	anUser := controller conference validateLoginFor: ERTest testUserAccount email 
			password: (ERUserAccount hashPassword: '1234567') asString.
	self assert: anUser isNil
]
