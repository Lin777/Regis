Class {
	#name : #ERModifyUserView,
	#superclass : #ERTittledView,
	#instVars : [
		'form',
		'dialog',
		'messageComponent',
		'actionModify'
	],
	#category : #'ESUGApp-View'
}

{ #category : #'as yet unclassified' }
ERModifyUserView class >> on: anAttendee withContent: aContent withAction: aBlock [
	| form |
	form := self new.
	form attendee: anAttendee.
	form content: aContent.
	form actionModify: aBlock.
	^ form
]

{ #category : #accessing }
ERModifyUserView >> actionModify: anObject [
	actionModify := anObject 
]

{ #category : #actions }
ERModifyUserView >> cancel [
	attendee abortChanges.
	self returnToThePreviousState
	
]

{ #category : #rendering }
ERModifyUserView >> content: anObject [
	content := anObject
]

{ #category : #rendering }
ERModifyUserView >> initialize [
	super initialize.
	messageComponent := ERAlert warningAlert id: 'adminModifyUserAlert'
]

{ #category : #initialization }
ERModifyUserView >> initializeDialog [ 
	dialog := ERDialog new
		title: 'Cancel Modify User';
		message: 'Are you sure you want to cancel?';
		idClose: 'buttonClose';
		idOpen: 'cancel-modify-user';
		okCallback: [ self cancel ]
]

{ #category : #rendering }
ERModifyUserView >> renderAcceptButtonOn: html [
	self
		createColoredButton: 'Accept'
		with: [ self updateUserInformation ]
		id: 'accept-change-affiliation'
		on: html
]

{ #category : #actions }
ERModifyUserView >> renderButtons: html [
	self renderAcceptButtonOn: html.
	self renderCancelButtonOn: html
]

{ #category : #rendering }
ERModifyUserView >> renderCancelButtonOn: html [
	self initializeDialog .
	self
		createColoredAnchorButton: 'Cancel'
		id: 'cancel-modify-user'
		on: html
]

{ #category : #rendering }
ERModifyUserView >> renderFormOn: html [
	html render: (ERModifyUserForm on: attendee)
]

{ #category : #rendering }
ERModifyUserView >> renderPageOn: html [
	html render: messageComponent .
	html form
		method: 'post';
		id: 'formModifyUser';
		with: [ self renderFormOn: html.
			self renderButtons: html ].
	html render: dialog
]

{ #category : #rendering }
ERModifyUserView >> title [
	^ 'User'.
]

{ #category : #rendering }
ERModifyUserView >> updateUserInformation [
	actionModify 
on: ERException
 do: [ :exc | messageComponent errorMessage: exc messageText  ]
	
]
