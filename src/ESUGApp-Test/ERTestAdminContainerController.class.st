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
	controller := ERAdminController new.
	controller attendee: (controller attendeeFromUser: user)
]

{ #category : #tests }
ERTestAdminContainerController >> testFailValidateCurrentPassword [
	self deny: (controller validateCurrentPassword: '87654321').
	self deny: (controller validateCurrentPassword: 'asdfghjk').
	self deny: (controller validateCurrentPassword: 'asdfg123').
]

{ #category : #tests }
ERTestAdminContainerController >> testFailValidatePatternPassword [
	self deny: (controller validatePatternPassword: '1234567').
	self deny: (controller validatePatternPassword: 'test').
	self deny: (controller validatePatternPassword: 'TEST2').
	self deny: (controller validatePatternPassword: '<test>123').
	self deny: (controller validatePatternPassword: ';as!2#$%%^@#').
	self deny: (controller validatePatternPassword: '.et~@#$^*').
	self deny: (controller validatePatternPassword: '1231234><').
	self deny: (controller validatePatternPassword: 'ASD.asd./asd').
	self deny: (controller validatePatternPassword: '.123*test_1!').
	self deny: (controller validatePatternPassword: '+qweweA234').
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
	self registerAttendee: ERTestControllers testExampleAttendee.
	self
		should: [ controller
				updateUserFields: ERTestControllers testExampleAttendee userAccount ]
		raise: ERException
]

{ #category : #tests }
ERTestAdminContainerController >> testValidChangePasswordTo [
	| user |
	user := controller changePasswordTo: 'test12345.6_78'.
	self assert: user password equals: (ERUserAccount hashPassword: 'test12345.6_78').
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
