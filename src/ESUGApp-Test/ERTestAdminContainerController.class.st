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
