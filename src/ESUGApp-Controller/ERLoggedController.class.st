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
	^ self attendeeFromUser: user
	
]

{ #category : #'as yet unclassified' }
ERLoggedController >> attendeeFromUser: anUser [
	^ conference attends 
			detect: [ :each | 
				each userAccount = anUser ]
			ifNone: [ ERException notFoundAttendeeFromUser signal ]
]

{ #category : #rendering }
ERLoggedController >> deleteAttendee: anAttendee [
	self deleteAttendeeFromGroupAndConference: anAttendee.
	anAttendee userAccount isGroupManager
		ifFalse: [ self deleteUserForConference: anAttendee userAccount]
		ifTrue: [ self deleteAttendeeRoleFromUser: anAttendee ].
	anAttendee delete.
]

{ #category : #accessing }
ERLoggedController >> deleteAttendeeFromGroupAndConference: anAttendee [
	anAttendee idGroup isNotNil ifTrue: [ 
	|group|
	group := conference getGroupOfAttendee: anAttendee.
	group deleteAttendee: anAttendee; save.	
	].
	self conference deleteAttendee: anAttendee.
	self conference save.
	self notifyAllObservers 
]

{ #category : #accessing }
ERLoggedController >> deleteAttendeeRoleFromUser: anAttendee [
	anAttendee deleteAttendeeRole 
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
