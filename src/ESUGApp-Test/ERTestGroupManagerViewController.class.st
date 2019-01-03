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
ERTestGroupManagerViewController >> testAddAttendee [
	| result |
	result := controller
		addAttendee: ERTestControllers testExampleAttendee..
	self deny: result isNil
]

{ #category : #tests }
ERTestGroupManagerViewController >> testDeleteAnAttendee [
	| user attendee result |
	user := self registerAttendee: ERTestControllers testExampleAttendee.
	attendee := controller attendeeFromUser: user.
	controller deleteAttendee: attendee .
	result := controller groupForGroupManager listAttends isEmpty . 
	self assert: result .
]

{ #category : #tests }
ERTestGroupManagerViewController >> testGroupOfAttendee [
	| user group |
	user := self registerAttendee.
	group := ERGroupManagerViewController new
		groupOfAttendee: user.
	self assert: (group isKindOf: ERGroup )
]
