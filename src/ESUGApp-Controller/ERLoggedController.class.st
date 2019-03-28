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
	self deleteAttendeeFromGroupAndConference: anAttendee.
	anUser isGroupManager
		ifFalse: [ self deleteUserForConference: anUser]
		ifTrue: [ self deleteAttendeeRoleFromUser: anUser ]
]

{ #category : #accessing }
ERLoggedController >> deleteAttendeeFromGroupAndConference: anAttendee [
	anAttendee idGroup isNotNil ifTrue: [ 
	|group|
	group := conference getGroupOfAttendee: anAttendee.
	group deleteAttendee: anAttendee; save.	
	].
	self conference deleteAttendee: anAttendee.
	"Linea agregada"
	anAttendee delete.
	self conference save.
	self notifyAllObservers 
]

{ #category : #accessing }
ERLoggedController >> deleteAttendeeRoleFromUser: anUser [
	anUser deleteAttendeeRole 
]

{ #category : #removing }
ERLoggedController >> deleteUserForConference: anUser [
	self conference deleteUser: anUser.
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
