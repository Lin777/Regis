"
Description
--------------------

I am the users and groups tab on esug app. Only for admin user
"
Class {
	#name : #ERUserOptionsTab,
	#superclass : #ERContainerTab,
	#instVars : [
		'dialog'
	],
	#category : #'ESUGApp-View-Tab'
}

{ #category : #'instance creation' }
ERUserOptionsTab class >> on: anAttendee withContent: aContent container: aContainer [
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
ERUserOptionsTab >> exportFile: aFile withName: aString [
	"Export a file with a given name"

	self requestContext 
		respond: [ :response |
				response 
					contentType: (WAMimeType main: 'application' sub: 'csv');
					document: aFile; 
					contents;
					attachmentWithFileName: aString ]
]

{ #category : #initialization }
ERUserOptionsTab >> initializeController [
	controller := ERUserOptionsController new attendee: attendee
]

{ #category : #initialization }
ERUserOptionsTab >> initializeGroupInformationForm: aGroup [

	callback := [ self updateGroupInformation: aGroup ].
	self initializeGroupInformationFormFor: aGroup.
	self updateStateTab: self tabName.
]
