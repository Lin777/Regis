Class {
	#name : #ERTestRegisterController,
	#superclass : #ERTestControllers,
	#instVars : [
		'attendee'
	],
	#category : #'ESUGApp-Test'
}

{ #category : #tests }
ERTestRegisterController >> setUp [
	super setUp.
	controller:= ERRegistrationController new.
]

{ #category : #tests }
ERTestRegisterController >> testAddExitentAttendee [
	"When an assistant's email has already been registered it can not be registered again, therefore a nil is returned "

	self registerAttendee.
	self should: [ self registerAttendee  ] raise: ERException 
]

{ #category : #tests }
ERTestRegisterController >> testAddExitentGroupManager [
	"When an group manager's email has already been registered it can not be registered again, therefore a nil is returned "
	
	self registerAttendee.
	
	self should: [ (ERRegistrationController
		attendee: ERTestControllers testGroupManager)
		saveGroupManager. ] raise: ERException 
]

{ #category : #tests }
ERTestRegisterController >> testRegisterAttendee [
	|userSaved|
	controller attendee: self class testAttendee.
	userSaved := controller saveAttendee.
	self assert: (userSaved role first) equals: 'attendee'.
	controller conference 
	
	
	
]

{ #category : #tests }
ERTestRegisterController >> testRegisterGroupManager [
	|userSaved|
	controller attendee: self class testGroupManager.
	userSaved := controller saveGroupManager.
	self assert: (userSaved role first) equals: 'groupManager'.
	
	
	
]

{ #category : #tests }
ERTestRegisterController >> testValidateIfEmailIsAlreadyRegistered [
	self registerAttendee.
	self
		should: [controller validateIfEmailIsAlreadyRegistered: 
					self class testUserAccount]
		raise: ERException.
]

{ #category : #tests }
ERTestRegisterController >> testValidateRegister [
	self registerAttendee .
	self
		should: [ controller validateRegister: 
					self class testAttendee ]
		raise: ERException.
	
]

{ #category : #tests }
ERTestRegisterController >> testValidateRegisterWhenEmailAlreadyRegistered [
	self registerAttendee .
	controller validateRegister: self class testAttendee .
]
