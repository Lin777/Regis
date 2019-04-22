"
Description
--------------------

A ERTestLoggedController is a test class for testing the behavior of Logged Controller
"
Class {
	#name : #ERTestLoggedController,
	#superclass : #ERTest,
	#category : #'ESUGApp-Test-UnitTest'
}

{ #category : #tests }
ERTestLoggedController >> setUp [
	| user |
	super setUp.
	user := self registerAttendee.
	controller := ERLoggedController attendee: user
]

{ #category : #tests }
ERTestLoggedController >> testFailValidateCurrentPassword [
	self should: [ controller validateCurrentPassword: '87654321'] raise: ERException.
	self should: [ controller validateCurrentPassword: 'asdfghjk'] raise: ERException.
	self should: [ controller validateCurrentPassword: 'asdfg123'] raise: ERException
]

{ #category : #tests }
ERTestLoggedController >> testFailValidatePatternPassword [
	self should: [ controller validateCurrentPassword: '1234567'] raise: ERException.
	self should: [ controller validateCurrentPassword: 'test'] raise: ERException.
	self should: [ controller validateCurrentPassword: 'TEST2'] raise: ERException.
	self should: [ controller validateCurrentPassword: '<test>123'] raise: ERException.
	self should: [ controller validateCurrentPassword: ';as!2#$%%^@#'] raise: ERException.
	self should: [ controller validateCurrentPassword: '.et~@#$^*'] raise: ERException.
	self should: [ controller validateCurrentPassword: '1231234><'] raise: ERException.
	self should: [ controller validateCurrentPassword: 'ASD.asd./asd'] raise: ERException.
	self should: [ controller validateCurrentPassword: '.123*test_1!'] raise: ERException.
	self should: [ controller validateCurrentPassword: '+qweweA234'] raise: ERException.
]

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

{ #category : #tests }
ERTestLoggedController >> testUpdateUserWithAEmailAlreadyRegistered [
	self registerAttendee: ERTest testExampleAttendee.
	self
		should: [ controller
				updateUser: (controller attendee email: 'admin@esug.org') ]
		raise: ERException .
	self
		should: [ controller
				updateUser: (controller attendee email: 'example@gmail.com') ]
		raise: ERException 
]

{ #category : #tests }
ERTestLoggedController >> testValidChangePasswordTo [
	| user |
	user := controller changePasswordTo: 'test12345.6_78'.
	self assert: user password equals: (ERUserAccount hashPassword: 'test12345.6_78').
]

{ #category : #tests }
ERTestLoggedController >> testValidateCurrentPassword [
	self shouldnt: [ controller validateCurrentPassword: '12345678'] raise: ERException
]

{ #category : #tests }
ERTestLoggedController >> testValidatePatternPassword [
	self shouldnt: [ controller validatePatternPassword:  '12345678'] raise: ERException.
	self shouldnt: [ controller validatePatternPassword: 'passtest'] raise: ERException.
	self shouldnt: [ controller validatePatternPassword: 'testPass'] raise: ERException.
	self shouldnt: [ controller validatePatternPassword: '123password'] raise: ERException.
	self shouldnt: [ controller validatePatternPassword: 'test1234567'] raise: ERException.
	self shouldnt: [ controller validatePatternPassword: 'test.128.test'] raise: ERException.
	self shouldnt: [ controller validatePatternPassword: '123_test.1234'] raise: ERException.
	self shouldnt: [ controller validatePatternPassword: 'test_1234.0983'] raise: ERException.
	self shouldnt: [ controller validatePatternPassword: '.123_test_1.'] raise: ERException.
	self shouldnt: [ controller validatePatternPassword: '_asd.test_123a'] raise: ERException
]
