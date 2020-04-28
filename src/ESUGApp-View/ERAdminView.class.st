"
Description
--------------------

I am a Admin View, I can update my user account and password

Instance Variables
--------------------

	modifiedUser:			<aComponent> form to update UserAccount.
	messageComponent:		<aComponent>	ERAlert to show messages of page.
	changePasswordForm:	<aComponent> form ro update password.
	controller: 				<aController> controller of this view
	contentBlock: 			aBlock to change the content of view

"
Class {
	#name : #ERAdminView,
	#superclass : #ERContainer,
	#instVars : [
		'controller',
		'modifiedUser',
		'messageComponent',
		'contentBlock',
		'changePasswordForm'
	],
	#category : #'ESUGApp-View-View'
}

{ #category : #'as yet unclassified' }
ERAdminView class >> on: anAttendee withContent: aContent withController: aController [
	| form |
	form := self new.
	form attendee: anAttendee.
	form content: aContent.
	form controller: aController.
	form initializeFormUser .
	form contentBlock: form blockEditUser .
	form initializeChangePassword.
	^ form
]

{ #category : #adding }
ERAdminView >> acceptUser [
	[ controller updateUser: (modifiedUser save) model.
	messageComponent changeToAlertSuccess .
	messageComponent errorMessage: 'User successfully updated' ]
		on: ERException
		do: [ :exception | 
			messageComponent changeToAlertOfError .
			messageComponent errorMessage: exception messageText ].
]

{ #category : #adding }
ERAdminView >> blockChangePassword [
	^ [ :html | 
		html render: changePasswordForm ]
]

{ #category : #adding }
ERAdminView >> blockEditUser [ 
	^ [ :html | html heading level3 with: 'Edit profile'.
			html horizontalRule .
			html form
				method: 'post';
				id: 'formUpdateProfile';
				with: [
					html render: messageComponent.
					html render: modifiedUser.
					self renderAnchorToChangePasswordOn: html.
					html horizontalRule.
					self renderButtonsOn: html ] ]
]

{ #category : #adding }
ERAdminView >> cancel [
	attendee abortChanges.
	self initializeFormUser.
	content state: content lastState.
]

{ #category : #adding }
ERAdminView >> contentBlock [ 
	^ contentBlock
]

{ #category : #adding }
ERAdminView >> contentBlock: anObject [
	contentBlock := anObject
]

{ #category : #accessing }
ERAdminView >> controller: anObject [
	controller := anObject
]

{ #category : #initialization }
ERAdminView >> initialize [
	super initialize.
	messageComponent := ERAlert warningAlert id: 'adminAlert'.
]

{ #category : #adding }
ERAdminView >> initializeChangePassword [
		changePasswordForm := (ERChangePasswordForm 
										on: attendee 
										withContent: content 
										container: self) 
										cancel: [ contentBlock := self blockEditUser ].
]

{ #category : #adding }
ERAdminView >> initializeFormUser [
	modifiedUser := attendee asComponent 
	addDecoration: MAValidationDecoration new;
	 yourself
]

{ #category : #adding }
ERAdminView >> renderAcceptButtonOn: html [
	html mdlButton
		colored;
		id: 'accept-user';
		callback: [ self acceptUser ];
		with: 'Accept'
]

{ #category : #adding }
ERAdminView >> renderAnchorToChangePasswordOn: html [
	html paragraph with: [ 
		html text: 'Do you want '.
		html anchor 
			id: 'changePassword';
			callback: [ contentBlock := self blockChangePassword ]; 
			with: 'change your password?' ]
]

{ #category : #adding }
ERAdminView >> renderButtonsOn: html [
	self renderCancelButtonOn: html.
	self renderAcceptButtonOn: html.
]

{ #category : #adding }
ERAdminView >> renderCancelButtonOn: html [
	html mdlButton
		colored;
		id: 'cancel-user';
		callback: [ self cancel ];
		with: 'Cancel'.
]

{ #category : #adding }
ERAdminView >> renderContentPageOn: html [
	html div
		class: 'mdl-tabs mdl-js-tabs mdl-js-ripple-effect';
		with: [ contentBlock cull: html]
		
]
