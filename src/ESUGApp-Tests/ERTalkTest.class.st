"
Description
--------------------

A ERTestTalk is a test class for testing the behavior of ERTalk model
"
Class {
	#name : #ERTalkTest,
	#superclass : #ERModelTest,
	#instVars : [
		'attendee'
	],
	#category : #'ESUGApp-Tests-UnitTest'
}

{ #category : #running }
ERTalkTest >> setUp [

	super setUp.
	attendee := controller conference attendeeFromUser: self registerAttendee
]

{ #category : #tests }
ERTalkTest >> testEmptyBioField [

	| talk |
	talk := (self class testTalk: attendee) bio: nil; yourself.
	self assertEmptyField: talk
]

{ #category : #tests }
ERTalkTest >> testEmptyDescriptionField [

	| talk |
	talk := (self class testTalk: attendee) description: nil; yourself.
	self assertEmptyField: talk
]

{ #category : #tests }
ERTalkTest >> testEmptyTitleField [

	| talk |
	talk := (self class testTalk: attendee) title: nil; yourself.
	self assertEmptyField: talk
]
