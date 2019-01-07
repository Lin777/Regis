Class {
	#name : #ERTestAdminContainerController,
	#superclass : #ERTestControllers,
	#instVars : [
		'controller'
	],
	#category : #'ESUGApp-Test'
}

{ #category : #initialization }
ERTestAdminContainerController >> setUp [
	| user |
	super setUp.
	user := self registerAttendee.
	controller := ERAdminViewController new.
	controller attendee: (controller attendeeFromUser: user)
]

{ #category : #tests }
ERTestAdminContainerController >> testChangePasswordWhenTheCurrentPasswordDoesNotMatches [
	| result |
	result := controller
		changePasswordFrom: '87654321' asString
		to: '1234567890'.
	self assert: result isNil
]

{ #category : #tests }
ERTestAdminContainerController >> testChangePasswordWhenTheCurrentPasswordMatches [
	| result |
	result := controller changePasswordFrom:'12345678' asString to: '87654321'.
	self assert: result isNotNil
]

{ #category : #tests }
ERTestAdminContainerController >> testFailValidateCurrentPassword [
	self deny: (controller validateCurrentPassword: '87654321').
	self deny: (controller validateCurrentPassword: 'asdfghjk').
	self deny: (controller validateCurrentPassword: 'asdfg123').
]

{ #category : #tests }
ERTestAdminContainerController >> testFailValidatePatternPassword [
	self assert: (controller validatePatternPassword: '1234567').
	self assert: (controller validatePatternPassword: 'test').
	self assert: (controller validatePatternPassword: 'TEST2').
	self assert: (controller validatePatternPassword: '<test>123').
	self assert: (controller validatePatternPassword: ';as!2#$%%^@#').
	self assert: (controller validatePatternPassword: '.et~@#$^*').
	self assert: (controller validatePatternPassword: '1231234><').
	self assert: (controller validatePatternPassword: 'ASD.asd./asd').
	self assert: (controller validatePatternPassword: '.123_test_1.').
	self assert: (controller validatePatternPassword: '+qweweA234').
]

{ #category : #tests }
ERTestAdminContainerController >> testUpdateUser [
	| modifyUser |
	modifyUser := controller
		updateAttendee: ERTestControllers testModifyUser.
	self assert: modifyUser isNotNil
]

{ #category : #tests }
ERTestAdminContainerController >> testUpdateUserWithAEmailAlreadyRegistered [
	| modifyUser |
	self registerAttendee: ERTestControllers testExampleAttendee.
	modifyUser := controller
		updateUserFields: ERTestControllers testExampleAttendee userAccount.
	self assert: modifyUser isNil
]

{ #category : #tests }
ERTestAdminContainerController >> testValidChangePasswordTo [
	| user |
	user := controller changePasswordTo: 'test12345.6_78'.
	self assert: user password equals: 'test12345.6_78'.
]

{ #category : #tests }
ERTestAdminContainerController >> testValidateCurrentPassword [
	self assert: (controller validateCurrentPassword: '12345678').
]

{ #category : #tests }
ERTestAdminContainerController >> testValidatePatternPassword [
	self assert: (controller validatePatternPassword: '12345678').
	self assert: (controller validatePatternPassword: 'passtest').
	self assert: (controller validatePatternPassword: 'testPass').
	self assert: (controller validatePatternPassword: '123password').
	self assert: (controller validatePatternPassword: 'test1234567').
	self assert: (controller validatePatternPassword: 'test.128.test').
	self assert: (controller validatePatternPassword: '123_test.1234').
	self assert: (controller validatePatternPassword: 'test_1234.0983').
	self assert: (controller validatePatternPassword: '.123_test_1.').
	self assert: (controller validatePatternPassword: '_asd.test_123a').
]
