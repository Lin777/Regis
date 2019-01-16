Class {
	#name : #ERAdminUserTab,
	#superclass : #ERContentAdminTab,
	#instVars : [
		'modifiedUser'
	],
	#category : #'ESUGApp-View-Tab'
}

{ #category : #rendering }
ERAdminUserTab >> acceptUser [
	(controller updateUserFields: modifiedUser)
		ifNil: [ messageComponent
				errorMessage:
					'This email is already registered, change the email for continue with your updating' ].
	self updateStateTab: self tabName
]

{ #category : #rendering }
ERAdminUserTab >> cancel [
	self updateStateTab: self tabName
]

{ #category : #initialization }
ERAdminUserTab >> initialize [
	super initialize.
	modifiedUser := ERUserAccount new.
	messageComponent id: 'adminUserAlert'
]

{ #category : #rendering }
ERAdminUserTab >> renderAcceptButtonOn: html [
	html mdlButton
		colored;
		id: 'accept-user';
		callback: [ self acceptUser ];
		with: 'Accept'
]

{ #category : #rendering }
ERAdminUserTab >> renderButtons: html [
	self renderAcceptButtonOn: html.
	self renderCancelButtonOn: html.
]

{ #category : #rendering }
ERAdminUserTab >> renderCancelButtonOn: html [
	html mdlButton
		colored;
		id: 'cancel-user';
		callback: [ self cancel ];
		with: 'Cancel'.
]

{ #category : #rendering }
ERAdminUserTab >> renderContainer: html [
	html horizontalRule .
	self renderFormOn: html
	
]

{ #category : #rendering }
ERAdminUserTab >> renderEmailInputTextOn: html [
	html mdlTextFieldContainer
		floatingLabel;
		with: [ html mdlTextFieldLabel
				for: 'email';
				with: 'Email: '.
			html mdlTextFieldInput
				id: 'email';
				type: 'text';
				value: attendee email;
				callback: [ :value | modifiedUser email: value ] ]
]

{ #category : #rendering }
ERAdminUserTab >> renderFields: html [
	self renderFirstNameInputTextOn: html.
	self renderLastNameInputTextOn: html.
	self renderEmailInputTextOn: html
]

{ #category : #rendering }
ERAdminUserTab >> renderFirstNameInputTextOn: html [
	html mdlTextFieldContainer
		floatingLabel;
		with: [ html mdlTextFieldLabel
				for: 'firstName';
				with: 'First Name: '.
			html mdlTextFieldInput
				id: 'firstName';
				type: 'text';
				value: attendee firstName;
				callback: [ :value | modifiedUser firstName: value ] ]
]

{ #category : #rendering }
ERAdminUserTab >> renderFormOn: html [
	html form
		method: 'post';
		id: 'groupManagerFunctionsUser';
		with: [ html render: messageComponent .
			self renderFields: html.
			self renderButtons: html ]
]

{ #category : #rendering }
ERAdminUserTab >> renderLastNameInputTextOn: html [
	html mdlTextFieldContainer
		floatingLabel;
		with: [ html mdlTextFieldLabel
				for: 'lastName';
				with: 'Last Name: '.
			html mdlTextFieldInput
				id: 'lastName';
				type: 'text';
				value: attendee lastName;
				callback: [ :value | modifiedUser lastName: value ] ]
]

{ #category : #accessing }
ERAdminUserTab >> tabId [
	^ 'adminUser'
]

{ #category : #accessing }
ERAdminUserTab >> tabName [
	^ 'User'
]

{ #category : #accessing }
ERAdminUserTab >> title [
	^ 'User'
]
