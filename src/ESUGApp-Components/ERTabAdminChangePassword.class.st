Class {
	#name : #ERTabAdminChangePassword,
	#superclass : #ERTabContainerPage,
	#instVars : [
		'password',
		'passwordChanged',
		'passwordChangedConfirm'
	],
	#category : #'ESUGApp-Components'
}

{ #category : #rendering }
ERTabAdminChangePassword >> cancel [
]

{ #category : #rendering }
ERTabAdminChangePassword >> changePassword [
	self validateCurrentPassword
		ifTrue: [ attendee
				password: (ERUserAccount hashPassword: passwordChanged) asString.
			attendee save ]
]

{ #category : #rendering }
ERTabAdminChangePassword >> renderButtons: html [
	html render: (self createButtonField: 'Accept'
							with: [ self changePassword ]
							id: 'accept-changePassword') forAcceptButton.
	html render:(self createButtonField: 'Cancel'
							with: [ self cancel ]
							id: 'cancel-changePassword') forAcceptButton
]

{ #category : #rendering }
ERTabAdminChangePassword >> renderContainer: html [
	html horizontalRule .
	self renderFormOn: html
]

{ #category : #rendering }
ERTabAdminChangePassword >> renderFields: html [
	html render: (self createTextField: 'Current Password: ' callback: [:value | password := value ]) forPassword.
	html render: (self createTextField: 'Password: ' callback: [:value |  passwordChanged := value ]) forPassword.
	html render: (self createTextField: 'Confirm password: ' callback: [:value | passwordChangedConfirm := value ]) forPassword.
]

{ #category : #rendering }
ERTabAdminChangePassword >> renderFormOn: html [

html form
		method: 'post';
		id: 'groupManagerFunctions';
		with: [
			self renderFields: html.
			self renderButtons: html.
			].
	
]

{ #category : #accessing }
ERTabAdminChangePassword >> tabId [
	^ 'changePassword'
]

{ #category : #accessing }
ERTabAdminChangePassword >> tabName [
	^ 'Change Password'
]

{ #category : #accessing }
ERTabAdminChangePassword >> title [
	^ 'Modify Password'
]

{ #category : #rendering }
ERTabAdminChangePassword >> validateCurrentPassword [
	^ attendee password = (ERUserAccount hashPassword: password) asString
]
