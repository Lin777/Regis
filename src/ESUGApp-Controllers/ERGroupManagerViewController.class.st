Class {
	#name : #ERGroupManagerViewController,
	#superclass : #ERLoggedController,
	#category : #'ESUGApp-Controllers'
}

{ #category : #adding }
ERGroupManagerViewController >> addAttendee: anAttendee [
	| group anAttendeeSaved |
	(ERUserAccount findUserByEmail: anAttendee email)
		ifNil: [ | userSaved |
			userSaved := anAttendee userAccount save.
			conference addUser: userSaved .
			anAttendeeSaved := (anAttendee userAccount: userSaved) save.
			conference addAttendee: anAttendeeSaved.
			group := self groupForGroupManager.
			group addAttendee: anAttendeeSaved.
			conference save.
			^ group save ].
	^ nil
]

{ #category : #adding }
ERGroupManagerViewController >> addMyselfToGroup [
	|group|
	group := self groupForGroupManager.
	group addAttendee: attendee.
	group save.
]

{ #category : #adding }
ERGroupManagerViewController >> createGroup: aGroupManager [
	|group|
	group := ERGroup groupManager: aGroupManager.
			group := group save.
			conference
				addGroup: group;
				save.
	^ group
]

{ #category : #accessing }
ERGroupManagerViewController >> deleteAttendee: anAttendee [
	| userOfAttendee |
	userOfAttendee := anAttendee userAccount.
	anAttendee delete.
	userOfAttendee delete
]

{ #category : #accessing }
ERGroupManagerViewController >> deleteAttendeeFromGroup: anAttendee [
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
ERGroupManagerViewController >> groupForGroupManager [
	^ self groupOfAttendee: attendee
]

{ #category : #adding }
ERGroupManagerViewController >> groupOfAttendee: aGroupManager [
	| group |
	group := ERGroup
		find: [ :each | each groupManager = aGroupManager ].
	group
		ifNil: [ 
			group := self createGroup: aGroupManager .
			 ].
	^ group
]

{ #category : #adding }
ERGroupManagerViewController >> registerAsAttendee [
	attendee userAccount
		roleAdd: 'attendee';
		save.
	attendee save.
	conference addAttendee: attendee.
	self addMyselfToGroup.
	conference save.
	^ attendee
]
