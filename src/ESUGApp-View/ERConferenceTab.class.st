"
Description
--------------------

I am the conference tab of esug app
"
Class {
	#name : #ERConferenceTab,
	#superclass : #ERContainerTab,
	#instVars : [
		'dialog'
	],
	#category : #'ESUGApp-View-Tab'
}

{ #category : #'instance creation' }
ERConferenceTab class >> on: anAttendee withContent: aContent container: aContainer [
	"Initialize the controller with views"
	
	| controller |
	controller := self new.
	controller attendee: anAttendee.
	controller content: aContent.
	controller initializeController.
	controller container: aContainer.
	^ controller
]

{ #category : #actions }
ERConferenceTab >> exportFile: aFile withName: aString [
	"Export a file with a given name"

	self requestContext 
		respond: [ :response |
				response 
					contentType: (WAMimeType main: 'application' sub: 'csv');
					document: aFile; 
					contents;
					attachmentWithFileName: aString ]
]

{ #category : #'file library' }
ERConferenceTab >> fileExists: fileName [

	^ (File named:
			((FileSystem workingDirectory asString splitOn: '@ ') at: 2), '/',fileName) exists
]

{ #category : #activation }
ERConferenceTab >> initialize [

	super initialize.
	dialog := ERDialog deleteDialog
		idOpen: 'back-state';
		okCallback: [ self returnToThePreviousState ]
]

{ #category : #initialization }
ERConferenceTab >> initializeController [

	controller := ERAttendeeController new attendee: attendee
]
