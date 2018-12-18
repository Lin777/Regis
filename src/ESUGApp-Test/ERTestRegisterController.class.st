Class {
	#name : #ERTestRegisterController,
	#superclass : #ERTestControllers,
	#category : #'ESUGApp-Test'
}

{ #category : #tests }
ERTestRegisterController >> testARegisteredAttendeeHasTheRoleOfAttendee [
	"check if the record has the role of attendee"

	| anAttendee |
	anAttendee := (ERRegistrationController
		attendee: ERTestControllers testAttendee) save.
	self assert: anAttendee role = 'attendee'
]

{ #category : #tests }
ERTestRegisterController >> testARegisteredGroupManagerHasTheRoleOfGroupManager [
	"check if the record has the role of group manager"

	| aGroupManager |
	aGroupManager := (ERRegistrationController
		attendee: ERTestControllers testGroupManager)
		saveAsGroupManager.
	self assert: aGroupManager role = 'groupManager'
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
	anAttende := (ERRegistrationController
		attendee: ERTestControllers testAttendee) save.
	self deny: anAttende isNil
]

{ #category : #tests }
ERTestRegisterController >> testAddExitentAttendee [
	"When an assistant's email has already been registered it can not be registered again, therefore a nil is returned "

	| anAttende |
	(ERRegistrationController
		attendee: ERTestControllers testAttendee) save.
	anAttende := (ERRegistrationController
		attendee: ERTestControllers testAttendee) save.
	self assert: anAttende isNil
]
