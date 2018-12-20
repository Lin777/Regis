Class {
	#name : #ERGroupManagerViewController,
	#superclass : #ERLoggedController,
	#instVars : [
		'attendee'
	],
	#category : #'ESUGApp-Controllers'
}

{ #category : #adding }
ERGroupManagerViewController >> addAttendee: anAttendee [
	| group anAttendeeSaved |
	(ERUserAccount findUserByEmail: anAttendee email)
		ifNil: [ | userSaved |
			userSaved := anAttendee userAccount save.
			anAttendeeSaved := (anAttendee userAccount: userSaved) save.
			group := self groupGroupManager"self groupOfAttendee: attendee userAccount".
			group listAttends add: anAttendeeSaved.
			^ group save ].
	^ nil
]

{ #category : #accessing }
ERGroupManagerViewController >> attendee [
	^ attendee
]

{ #category : #accessing }
ERGroupManagerViewController >> attendee: anObject [
	attendee := anObject
]

{ #category : #accessing }
ERGroupManagerViewController >> deleteAttendee: anAttendee [
	|userOfAttendee|
	userOfAttendee := anAttendee userAccount.
					anAttendee delete.
					userOfAttendee delete
]

{ #category : #accessing }
ERGroupManagerViewController >> deleteAttendeeFromGroup: anAttendee [
	| group |
	group := self groupGroupManager.
	group listAttends
		do: [ :each | 
			each userAccount email = anAttendee userAccount email
				ifTrue: [ 
					group listAttends remove: each ifAbsent: [  ].
					self deleteAttendee: each ] ].
	group save
]

{ #category : #accessing }
ERGroupManagerViewController >> groupGroupManager [
	^ self groupOfAttendee: attendee userAccount
]

{ #category : #adding }
ERGroupManagerViewController >> groupOfAttendee: aGroupManager [
	| group |
	group := ERGroup
		find: [ :each | each groupManager = aGroupManager ].
	group
		ifNil: [ group := ERGroup groupManager: aGroupManager.
			group := group save ].
	^ group 
]
