Class {
	#name : #ERAdminChangePassword,
	#superclass : #ERTabContainerPage,
	#instVars : [
		'messageComponent',
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
	self validateCurrentPassword
		ifTrue: [ attendee
				password: (ERUserAccount hashPassword: passwordChanged) asString.
			attendee save ]
		ifFalse: [ messageComponent
				errorMessage: 'The current password is incorrect' ]
]

{ #category : #initialization }
ERAdminChangePassword >> initialize [
	super initialize.
	messageComponent := (ERComponentAlert warningAlert id: 'adminChangePasswordAlert').
]

{ #category : #rendering }
ERAdminChangePassword >> renderButtons: html [
	html render: (self createButtonField: 'Accept'
							with: [ self changePassword ]
							id: 'accept-changePassword') forAcceptButton.
	html render:(self createButtonField: 'Cancel'
							with: [ self cancel ]
							id: 'cancel-changePassword') forAcceptButton
]

{ #category : #rendering }
ERAdminChangePassword >> renderContainer: html [
	html horizontalRule .
	self renderFormOn: html
]

{ #category : #rendering }
ERAdminChangePassword >> renderFields: html [
	html render: (self createTextField: 'Current Password: ' callback: [:value | password := value ]) forPassword.
	html render: (self createTextField: 'Password: ' callback: [:value |  passwordChanged := value ]) forPassword.
	html render: (self createTextField: 'Confirm password: ' callback: [:value | passwordChangedConfirm := value ]) forPassword.
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

{ #category : #rendering }
ERAdminChangePassword >> validateCurrentPassword [
	^ attendee password = (ERUserAccount hashPassword: password) asString
]
