"
Description
--------------------

I am a form for change password of an user
"
Class {
	#name : #ERChangePasswordForm,
	#superclass : #ERContainerTab,
	#instVars : [
		'password',
		'passwordChanged',
		'passwordChangedConfirm',
		'cancel'
	],
	#category : #'ESUGApp-Form'
}

{ #category : #'instance creation' }
ERChangePasswordForm class >> on: anAttendee withContent: aContent container: aContainer [
	| form |
	form := super on: anAttendee withContent: aContent.
	form initializeController .
	form container: aContainer.
	^ form
]

{ #category : #accessing }
ERChangePasswordForm >> cancel [
	^ cancel
]

{ #category : #accessing }
ERChangePasswordForm >> cancel: aBlock [
	cancel := aBlock
]

{ #category : #action }
ERChangePasswordForm >> changePassword [
	[ controller validateCurrentPassword: password.
	controller validatePatternPassword: passwordChanged.
	controller validateNewPassword: passwordChanged with: passwordChangedConfirm. 
	controller changePasswordTo: passwordChanged.
	messageComponent changeToAlertSuccess.
	messageComponent errorMessage: 'Password change done correctly' ]
	on: ERException
	do: [ :exception |
		messageComponent changeToAlertOfError.
		messageComponent errorMessage: exception messageText.
		]
]

{ #category : #hooks }
ERChangePasswordForm >> children [
	^ super children asOrderedCollection copyWithAll: (OrderedCollection new
		add: messageComponent;
		yourself) yourself
]

{ #category : #initialization }
ERChangePasswordForm >> initialize [
	super initialize.
	messageComponent id: 'changePasswordAlert'.
]

{ #category : #initialization }
ERChangePasswordForm >> initializeController [
	controller := ERLoggedController
		attendee: attendee
]

{ #category : #rendering }
ERChangePasswordForm >> renderAcceptButtonOn: html [
	html mdlButton
		colored;
		id: 'accept-change-password';
		callback: [ self changePassword ];
		with: 'Accept'
]

{ #category : #rendering }
ERChangePasswordForm >> renderButtonsOn: html [
	self renderCancelButtonOn: html.
	self renderAcceptButtonOn: html.
]

{ #category : #rendering }
ERChangePasswordForm >> renderCancelButtonOn: html [
	html mdlAnchorButton
		colored;
		id: 'cancel-change-password';
		callback:  self cancel ;
		with: 'Cancel'
]

{ #category : #rendering }
ERChangePasswordForm >> renderConfirmNewPasswordOn: html [
	html mdlTextFieldContainer
		floatingLabel;
		with: [
			html mdlTextFieldLabel for: 'confirmPassword'; with: 'Confirm password: '.
			html mdlTextFieldInput 
				id: 'confirmPassword'; 
				type: 'password';
				pattern: '[A-Za-z0-9._-]{8,}';
				callback: [:value | passwordChangedConfirm := value ].
			html mdlTextFieldError: ''].
]

{ #category : #rendering }
ERChangePasswordForm >> renderContainerOn: html [
	html horizontalRule .
	self renderFormOn: html
]

{ #category : #rendering }
ERChangePasswordForm >> renderCurrentPasswordOn: html [
	html mdlTextFieldContainer
		floatingLabel;
		with: [
			html mdlTextFieldLabel for: 'currentPassword'; with:'Current Password: '.
			html mdlTextFieldInput 
				id: 'currentPassword'; 
				type: 'password';
				pattern: '[A-Za-z0-9._-]{8,}';
				callback: [:value | password := value ]].
]

{ #category : #rendering }
ERChangePasswordForm >> renderFields: html [
	self renderCurrentPasswordOn: html.
	self renderNewPasswordOn: html.
	self renderConfirmNewPasswordOn: html.
]

{ #category : #rendering }
ERChangePasswordForm >> renderFormOn: html [
	html form
		method: 'post';
		id: 'changePasswordForm';
		with: [ 
			html render: messageComponent.
			self renderFields: html.
			self renderButtonsOn: html.
		]
]

{ #category : #rendering }
ERChangePasswordForm >> renderNewPasswordOn: html [
	html mdlTextFieldContainer
		floatingLabel;
		with: [
			html mdlTextFieldLabel for: 'password'; with: 'Password: '.
			html mdlTextFieldInput 
				id: 'password'; 
				type: 'password';
				pattern: '[A-Za-z0-9._-]{8,}';
				callback: [:value |  passwordChanged := value ].
			html mdlTextFieldError: 'Must contain: numbers, letters, ''.'' and/or ''_'', and at least 8 and more characters'].
]

{ #category : #accessing }
ERChangePasswordForm >> tabId [
	^ 'changePassword'
]

{ #category : #accessing }
ERChangePasswordForm >> tabName [
	^ 'Change Password'
]

{ #category : #accessing }
ERChangePasswordForm >> title [
	^ 'Modify Password'
]
