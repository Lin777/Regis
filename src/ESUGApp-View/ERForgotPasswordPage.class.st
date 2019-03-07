Class {
	#name : #ERForgotPasswordPage,
	#superclass : #ERPage,
	#category : #'ESUGApp-View-Page'
}

{ #category : #'as yet unclassified' }
ERForgotPasswordPage >> actionsBody: html [
]

{ #category : #rendering }
ERForgotPasswordPage >> initialize [
	super initialize.
	title := 'Reset Password'.
	icon := 'update'.
	id := 'login-conatiner'.
]

{ #category : #rendering }
ERForgotPasswordPage >> renderBody: html with: aBlock [
	html div style: 'background-image: url(''/files/CssForLoginMDL/profile_city.jpg''); background-repeat: repeat-y; background-size: cover; height: 100vh;';
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
		callback: [ Transcript show: 'ds' ];
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
				callback: [ :value | self answer: value ] ].
]

{ #category : #rendering }
ERForgotPasswordPage >> renderPageOn: html [
	html form
		id: 'emailToSend';
		with: [ 
			self renderTextOn: html.
			self renderEmailFieldOn: html.
			self renderButtonOn: html
			]
]

{ #category : #rendering }
ERForgotPasswordPage >> renderTextOn: html [
	html horizontalRule .
	html text: 'Enter your email address and we will send you a link to reset your password.'.
	html break.
	html break.
]