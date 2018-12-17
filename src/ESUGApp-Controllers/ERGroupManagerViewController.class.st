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
	| group |
	group := self getGroupOfAttendee: aGroupManager .
	
]

{ #category : #adding }
ERGroupManagerViewController >> getGroupOfAttendee: aGroupManager [
	| group |
	group := ERGroup find: [ :each | each groupManager = aGroupManager ].
	group ifNil: [ group := ERGroup groupManager: aGroupManager.
	^ group save ].
	
]
