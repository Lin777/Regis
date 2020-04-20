"
Description
--------------------

I am the invoices tab on esug app
"
Class {
	#name : #ERInvoicesTab,
	#superclass : #ERContainerTab,
	#instVars : [
		'dialog'
	],
	#category : #'ESUGApp-View-Tab'
}

{ #category : #'instance creation' }
ERInvoicesTab class >> on: anAttendee withContent: aContent container: aContainer [
	"Initialize the controller with views"
	
	| controller |
	controller := self new.
	controller attendee: anAttendee.
	controller content: aContent.
	controller initializeController.
	controller container: aContainer.
	^ controller
]

{ #category : #activation }
ERInvoicesTab >> initialize [

	super initialize.
	dialog := ERDialog deleteDialog
		idOpen: 'back-state';
		okCallback: [ self returnToThePreviousState ]
]

{ #category : #initialization }
ERInvoicesTab >> initializeController [

	controller := ERInvoicesController new attendee: attendee
]

{ #category : #rendering }
ERInvoicesTab >> renderDownloadButton: html with: aDictionary [
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
