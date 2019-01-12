Class {
	#name : #ERModifyUserView,
	#superclass : #ERTittledView,
	#instVars : [
		'form',
		'dialog'
	],
	#category : #'ESUGApp-View'
}

{ #category : #actions }
ERModifyUserView >> cancel [
	attendee abortChanges.
	self returnToThePreviousState
	
]

{ #category : #rendering }
ERModifyUserView >> content: anObject [
	content := anObject
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
	attendee save.
	self returnToThePreviousState .
]
