"
Description
--------------------

I am a Login Page for esug.

Instance Variables
--------------------

messageComponent:  <aComponent> ERAlert to show any type of message
email: 				 instance variable to save value of email field
password:          instance variable to save value of password field

"
Class {
	#name : #ERLoginPage,
	#superclass : #ERPage,
	#instVars : [
		'messageComponent',
		'email',
		'password'
	],
	#category : #'ESUGApp-View-Page'
}

{ #category : #rendering }
ERLoginPage >> actionsBody: html [
	^ [
	html mdlCardActions with: [	
		self renderRegisterAsGroupManagerButtonOn: html.
		self renderForgotPasswordButtonOn: html
		]
	]
]

{ #category : #accessing }
ERLoginPage >> email: anObject [
	email := anObject
]

{ #category : #initialization }
ERLoginPage >> initialize [
	super initialize.
	title := 'User Login'.
	icon := 'person'.
	messageComponent := ERAlert warningAlert id: 'loginAlert'.
	id := 'login-conatiner'.
]

{ #category : #actions }
ERLoginPage >> loginUser [
	| userValidate |
	self controller conference ifNotNil: [
	userValidate := self controller conference validateLoginFor: email password: password.
	userValidate notNil
		ifTrue: [ 
			self session login: userValidate.
			self call: ERLoggedPage new ]
		ifFalse: [ messageComponent errorMessage: 'Login failed.' ]]
	ifNil: [ messageComponent errorMessage: 'You can not perform this action at the moment' ]
]

{ #category : #accessing }
ERLoginPage >> password: anObject [
	password := anObject
]

{ #category : #actions }
ERLoginPage >> registerAsGroupManager [
	pageController conference conferenceIsOpenRegistration
		ifTrue: [ 
			| formRegister |
			formRegister := ERGroupManagerRegistrationPage new.
			formRegister content: self content.
			formRegister initializeTabForms ]
		ifFalse: [ messageComponent errorMessage: 'The registration is not open' ]
]

{ #category : #actions }
ERLoginPage >> registerUser [
	pageController conference conferenceIsOpenRegistration
		ifTrue: [ ERAttendeeRegistrationPage content: self content ]
		ifFalse: [ messageComponent errorMessage: 'The registration is not open' ]
]

{ #category : #rendering }
ERLoginPage >> renderBody: html with: aBlock [
	html div
		style: self styleBackgound;
		with: [ html mdlLayout with: aBlock ].
	self renderFooterOn: html.
]

{ #category : #rendering }
ERLoginPage >> renderEmailFieldOn: html [
	html mdlTextFieldContainer
		floatingLabel;
		with: [ html mdlTextFieldLabel
				for: 'email-login';
				with: 'Email'.
			html mdlTextFieldInput
				id: 'email-login';
				"required;"
				type: 'email';
				callback: [ :value | self email: value asString ] ]
]

{ #category : #rendering }
ERLoginPage >> renderFieldsLoginOn: html [
	self renderEmailFieldOn: html.
	self renderPasswordFieldOn: html
]

{ #category : #rendering }
ERLoginPage >> renderForgotPasswordButtonOn: html [
	html mdlAnchorButton 
		class: 'mdl-color-text--blue';
		id: 'forgot-password';
		callback: [ self call: ERForgotPasswordPage new ];
		with: 'Forgot Password'
]

{ #category : #rendering }
ERLoginPage >> renderLoginButtonOn: html [
	html mdlButton
		beSubmit ;
		raised;
		rippleEffect;
		accentColor;
		id: 'login-button';
		class: 'login-button mdl-color--blue-700 mdl-color-text--white';
		callback: [ self loginUser  ];
		with: 'Login'.
]

{ #category : #rendering }
ERLoginPage >> renderMessageComponent: html [
	html render: messageComponent 
]

{ #category : #rendering }
ERLoginPage >> renderPageOn: html [
	html form
		id: 'loginForm';
		with: [ 
			self renderMessageComponent: html.
			self renderFieldsLoginOn:html.
			self renderLoginButtonOn: html.
			self renderRegisterButtonOn: html ].
]

{ #category : #rendering }
ERLoginPage >> renderPasswordFieldOn: html [
	html mdlTextFieldContainer
		floatingLabel;
		with: [
			html mdlTextFieldLabel for: 'password-login'; with: 'Password'.
			html mdlTextFieldInput 
				id: 'password-login'; 
				type: 'password';
				pattern: '[A-Za-z0-9._-]{8,}';
				callback: [ :value | 
			self password: (ERUserAccount hashPassword: value) asString ].
		].
]

{ #category : #rendering }
ERLoginPage >> renderRegisterAsGroupManagerButtonOn: html [
	html mdlAnchorButton
		class: 'mdl-color-text--blue';
		id: 'register-button-as-group-manager';
		callback: [ self registerAsGroupManager ];
		with: 'Group Manager'
]

{ #category : #rendering }
ERLoginPage >> renderRegisterButtonOn: html [
	html mdlButton
		class: 'mdl-button mdl-color-text-colored login-button ';
		id: 'register-button';
		callback: [ self registerUser ];
		with: 'Register'
]
