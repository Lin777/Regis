Class {
	#name : #ERContentAdminTab,
	#superclass : #ERContainerTab,
	#category : #'ESUGApp-View-Tab'
}

{ #category : #'as yet unclassified' }
ERContentAdminTab class >> on: anAttendee withContent: aContent [
	| form |
	form := self new.
	form attendee: anAttendee.
	form content: aContent.
	form initializeController .
	^ form
]

{ #category : #initialization }
ERContentAdminTab >> initialize [
	super initialize.
]

{ #category : #initialization }
ERContentAdminTab >> initializeController [
	controller := ERAdminController
		attendee: attendee
]
