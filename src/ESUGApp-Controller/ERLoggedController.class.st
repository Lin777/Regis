"
Description
--------------------

I am a controller when the user is logged.

Instance Variables
--------------------
	user: an ERUserAccount logged in page
	attendee: an ERAttendee logged in page
"
Class {
	#name : #ERLoggedController,
	#superclass : #ERController,
	#instVars : [
		'user',
		'attendee'
	],
	#category : #'ESUGApp-Controller'
}

{ #category : #'instance creation' }
ERLoggedController class >> attendee: anAtteendee [
	| controller |
	controller := self new.
	controller attendee: anAtteendee.
	^ controller
]

{ #category : #'instance creation' }
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

{ #category : #accessing }
ERLoggedController >> attendeeFromUser [
	^ conference attendeeFromUser: user
	
]

{ #category : #updating }
ERLoggedController >> changePasswordTo: aString [
	attendee password: (ERUserAccount hashPassword: aString) asString.
	attendee save.
	self notifyAllObservers .
	^ attendee
]

{ #category : #deleting }
ERLoggedController >> deleteAttendee: anAttendee [
	"Delete Attendee of conference"
	
	| anUser |
	anUser := anAttendee userAccount.
	conference deleteAttendeeFromGroupAndConference: anAttendee.
	anAttendee idGroup isNotNil 
		ifTrue: [ self updateGroup: (conference getGroupOfAttendee: anAttendee) ].
	anUser isGroupManager
		ifFalse: [ conference deleteUser: anUser ]
		ifTrue: [ anUser deleteAttendeeRole ].
	self notifyAllObservers
]

{ #category : #initialization }
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

{ #category : #validations }
ERLoggedController >> validateCurrentPassword: confirmPassword [
	attendee password = (ERUserAccount hashPassword: confirmPassword) asString 
		ifFalse: [ ERException passwordDoesNotMatch signal  ]
]

{ #category : #validations }
ERLoggedController >> validatePatternPassword: aString [
	((aString matchesRegex: '[A-Za-z0-9._]{8,}') and: [aString size >= 8])
	ifFalse: [ ERException incorrectPatternOfPassword signal ]
]
