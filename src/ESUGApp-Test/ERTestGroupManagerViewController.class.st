Class {
	#name : #ERTestGroupManagerViewController,
	#superclass : #ERTestControllers,
	#instVars : [
		'controller'
	],
	#category : #'ESUGApp-Test'
}

{ #category : #initialization }
ERTestGroupManagerViewController >> setUp [
	| anUser |
	super setUp.
	anUser := self registerAsGroupManager.
	controller := ERGroupManagerController new.
	controller attendee: (controller attendeeFromUser: anUser)
]

{ #category : #tests }
ERTestGroupManagerViewController >> testAddAttendee [
	| result |
	result := controller
		addAttendee: ERTestControllers testExampleAttendee..
	self deny: result isNil
]

{ #category : #tests }
ERTestGroupManagerViewController >> testAddMyselfToGroup [
	controller addMyselfToGroup .
	self
		assert:
			(controller groupForGroupManager listAttends
				find: controller attendee) isNotNil
]

{ #category : #tests }
ERTestGroupManagerViewController >> testCreateGRoupForGroupManager [
	|group|
	group := controller groupForGroupManager .
	self assert: (group groupManager = controller attendee )
]

{ #category : #tests }
ERTestGroupManagerViewController >> testDeleteAnAttendee [
	"| user attendee result |
	user := self
		registerAttendee: ERTestControllers testExampleAttendee.
	attendee := controller attendeeFromUser: user.
	controller deleteAttendee: attendee.
	result := controller groupForGroupManager listAttends isEmpty.
	self assert: result"
]

{ #category : #tests }
ERTestGroupManagerViewController >> testGroupOfAttendee [
	| user group |
	user := self registerAttendee.
	group := ERGroupManagerController new
		groupOfAttendee: user.
	self assert: (group isKindOf: ERGroup )
]

{ #category : #tests }
ERTestGroupManagerViewController >> testRegisterAsAttendee [
	controller registerAsAttendee.
	self
		assert:
			((controller attendee userAccount isAttendee) and: (controller
				attendee userAccount isGroupManager))
]
