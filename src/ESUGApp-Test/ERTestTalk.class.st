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
ERTestTalk >> testValidateTalkWithEmptyDescription [
	| errors talk |
	talk := (self class testTalk: attendee) description: nil; yourself .
	errors := talk asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: messageInputRequired equals: (errors at:1) messageText.
	
]

{ #category : #'as yet unclassified' }
ERTestTalk >> testValidateTalkWithEmptyName [
	| errors talk |
	talk := (self class testTalk: attendee) name: nil; yourself .
	errors := talk asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: messageInputRequired equals: (errors at:1) messageText.
	
]
