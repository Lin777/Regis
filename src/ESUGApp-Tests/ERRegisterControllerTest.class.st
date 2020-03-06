"
Description
--------------------

A ERTestRegisterController is a test class for testing the behavior of ERRegisterController
"
Class {
	#name : #ERRegisterControllerTest,
	#superclass : #ERTest,
	#instVars : [
		'attendee'
	],
	#category : #'ESUGApp-Tests-UnitTest'
}

{ #category : #running }
ERRegisterControllerTest >> setUp [

	super setUp.
	controller:= ERRegistrationController new.
]

{ #category : #tests }
ERRegisterControllerTest >> testAddExitentAttendee [
	"When an assistant's email has already been registered it can not be registered again, therefore a nil is returned "

	self registerAttendee.
	self should: [ self registerAttendee ] raise: ERException 
]

{ #category : #tests }
ERRegisterControllerTest >> testAddExitentGroupManager [
	"When an group manager's email has already been registered it can not be registered again, therefore a nil is returned "
	
	self registerAttendee: (self class testAttendee: 'groupManager@gmail.com').
	self should: [ self registerAsGroupManager ] raise: ERException 
]

{ #category : #tests }
ERRegisterControllerTest >> testRegisterAttendee [

	| userSaved |
	controller attendee: self class testAttendee.
	userSaved := controller saveAttendee.
	self assert: (userSaved role first) equals: 'attendee'.
	controller conference 
	
	
	
]

{ #category : #tests }
ERRegisterControllerTest >> testRegisterGroupManager [

	| userSaved |
	controller attendee: self class testGroupManager.
	userSaved := controller saveGroupManager.
	self assert: (userSaved role first) equals: 'groupManager'.
]

{ #category : #tests }
ERRegisterControllerTest >> testValidateIfEmailIsAlreadyRegistered [

	self registerAttendee.
	self
		should: [ controller conference validateIfEmailIsAlreadyRegistered: 
					self class testUserAccount ]
		raise: ERException.
]

{ #category : #tests }
ERRegisterControllerTest >> testValidateRegister [

	self registerAttendee.
	self
		should: [ controller validateRegister: 
					self class testAttendee ]
		raise: ERException.
]

{ #category : #tests }
ERRegisterControllerTest >> testValidateRegisterWhenEmailAlreadyRegistered [

	self registerAttendee.
	controller validateRegister: self class testAttendee.
]
