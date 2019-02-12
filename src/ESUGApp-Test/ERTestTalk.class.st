Class {
	#name : #ERTestTalk,
	#superclass : #ERTestModel,
	#instVars : [
		'attendee'
	],
	#category : #'ESUGApp-Test'
}

{ #category : #tests }
ERTestTalk >> setUp [
	super setUp.
	attendee := ERLoggedController new attendeeFromUser: self registerAttendee 
]

{ #category : #'as yet unclassified' }
ERTestTalk >> testEmptyDescriptionField [
	| talk |
	talk := (self class testTalk: attendee) description: nil; yourself .
	self assertEmptyField: talk
]

{ #category : #'as yet unclassified' }
ERTestTalk >> testEmptyNameField [
	| talk |
	talk := (self class testTalk: attendee) name: nil; yourself .
	self assertEmptyField: talk
]
