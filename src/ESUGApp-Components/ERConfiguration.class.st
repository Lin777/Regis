Class {
	#name : #ERConfiguration,
	#superclass : #ERTabContainerPage,
	#category : #'ESUGApp-Components'
}

{ #category : #'as yet unclassified' }
ERConfiguration class >> on: anAttendee withContent: aContent [
	| form |
	form := self new.
	form attendee: anAttendee.
	form content: aContent.
	form initializeController.
	^ form
]

{ #category : #initialization }
ERConfiguration >> initializeController [
	controller := ERConfigurationViewController new attendee: attendee
]
