"
Description
--------------------

I am an Page to sent reseted password (Forgot Password Page)

Instance Variables
--------------------

messageComponent:  <aComponent> ERAlert to show any type of message
email: 				 instance variable to save value of email field to sent email
"
Class {
	#name : #ERForgotPasswordPage,
	#superclass : #ERPage,
	#instVars : [
		'email',
		'messageComponent'
	],
	#category : #'ESUGApp-View-Page'
}

{ #category : #rendering }
ERForgotPasswordPage >> email: aString [
	email := aString
]

{ #category : #rendering }
ERForgotPasswordPage >> initialize [
	super initialize.
	title := 'Reset Password'.
	icon := 'update'.
	messageComponent := ERAlert warningAlert id: 'loginAlert'.
	id := 'login-conatiner'.
]

{ #category : #rendering }
ERForgotPasswordPage >> renderBody: html with: aBlock [
	html div style: self styleBackgound ;
	with: [ 
		html mdlLayout	with: aBlock
	]
]

{ #category : #rendering }
ERForgotPasswordPage >> renderButtonOn: html [
	html mdlButton
			colored;
		beSubmit ;
		id: 'login-button';
		class: 'login-button mdl-color--blue-500 mdl-color-text--white';
		callback: [ self sendResetedPassword ];
		with: 'Send password reset email'.
]

{ #category : #rendering }
ERForgotPasswordPage >> renderEmailFieldOn: html [
	html mdlTextFieldContainer
		floatingLabel;
		with: [ 
			html mdlTextFieldLabel
				for: 'email';
				with: 'Email'.
			html mdlTextFieldInput
				id: 'email';
				type: 'email';
				callback: [ :value | self email: value ] ].
]

{ #category : #rendering }
ERForgotPasswordPage >> renderPageOn: html [
	html form
		id: 'emailToSend';
		with: [ 
			html render: messageComponent .
			self renderTextOn: html.
			self renderEmailFieldOn: html.
			self renderButtonOn: html
			]
]

{ #category : #rendering }
ERForgotPasswordPage >> renderTextOn: html [
	html horizontalRule .
	html text: 'Enter your email address and we will send you a mail with your reseted password.'.
	html break.
	html break.
]

{ #category : #rendering }
ERForgotPasswordPage >> sendResetedPassword [
	(email isNil or: [ email isEmpty  ]) ifFalse: [
	[ pageController sendResetPasswordTo: email.
	self requestContext redirectTo: self application url ]
	on: PMException, ERException  
	do: [ :exception | messageComponent errorMessage: exception messageText]]
]
