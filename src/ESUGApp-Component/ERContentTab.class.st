Class {
	#name : #ERContentTab,
	#superclass : #ERStateContent,
	#instVars : [
		'active',
		'id'
	],
	#category : #'ESUGApp-Component'
}

{ #category : #'instance creation' }
ERContentTab class >> on: anAttendee [
	| form |
	form := self new.
	form attendee: anAttendee.
	^ form
]

{ #category : #activation }
ERContentTab >> activate [
	active := true.
]

{ #category : #accessing }
ERContentTab >> attendee: anObject [
	attendee := anObject
]

{ #category : #private }
ERContentTab >> deactivate [
	active := false.
]

{ #category : #initialization }
ERContentTab >> initialize [
	super initialize.
	active := false.
]

{ #category : #testing }
ERContentTab >> isActive [
	^ active.
]

{ #category : #rendering }
ERContentTab >> renderContentOn: html [
	self subclassResponsibility 
]

{ #category : #accessing }
ERContentTab >> tabId [
	^ self subclassResponsibility.
]

{ #category : #accessing }
ERContentTab >> tabName [
	^ self subclassResponsibility.
]
