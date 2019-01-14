Class {
	#name : #ERConfigurationTab,
	#superclass : #ERContainerTab,
	#category : #'ESUGApp-View-Tab'
}

{ #category : #'as yet unclassified' }
ERConfigurationTab class >> on: anAttendee withContent: aContent [
	| form |
	form := self new.
	form attendee: anAttendee.
	form content: aContent.
	form initializeController.
	^ form
]

{ #category : #'file library' }
ERConfigurationTab >> fileExists: fileName [ 
	^ (File named: ((FileSystem workingDirectory asString splitOn: '@ ') at:2),'/fileName') exists.

]

{ #category : #initialization }
ERConfigurationTab >> initializeController [
	controller := ERConfigurationController new attendee: attendee
]