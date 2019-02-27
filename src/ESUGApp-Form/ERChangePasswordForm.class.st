Class {
	#name : #ERChangePasswordForm,
	#superclass : #ERContentAdminTab,
	#instVars : [
		'password',
		'passwordChanged',
		'passwordChangedConfirm'
	],
	#category : #'ESUGApp-Form'
}

{ #category : #rendering }
ERChangePasswordForm >> cancel [
	self updateStateTab: self tabName 
]

{ #category : #rendering }
ERChangePasswordForm >> changePassword [
	(controller validateCurrentPassword: password) 
	ifTrue: [(controller validatePatternPassword: passwordChanged)
		ifTrue: [ (controller validateNewPassword: passwordChanged with: passwordChangedConfirm) 
			ifTrue: [ controller changePasswordTo: passwordChanged ] 
			ifFalse: [ messageComponent errorMessage: 'Passwords Dont Match' ].
		]
		ifFalse: [ 
			messageComponent errorMessage: 'Must contain: numbers, letters, ''.'' or ''_'', and at least 8 or more characters'.
		]
	] ifFalse: [ 
		messageComponent errorMessage: 'The password entered does not match the current password'.
		].
	self updateStateTab: self tabName

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
	messageComponent id: 'adminChangePasswordAlert'.
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
	self renderAcceptButtonOn: html.
	self renderCancelButtonOn: html
]

{ #category : #rendering }
ERChangePasswordForm >> renderCancelButtonOn: html [
	html mdlButton
		colored;
		id: 'cancel-change-password';
		callback: [ self cancel ];
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
		id: 'groupManagerFunctions';
		with: [ 
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
