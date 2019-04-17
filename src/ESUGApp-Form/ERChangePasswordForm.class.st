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

{ #category : #'as yet unclassified' }
ERChangePasswordForm class >> on: anAttendee withContent: aContent container: aContainer [
	| form |
	form := super on: anAttendee withContent: aContent.
	form initializeController .
	form container: aContainer.
	^ form
]

{ #category : #rendering }
ERChangePasswordForm >> cancel [
	^ cancel
]

{ #category : #rendering }
ERChangePasswordForm >> cancel: aBlock [
	cancel := aBlock
]

{ #category : #rendering }
ERChangePasswordForm >> changePassword [
	[controller validateCurrentPassword: password.
	controller validatePatternPassword: passwordChanged.
	controller validateNewPassword: passwordChanged with: passwordChangedConfirm. 
	controller changePasswordTo: passwordChanged.
	messageComponent changeToAlertSuccess.
	messageComponent errorMessage: 'Change password succesfull'.
	self cancel value]
	on: ERException
	do: [ :exception |
		"self halt."
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
	controller := ERAdminController
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
	html mdlButton
		colored;
		id: 'cancel-change-password';
		callback:  self cancel ;
		with: 'Cancel'
]

{ #category : #rendering }
ERChangePasswordForm >> renderConfirmNewPasswordOn: html [
	self createPasswordField: 'Confirm password: ' id: 'confirmPassword' with: [ :mdlTxtInput | 
		mdlTxtInput callback: [:value | passwordChangedConfirm := value ]. 
		html mdlTextFieldError: ''] on: html.
]

{ #category : #rendering }
ERChangePasswordForm >> renderContainerOn: html [
	html horizontalRule .
	self renderFormOn: html
]

{ #category : #rendering }
ERChangePasswordForm >> renderCurrentPasswordOn: html [
	self createPasswordField: 'Current Password: ' id: 'currentPassword' 
	with: [:mdlTxtInput | mdlTxtInput callback: [:value | password := value ] ] on: html.
	
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
		with: [ "
			self halt."
			html render: messageComponent.
			self renderFields: html.
			self renderButtonsOn: html.
		]
]

{ #category : #rendering }
ERChangePasswordForm >> renderNewPasswordOn: html [
	self createPasswordField: 'Password: ' id: 'password' 
	with: [ :mdlTxtInput | 
		mdlTxtInput callback: [:value |  passwordChanged := value ].
		html mdlTextFieldError: 'Must contain: numbers, letters, ''.'' and/or ''_'', and at least 8 and more characters'. ]
	   on: html .
	
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
