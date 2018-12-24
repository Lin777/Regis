Class {
	#name : #ERContainerModifyUserView,
	#superclass : #ERGeneralContainerView,
	#instVars : [
		'attendeModified',
		'form'
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
	self
		createColoredAnchorButton: 'Cancel'
		with: [ self cancel ]
		id: 'cancel-change-affiliation'
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
			self renderButtons: html ]
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
