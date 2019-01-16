Class {
	#name : #ERContentAdminTab,
	#superclass : #ERContainerTab,
	#category : #'ESUGApp-View-Tab'
}

{ #category : #'as yet unclassified' }
ERContentAdminTab class >> on: anAttendee withContent: aContent container: aContainer [
	| form |
	form := super on: anAttendee withContent: aContent.
	form initializeController .
	form container: aContainer.
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
