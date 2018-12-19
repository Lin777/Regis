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
	anUser := self registerAttendee.
	controller := ERGroupManagerViewController new.
	controller attendee: (controller attendeeFromUser: anUser)
]

{ #category : #tests }
ERTestGroupManagerViewController >> testAddAttendeeTo [
	|  user2 group |
	user2 := self
		registerAttendee: ERTestControllers testExampleAttendee.
	group := controller addAttendee: controller attendee userAccount to: user2.
	self deny: group isNil
]

{ #category : #tests }
ERTestGroupManagerViewController >> testGroupOfAttendee [
	| user group |
	user := self registerAttendee.
	group := ERGroupManagerViewController new
		groupOfAttendee: user.
	self assert: (group isKindOf: ERGroup )
]
