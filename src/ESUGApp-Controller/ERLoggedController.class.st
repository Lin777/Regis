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
	^ ERAttendee find: [ :each | each userAccount = user ]
]

{ #category : #'as yet unclassified' }
ERLoggedController >> attendeeFromUser: anUser [
	^ ERAttendee find: [ :each | each userAccount = anUser ]
]

{ #category : #removing }
ERLoggedController >> deleteAttendeeAndRemoveUserForConference: anAttendee [
	| userOfAttendee |
	userOfAttendee := anAttendee userAccount.
	self removeUserOfTicketIfApply: anAttendee.
	anAttendee delete.
	self conference users
		removeAllSuchThat: [ :each | userOfAttendee id = each id ].
	userOfAttendee delete
]

{ #category : #accessing }
ERLoggedController >> initialize [
	super initialize.
	user := ERUserAccount new
]

{ #category : #removing }
ERLoggedController >> removeUserOfTicketIfApply: anAttendee [
	(anAttendee coupon isNotEmpty and: anAttendee coupon isNotNil)
		ifTrue: [ | coupon |
			coupon := ERReductionTicket
				find: [ :each | each ticketId = anAttendee coupon ].
			coupon usersOfTickets
				removeAllSuchThat: [ :each | each = anAttendee userAccount ].
			coupon save ]
]

{ #category : #accessing }
ERLoggedController >> user [
	^ user
]

{ #category : #accessing }
ERLoggedController >> user: anUser [
	user := anUser
]
