Class {
	#name : #ERContainerModifyUserView,
	#superclass : #ERGeneralContainerView,
	#instVars : [
		'form',
		'dialog'
	],
	#category : #'ESUGApp-Components'
}

{ #category : #actions }
ERContainerModifyUserView >> cancel [
	attendee abortChanges.
	self returnToThePreviousState
	
]

{ #category : #rendering }
ERContainerModifyUserView >> content: anObject [
	content := anObject
]

{ #category : #initialization }
ERContainerModifyUserView >> initializeDialog [ 
	dialog := ERDialog new
		title: 'Cancel Modify User';
		message: 'Are you sure you want to cancel?';
		idClose: 'buttonClose';
		idOpen: 'cancel-modify-user';
		okCallback: [ self cancel ]
]

{ #category : #rendering }
ERContainerModifyUserView >> renderAcceptButtonOn: html [
	self
		createColoredButton: 'Accept'
		with: [ self updateUserInformation ]
		id: 'accept-change-affiliation'
		on: html
]

{ #category : #actions }
ERContainerModifyUserView >> renderButtons: html [
	self renderAcceptButtonOn: html.
	self renderCancelButtonOn: html
]

{ #category : #rendering }
ERContainerModifyUserView >> renderCancelButtonOn: html [
	self initializeDialog .
	self
		createColoredAnchorButton: 'Cancel'
		id: 'cancel-modify-user'
		on: html
]

{ #category : #rendering }
ERContainerModifyUserView >> renderFormOn: html [
	html render: (ERModifyUserForm on: attendee)
]

{ #category : #rendering }
ERContainerModifyUserView >> renderPageOn: html [
	html form
		method: 'post';
		id: 'formModifyUser';
		with: [ self renderFormOn: html.
			self renderButtons: html ].
	html render: dialog 
]

{ #category : #rendering }
ERContainerModifyUserView >> title [
	^ 'User'.
]

{ #category : #rendering }
ERContainerModifyUserView >> updateUserInformation [
	attendee save.
	self returnToThePreviousState .
]
