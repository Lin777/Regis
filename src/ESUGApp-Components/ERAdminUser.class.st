Class {
	#name : #ERAdminUser,
	#superclass : #ERTabContainerPage,
	#instVars : [
		'newFirstName',
		'newLastName',
		'newEmail'
	],
	#category : #'ESUGApp-Components'
}

{ #category : #rendering }
ERAdminUser >> acceptUser [
	((ERUserAccount findUserByEmail: newEmail) isNil
		or: attendee email = newEmail)
		ifTrue: [ ^ self updateAttendee ]
		ifFalse: [ messageComponent
				errorMessage:
					'This email is already registered, change the email for continue with your updating' ]
]

{ #category : #rendering }
ERAdminUser >> cancel [
]

{ #category : #initialization }
ERAdminUser >> initialize [
	super initialize.
	messageComponent := (ERComponentAlert warningAlert id: 'adminUserAlert').
]

{ #category : #rendering }
ERAdminUser >> renderAcceptButtonOn: html [
	html mdlButton
		colored;
		id: 'accept-user';
		callback: [ self acceptUser ];
		with: 'Accept'
]

{ #category : #rendering }
ERAdminUser >> renderButtons: html [
	self renderAcceptButtonOn: html.
	self renderCancelButtonOn: html.
]

{ #category : #rendering }
ERAdminUser >> renderCancelButtonOn: html [
	html mdlButton
		colored;
		id: 'cancel-user';
		callback: [ self cancel ];
		with: 'Cancel'.
]

{ #category : #rendering }
ERAdminUser >> renderContainer: html [
	html horizontalRule .
	self renderFormOn: html
	
]

{ #category : #rendering }
ERAdminUser >> renderEmailInputTextOn: html [
	"html
		render:
			(self
				createTextField: 'Email: '
				for: #email:
				withValue: attendee email)"
		html mdlTextFieldContainer
		floatingLabel;
		with: [ html mdlTextFieldLabel
				for: 'email';
				with: 'Email: '.
			html mdlTextFieldInput
				id: 'email';
				type: 'text';
				value: attendee email;
				callback: [ :value | newEmail := value ] ]
]

{ #category : #rendering }
ERAdminUser >> renderFields: html [
	self renderFirstNameInputTextOn: html.
	self renderLastNameInputTextOn: html.
	self renderEmailInputTextOn: html
]

{ #category : #rendering }
ERAdminUser >> renderFirstNameInputTextOn: html [
	"html
		render:
			(self
				createTextField: 'First Name: '
				for: #firstName:
				withValue: attendee firstName).
				"
	html mdlTextFieldContainer
		floatingLabel;
		with: [ html mdlTextFieldLabel
				for: 'firstName';
				with: 'First Name: '.
			html mdlTextFieldInput
				id: 'firstName';
				type: 'text';
				value: attendee firstName;
				callback: [:value | newFirstName := value] ]
]

{ #category : #rendering }
ERAdminUser >> renderFormOn: html [
	html form
		method: 'post';
		id: 'groupManagerFunctions';
		with: [ html render: messageComponent .
			self renderFields: html.
			self renderButtons: html ]
]

{ #category : #rendering }
ERAdminUser >> renderLastNameInputTextOn: html [
	"html
		render:
			(self
				createTextField: 'Last Name: '
				for: #lastName:
				withValue: attendee lastName)"
	html mdlTextFieldContainer
		floatingLabel;
		with: [ html mdlTextFieldLabel
				for: 'lastName';
				with: 'Last Name: '.
			html mdlTextFieldInput
				id: 'lastName';
				type: 'text';
				value: attendee lastName;
				callback: [ :value | newLastName := value ] ]
]

{ #category : #accessing }
ERAdminUser >> tabId [
	^ 'adminUser'
]

{ #category : #accessing }
ERAdminUser >> tabName [
	^ 'User'
]

{ #category : #accessing }
ERAdminUser >> title [
	^ 'User'
]

{ #category : #rendering }
ERAdminUser >> updateAttendee [
	^ (attendee
				email: newEmail;
				firstName: newFirstName;
				lastName: newLastName;
				userAccount) save
]
