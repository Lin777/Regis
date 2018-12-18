Class {
	#name : #ERGroupManagerViewController,
	#superclass : #Object,
	#instVars : [
		'user',
		'attendee'
	],
	#category : #'ESUGApp-Controllers'
}

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
