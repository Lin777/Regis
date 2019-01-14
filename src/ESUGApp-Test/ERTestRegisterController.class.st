Class {
	#name : #ERTestRegisterController,
	#superclass : #ERTestControllers,
	#category : #'ESUGApp-Test'
}

{ #category : #tests }
ERTestRegisterController >> testARegisteredAttendeeHasTheRoleOfAttendee [
	"check if the record has the role of attendee"

	| anAttendee |
	anAttendee := self registerAttendee.
	self assert: anAttendee isAttendee
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
ERTestRegisterController >> testAddAttendee [
	"when an attendee is successfully registered the same attendee is returned as a result"

	| anAttende |
	anAttende := self registerAttendee .
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
