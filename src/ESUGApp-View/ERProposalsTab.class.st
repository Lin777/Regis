"
Description
--------------------

I am the proposals tab on esug app. Only for admin user
"
Class {
	#name : #ERProposalsTab,
	#superclass : #ERContainerTab,
	#instVars : [
		'dialog'
	],
	#category : #'ESUGApp-View-Tab'
}

{ #category : #'instance creation' }
ERProposalsTab class >> on: anAttendee withContent: aContent container: aContainer [
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
ERProposalsTab >> exportFile: aFile withName: aString [
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
ERProposalsTab >> fileExists: fileName [

	^ (File named:
			((FileSystem workingDirectory asString splitOn: '@ ') at: 2), '/',fileName) exists
]

{ #category : #activation }
ERProposalsTab >> initialize [

	super initialize.
	dialog := ERDialog deleteDialog
		idOpen: 'back-state';
		okCallback: [ self returnToThePreviousState ]
]

{ #category : #initialization }
ERProposalsTab >> initializeController [

	controller := ERProposalsController new attendee: attendee
]
