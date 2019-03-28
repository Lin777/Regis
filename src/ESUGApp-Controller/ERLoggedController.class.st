Class {
	#name : #ERLoggedController,
	#superclass : #ERController,
	#instVars : [
		'user',
		'attendee'
	],
	#category : #'ESUGApp-Controller'
}

{ #category : #accessing }
ERLoggedController class >> user: anUser [
	| controller |
	controller := self new.
	controller user: anUser.
	^ controller
]

{ #category : #accessing }
ERLoggedController >> attendee [
	^ attendee
]

{ #category : #accessing }
ERLoggedController >> attendee: anObject [
	attendee := anObject
]

{ #category : #'as yet unclassified' }
ERLoggedController >> attendeeFromUser [
	^ conference attendeeFromUser: user
	
]

{ #category : #rendering }
ERLoggedController >> deleteAttendee: anAttendee [
	|anUser|
	anUser := anAttendee userAccount .
	conference deleteAttendeeFromGroupAndConference: anAttendee .
	anUser isGroupManager
		ifFalse: [ conference deleteUser: anUser]
		ifTrue: [ anUser deleteAttendeeRole  ].
	self notifyAllObservers 
]

{ #category : #accessing }
ERLoggedController >> initialize [
	super initialize.
	user := ERUserAccount new
]

{ #category : #accessing }
ERLoggedController >> user [
	^ user
]

{ #category : #accessing }
ERLoggedController >> user: anUser [
	user := anUser
]
