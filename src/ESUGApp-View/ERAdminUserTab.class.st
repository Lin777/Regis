Class {
	#name : #ERAdminUserTab,
	#superclass : #ERContentAdminTab,
	#instVars : [
		'modifiedUser'
	],
	#category : #'ESUGApp-View-Tab'
}

{ #category : #'as yet unclassified' }
ERAdminUserTab class >> on: anAttendee withContent: aContent [
	| form |
	form := self new.
	form attendee: anAttendee.
	form content: aContent.
	form initializeController.
	form initializeUserCopy.
	^ form
]

{ #category : #rendering }
ERAdminUserTab >> acceptUser [
	[ controller updateUser: attendee userAccount ]
		on: ERException
		do: [ :exception | "
			attendee userAccount abortChanges.
			attendee abortChanges."
			messageComponent errorMessage: exception messageText ].
	self updateStateTab: self tabName
]

{ #category : #rendering }
ERAdminUserTab >> cancel [
	attendee abortChanges.
	self updateStateTab: self tabName.
]

{ #category : #initialization }
ERAdminUserTab >> initialize [
	super initialize.
	messageComponent id: 'adminUserAlert'
]

{ #category : #initialization }
ERAdminUserTab >> initializeUserCopy [
	modifiedUser := attendee userAccount
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
				callback: [ :value | attendee email: value ] ]
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
				callback: [ :value | attendee firstName: value ] ]
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
				callback: [ :value | attendee lastName: value ] ]
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
