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
		ifNil: [ |userSaved|
			userSaved := anAttendee userAccount save.
			anAttendeeSaved := (anAttendee userAccount: userSaved ) save.
			group := self groupOfAttendee: attendee userAccount.
			group listAttends add: anAttendeeSaved.
			^ group save ].
	^ nil
]

{ #category : #adding }
ERGroupManagerViewController >> addAttendee: anAttendee to: aGroupManager [
	| group anAttendeeSaved |
	(ERUserAccount findUserByEmail: anAttendee email) ifNil: [ 
		anAttendeeSaved := anAttendee save.
	group := self groupOfAttendee: aGroupManager.
	group listAttends add: anAttendeeSaved.
	^ group save
		 ].
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
