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
	content state: content lastState
]

{ #category : #rendering }
ERContainerModifyUserView >> content: anObject [
	content := anObject
]

{ #category : #actions }
ERContainerModifyUserView >> initializeForm [
	form := ERAffiliationInformationForm on: attendee
]

{ #category : #actions }
ERContainerModifyUserView >> renderAcceptButtonOn: html [
	html mdlButton
		colored;
		id: 'accept-change-affiliation';
		callback: [ self updateAffiliationInformation ];
		with: 'Accept'
]

{ #category : #actions }
ERContainerModifyUserView >> renderButtons: html [
	self renderAcceptButtonOn: html.
	self renderCancelButtonOn: html
]

{ #category : #actions }
ERContainerModifyUserView >> renderCancelButtonOn: html [
	html mdlButton
		colored;
		id: 'cancel-change-affiliation';
		callback: [ self cancel ];
		with: 'Cancel'
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
