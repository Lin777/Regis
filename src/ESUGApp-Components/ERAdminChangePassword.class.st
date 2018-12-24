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
	(controller
		changePasswordFrom: password
		to: passwordChanged)
		ifNil: [ messageComponent
				errorMessage: 'The password entered does not match the current password' ]

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
	self createPasswordField: 'Current Password: ' withCallback: [:value | password := value ] on: html.
	self createPasswordField: 'Password: ' withCallback: [:value |  passwordChanged := value ] on: html.
	self createPasswordField: 'Confirm password: ' withCallback: [:value | passwordChangedConfirm := value ] on: html.
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
