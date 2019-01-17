Class {
	#name : #ERTestGroupManagerController,
	#superclass : #ERTestControllers,
	#instVars : [
		'controller'
	],
	#category : #'ESUGApp-Test'
}

{ #category : #initialization }
ERTestGroupManagerController >> setUp [
	| anUser |
	super setUp.
	anUser := self registerAsGroupManager.
	controller := ERGroupManagerController new.
	controller attendee: (controller attendeeFromUser: anUser)
]

{ #category : #tests }
ERTestGroupManagerController >> testAddMyselfToGroup [
	controller addMyselfToGroup .
	self
		assert:
			(controller groupForGroupManager listAttends
				find: controller attendee) isNotNil
]

{ #category : #tests }
ERTestGroupManagerController >> testCreateGRoupForGroupManager [
	|group|
	group := controller groupForGroupManager .
	self assert: (group groupManager = controller attendee )
]

{ #category : #tests }
ERTestGroupManagerController >> testDeleteAnAttendee [
	"| user attendee result |
	user := self
		registerAttendee: ERTestControllers testExampleAttendee.
	attendee := controller attendeeFromUser: user.
	controller deleteAttendee: attendee.
	result := controller groupForGroupManager listAttends isEmpty.
	self assert: result"
]

{ #category : #tests }
ERTestGroupManagerController >> testGroupOfAttendee [
	| user group |
	user := self registerAttendee.
	group := ERGroupManagerController new
		groupOfAttendee: user.
	self assert: (group isKindOf: ERGroup )
]

{ #category : #tests }
ERTestGroupManagerController >> testRegisterAsAttendee [
	controller registerAsAttendee.
	self
		assert:
			((controller attendee userAccount isAttendee) and: (controller
				attendee userAccount isGroupManager))
]

{ #category : #tests }
ERTestGroupManagerController >> testValidateRegister [
	| result |
	result := controller
		addAttendee: ERTestControllers testExampleAttendee..
	self deny: result isNil
]
