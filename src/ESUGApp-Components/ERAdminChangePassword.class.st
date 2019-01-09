Class {
	#name : #ERAdminChangePassword,
	#superclass : #ERAdmin,
	#instVars : [
		'password',
		'passwordChanged',
		'passwordChangedConfirm'
	],
	#category : #'ESUGApp-Components'
}

{ #category : #rendering }
ERAdminChangePassword >> cancel [
]

{ #category : #rendering }
ERAdminChangePassword >> changePassword [
	(controller validateCurrentPassword: password) 
	ifTrue: [(controller validatePatternPassword: password)
		ifTrue: [ (controller validateNewPassword: password with: passwordChangedConfirm) 
			ifTrue: [ controller changePasswordTo: passwordChanged ] 
			ifFalse: [ messageComponent errorMessage: 'Passwords Dont Match' ]
		]
		ifFalse: [ 
			messageComponent errorMessage: 'Must contain: numbers, letters, ''.'' or ''_'', and at least 8 or more characters'	
		]
	] ifFalse: [ 
		messageComponent errorMessage: 'The password entered does not match the current password' ].
	"(controller
		changePasswordFrom: password
		to: passwordChanged)
		ifNil: [ messageComponent
				errorMessage: 'The password entered does not match the current password' ]"

]

{ #category : #initialization }
ERAdminChangePassword >> initialize [
	super initialize.
	messageComponent := ERComponentAlert warningAlert
		id: 'adminChangePasswordAlert'
]

{ #category : #rendering }
ERAdminChangePassword >> renderAcceptButtonOn: html [
	html mdlButton
		colored;
		id: 'accept-change-password';
		callback: [ self changePassword ];
		with: 'Accept'
]

{ #category : #rendering }
ERAdminChangePassword >> renderButtons: html [
	self renderAcceptButtonOn: html.
	self renderCancelButtonOn: html
]

{ #category : #rendering }
ERAdminChangePassword >> renderCancelButtonOn: html [
	html mdlButton
		colored;
		id: 'cancel-user';
		callback: [ self cancel ];
		with: 'Cancel'
]

{ #category : #rendering }
ERAdminChangePassword >> renderContainer: html [
	html horizontalRule .
	self renderFormOn: html
]

{ #category : #rendering }
ERAdminChangePassword >> renderFields: html [
	self createPasswordField: 'Current Password: ' id: 'currentPassword' 
	with: [:mdlTxtInput | mdlTxtInput callback: [:value | password := value ] ] on: html.
	self createPasswordField: 'Password: ' id: 'newPassword' 
	with: [ :mdlTxtInput | 
		mdlTxtInput callback: [:value |  passwordChanged := value ].
		html mdlTextFieldError: 'Must contain: numbers, letters, ''.'' and/or ''_'', and at least 8 and more characters'. ]
	   on: html .
	self createPasswordField: 'Confirm password: ' id: 'confNewPassword' with: [ :mdlTxtInput | 
		mdlTxtInput callback: [:value | passwordChangedConfirm := value ]. 
		html mdlTextFieldError: ''] on: html.
]

{ #category : #rendering }
ERAdminChangePassword >> renderFormOn: html [
	html form
		method: 'post';
		id: 'groupManagerFunctions';
		with: [ 
			html render: messageComponent .
			self renderFields: html.
			self renderButtons: html ]
]

{ #category : #accessing }
ERAdminChangePassword >> tabId [
	^ 'changePassword'
]

{ #category : #accessing }
ERAdminChangePassword >> tabName [
	^ 'Change Password'
]

{ #category : #accessing }
ERAdminChangePassword >> title [
	^ 'Modify Password'
]
