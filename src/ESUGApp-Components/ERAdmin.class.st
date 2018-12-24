Class {
	#name : #ERAdmin,
	#superclass : #ERTabContainerPage,
	#category : #'ESUGApp-Components'
}

{ #category : #'as yet unclassified' }
ERAdmin class >> on: anAttendee withContent: aContent [
	| form |
	form := self new.
	form attendee: anAttendee.
	form content: aContent.
	form initializeController .
	^ form
]

{ #category : #initialization }
ERAdmin >> initialize [
	super initialize.
]

{ #category : #initialization }
ERAdmin >> initializeController [
	controller := ERAdminViewController
		attendee: attendee
]
