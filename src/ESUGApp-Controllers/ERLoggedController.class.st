Class {
	#name : #ERLoggedController,
	#superclass : #ERController,
	#instVars : [
		'user',
		'attendee'
	],
	#category : #'ESUGApp-Controllers'
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
	^ ERAttendee find: [ :each | each userAccount = user ]
]

{ #category : #'as yet unclassified' }
ERLoggedController >> attendeeFromUser: anUser [
	^ ERAttendee find: [ :each | each userAccount = anUser ]
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
