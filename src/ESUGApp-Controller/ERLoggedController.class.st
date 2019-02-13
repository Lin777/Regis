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
	^ conference attends 
		detect: [ :each | each userAccount = user ]
		ifNone: [ nil ]
	
]

{ #category : #'as yet unclassified' }
ERLoggedController >> attendeeFromUser: anUser [
	^ conference attends 
			detect: [ :each | each userAccount = anUser ]
			ifNone: [ nil ]
]

{ #category : #rendering }
ERLoggedController >> deleteAttendee: anAttendee [
	self deleteAttendeeFromGroupAndConference: anAttendee.
	anAttendee userAccount isGroupManager
		ifFalse: [ self deleteUserForConference: anAttendee ]
		ifTrue: [ self deleteAttendeeRoleFromUser: anAttendee ].
	anAttendee delete.
]

{ #category : #removing }
ERLoggedController >> deleteAttendeeAndRemoveUserForConference: anAttendee [
	| userOfAttendee |
	userOfAttendee := anAttendee userAccount.
	anAttendee delete.
	self conference users
		removeAllSuchThat: [ :each | userOfAttendee id = each id ].
	userOfAttendee delete
]

{ #category : #removing }
ERLoggedController >> deleteAttendeeFromConference: anAttendee [
	(self conference attends)
		removeAllSuchThat: [ :each | anAttendee id = each id ].
	self conference save.
]

{ #category : #accessing }
ERLoggedController >> deleteAttendeeFromGroup: anAttendee [
	| group |
	group := self groupForGroupManager.
	group listAttends
		do: [ :each | 
			each userAccount email = anAttendee userAccount email
				ifTrue: [ 
					group listAttends remove: each ifAbsent: [  ].
					self deleteAttendee: each ] ].
	group save
]

{ #category : #accessing }
ERLoggedController >> deleteAttendeeFromGroupAndConference: anAttendee [
	anAttendee idGroup isNotNil ifTrue: [ 
	|group|
	group := self getGroupOfAttendee: anAttendee.
	(group listAttends)
		removeAllSuchThat: [ :each | anAttendee id = each id ].
	group save.	
	].
	(self conference attends)
		removeAllSuchThat: [ :each | anAttendee id = each id ].
	self conference save.
]

{ #category : #accessing }
ERLoggedController >> deleteAttendeeRoleFromUser: anAttendee [
	anAttendee userAccount deleteRole: 'attendee'
]

{ #category : #removing }
ERLoggedController >> deleteUserForConference: anAttendee [
	| userOfAttendee |
	userOfAttendee := anAttendee userAccount.
	self conference users
		removeAllSuchThat: [ :each | userOfAttendee id = each id ].
	self conference save.
	userOfAttendee delete.
	self conference users
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
