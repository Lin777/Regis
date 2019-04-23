"
Description
--------------------

A ERTestTalk is a test class for testing the behavior of ERTalk model
"
Class {
	#name : #ERTestTalk,
	#superclass : #ERTestModel,
	#instVars : [
		'attendee'
	],
	#category : #'ESUGApp-Test-UnitTest'
}

{ #category : #tests }
ERTestTalk >> setUp [
	super setUp.
	attendee := controller conference attendeeFromUser: self registerAttendee 
]

{ #category : #tests }
ERTestTalk >> testEmptyDescriptionField [
	| talk |
	talk := (self class testTalk: attendee) description: nil; yourself .
	self assertEmptyField: talk
]

{ #category : #tests }
ERTestTalk >> testEmptyNameField [
	| talk |
	talk := (self class testTalk: attendee) name: nil; yourself .
	self assertEmptyField: talk
]
