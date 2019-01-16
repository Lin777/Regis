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
	| wasHandled  |
	wasHandled := false.
	attendee := (ERTestControllers testAttendee) .
	controller attendee: attendee.
	[controller validateRegister] 
		on: ERException 
		do: [:exception | wasHandled := true.
			exception return] .
	self deny: wasHandled
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
ERTestRegisterController >> testValidateAttendeeWithEmptyEmail [
	| wasHandled  |
	wasHandled := false.
	attendee := (ERTestControllers testAttendee) email: ''; yourself .
	controller attendee: attendee.
	[controller validateRegister] 
		on: ERException 
		do: [:exception | wasHandled := true.
			exception return] .
	self assert: wasHandled
]

{ #category : #tests }
ERTestRegisterController >> testValidateAttendeeWithEmptyFirstName [
	| wasHandled  |
	wasHandled := false.
	attendee := (ERTestControllers testAttendee) firstName: ''; yourself .
	controller attendee: attendee.
	[controller validateRegister] 
		on: ERException 
		do: [:exception | wasHandled := true.
			exception return] .
	self assert: wasHandled
]

{ #category : #tests }
ERTestRegisterController >> testValidateAttendeeWithEmptyLastName [
	| wasHandled  |
	wasHandled := false.
	attendee := (ERTestControllers testAttendee) lastName: ''; yourself .
	controller attendee: attendee.
	[controller validateRegister] 
		on: ERException 
		do: [:exception | wasHandled := true.
			exception return] .
	self assert: wasHandled
]

{ #category : #tests }
ERTestRegisterController >> testValidateAttendeeWithEmptyOrganizationCity [
	| wasHandled  |
	wasHandled := false.
	attendee := (ERTestControllers testAttendee) orgCity: ''; yourself .
	controller attendee: attendee.
	[controller validateRegister] 
		on: ERException 
		do: [:exception | wasHandled := true.
			exception return] .
	self assert: wasHandled
]

{ #category : #tests }
ERTestRegisterController >> testValidateAttendeeWithEmptyOrganizationName [
	| wasHandled  |
	wasHandled := false.
	attendee := (ERTestControllers testAttendee) orgName: ''; yourself .
	controller attendee: attendee.
	[controller validateRegister] 
		on: ERException 
		do: [:exception | wasHandled := true.
			exception return] .
	self assert: wasHandled
]

{ #category : #tests }
ERTestRegisterController >> testValidateAttendeeWithEmptyOrganizationPostal [
	| wasHandled  |
	wasHandled := false.
	attendee := (ERTestControllers testAttendee) orgPostal: ''; yourself .
	controller attendee: attendee.
	[controller validateRegister] 
		on: ERException 
		do: [:exception | wasHandled := true.
			exception return] .
	self assert: wasHandled
]

{ #category : #tests }
ERTestRegisterController >> testValidateAttendeeWithEmptyOrganizationProvince [
	| wasHandled  |
	wasHandled := false.
	attendee := (ERTestControllers testAttendee) orgProvince: ''; yourself .
	controller attendee: attendee.
	[controller validateRegister] 
		on: ERException 
		do: [:exception | wasHandled := true.
			exception return] .
	self assert: wasHandled
]

{ #category : #tests }
ERTestRegisterController >> testValidateAttendeeWithEmptyPostal [
	| wasHandled  |
	wasHandled := false.
	attendee := (ERTestControllers testAttendee) postal: ''; yourself .
	controller attendee: attendee.
	[controller validateRegister] 
		on: ERException 
		do: [:exception | wasHandled := true.
			exception return] .
	self assert: wasHandled
]

{ #category : #tests }
ERTestRegisterController >> testValidateAttendeeWithEmptyProvince [
	| wasHandled  |
	wasHandled := false.
	attendee := (ERTestControllers testAttendee) province: ''; yourself .
	controller attendee: attendee.
	[controller validateRegister] 
		on: ERException 
		do: [:exception | wasHandled := true.
			exception return] .
	self assert: wasHandled
]

{ #category : #tests }
ERTestRegisterController >> testValidateAttendeeWithInvalidMembershipType [
	| wasHandled  |
	wasHandled := false.
	attendee := (ERTestControllers testAttendee) membershipType: 'invalid'; yourself .
	controller attendee: attendee.
	[controller validateRegister] 
		on: ERException 
		do: [:exception | wasHandled := true.
			exception return] .
	self assert: wasHandled
]

{ #category : #tests }
ERTestRegisterController >> testValidateAttendeeWithInvalidPaymentType [
	| wasHandled  |
	wasHandled := false.
	attendee := (ERTestControllers testAttendee) paymentType: 'invalid'; yourself .
	controller attendee: attendee.
	[controller validateRegister] 
		on: ERException 
		do: [:exception | wasHandled := true.
			exception return] .
	self assert: wasHandled
]

{ #category : #tests }
ERTestRegisterController >> testValidateAttendeeWithNotValidCountry [
	| wasHandled  |
	wasHandled := false.
	attendee := (ERTestControllers testAttendee) country: 'Select Country'; yourself .
	controller attendee: attendee.
	[controller validateRegister] 
		on: ERException 
		do: [:exception | wasHandled := true.
			exception return] .
	self assert: wasHandled
]

{ #category : #tests }
ERTestRegisterController >> testValidateAttendeeWithNotValidGender [
	| wasHandled  |
	wasHandled := false.
	attendee := (ERTestControllers testAttendee) gender: 'invalid.gender'; yourself .
	controller attendee: attendee.
	[controller validateRegister] 
		on: ERException 
		do: [:exception | wasHandled := true.
			exception return] .
	self assert: wasHandled
]

{ #category : #tests }
ERTestRegisterController >> testValidateAttendeeWithoutFormatEmail [
	| wasHandled  |
	wasHandled := false.
	attendee := (ERTestControllers testAttendee) email: 'this.is.a.bad.example'; yourself .
	controller attendee: attendee.
	[controller validateRegister] 
		on: ERException 
		do: [:exception | wasHandled := true.
			exception return] .
	self assert: wasHandled
]
