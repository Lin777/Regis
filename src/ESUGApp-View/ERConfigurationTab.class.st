Class {
	#name : #ERConfigurationTab,
	#superclass : #ERContainerTab,
	#instVars : [
		'dialog'
	],
	#category : #'ESUGApp-View-Tab'
}

{ #category : #'as yet unclassified' }
ERConfigurationTab class >> on: anAttendee withContent: aContent container: aContainer [
	| form |
	form := self new.
	form attendee: anAttendee.
	form content: aContent.
	form initializeController.
	form container: aContainer.
	^ form
]

{ #category : #'file library' }
ERConfigurationTab >> fileExists: fileName [
	^ (File
		named:
			((FileSystem workingDirectory asString splitOn: '@ ') at: 2)
				, '/',fileName) exists
]

{ #category : #initialization }
ERConfigurationTab >> initialize [
	super initialize .
	dialog := ERDialog deleteDialog
		idOpen: 'back-state';
		okCallback: [ self returnToThePreviousState ]
]

{ #category : #initialization }
ERConfigurationTab >> initializeController [
	controller := ERConfigurationController new attendee: attendee
]
