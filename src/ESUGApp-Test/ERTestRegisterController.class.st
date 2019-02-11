Class {
	#name : #ERTestRegisterController,
	#superclass : #ERTestControllers,
	#instVars : [
		'controller',
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
ERTestRegisterController >> testARegisteredGroupManagerHasTheRoleOfGroupManager [
	"check if the record has the role of group manager"

	| aGroupManager |
	aGroupManager := (ERRegistrationController
		attendee: ERTestControllers testGroupManager)
		saveAsGroupManager.
	self assert: aGroupManager isGroupManager 
]

{ #category : #tests }
ERTestRegisterController >> testAddAGroupManager [
	"when an group manager is successfully registered the same group manager is returned as a result"

	| anAttende |
	anAttende := (ERRegistrationController
		attendee: ERTestControllers testGroupManager)
		saveAsGroupManager.
	self deny: anAttende isNil
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
		saveAsGroupManager. ] raise: ERException 
]

{ #category : #tests }
ERTestRegisterController >> testRegisterAttendee [
	|userSaved|
	controller := ERRegistrationController new attendee: self class testAttendee.
	userSaved := controller saveAttendee.
	self assert: (userSaved role first) equals: 'attendee'.
	controller conference 
	
	
	
]

{ #category : #tests }
ERTestRegisterController >> testRegisterGroupManager [
	|userSaved|
	controller := ERRegistrationController new attendee: self class testGroupManager.
	userSaved := controller saveGroupManager.
	self assert: (userSaved role first) equals: 'groupManager'.
	
	
	
]

{ #category : #tests }
ERTestRegisterController >> testValidateRegister [
	attendee := (ERTestControllers testAttendee) .
	controller attendee: attendee.
]
