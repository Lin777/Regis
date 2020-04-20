"
Description
--------------------

I am the configuration tab to configure esug app
"
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

{ #category : #actions }
ERConfigurationTab >> exportFile: aFile wihtName: aString [
	self requestContext respond: [ :response |
		response
            contentType: (WAMimeType main: 'application' sub: 'csv');
            document: aFile; contents ;
            attachmentWithFileName: aString]
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

{ #category : #initialization }
ERConfigurationTab >> initializeGroupInformationForm: aGroup [

	callback := [ self updateGroupInformation: aGroup ].
	self initializeGroupInformationFormFor: aGroup.
	self updateStateTab: self tabName.
]

{ #category : #rendering }
ERConfigurationTab >> renderDownloadButton: html with: aDictionary [
	| downloadButton |
	downloadButton := html mdlAnchorButton colored;
		id: (aDictionary at: 'id');
		disabled: (aDictionary at: 'disabled').
	downloadButton isDisabled ifFalse: [
		downloadButton url: (aDictionary at: 'encodeFile');
		attributeAt: 'download' put: (aDictionary at: 'nameFile').
	].
	downloadButton with: (aDictionary at: 'nameButton').
]
