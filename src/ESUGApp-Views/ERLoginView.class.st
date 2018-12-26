Class {
	#name : #ERLoginView,
	#superclass : #ERPageView,
	#instVars : [
		'tabs',
		'messageComponent'
	],
	#category : #'ESUGApp-Views'
}

{ #category : #rendering }
ERLoginView >> initialize [
	super initialize.
	title := 'User Login'.
	icon := 'person'.
	messageComponent := ERComponentAlert warningAlert id: 'loginAlert'.
	id := 'body'.
	pageController := ERLoginController new
]

{ #category : #rendering }
ERLoginView >> loginUser [
	| userValidate  |
	userValidate := self controller validateLogin.
	userValidate notNil
		ifTrue: [ self answer: userValidate ]
		ifFalse:
			[ messageComponent errorMessage: 'Login failed.' ]
]

{ #category : #rendering }
ERLoginView >> registerUser [
	self answer: #registerUser
]

{ #category : #rendering }
ERLoginView >> renderEmailField: html [
	self
		createTextField: 'Email'
		id: 'email-login'
		callback: [ :value | self controller user email: value asString ]
		pattern: ERComponentFactory regularExpressionForEmail
		textError: ERComponentFactory textErrorForEmail
		on: html
]

{ #category : #rendering }
ERLoginView >> renderFieldsLoginOn: html [
	self renderEmailField: html.
	self renderPasswordField: html
]

{ #category : #rendering }
ERLoginView >> renderLoginButtonOn: html [
	html mdlButton
		beSubmit ;
		raised;
		colored;
		rippleEffect;
		accentColor;
		id: 'login-button';
		class: 'login-button mdl-color-text--white';
		callback: [ self loginUser  ];
		with: 'Login'.
]

{ #category : #rendering }
ERLoginView >> renderMessageComponent: html [
	html render: messageComponent 
]

{ #category : #rendering }
ERLoginView >> renderPageOn: html [
	html form
		id: 'loginForm';
		with: [ 
			self renderMessageComponent: html.
			self renderFieldsLoginOn:html.
			self renderLoginButtonOn: html.
			self renderRegisterButtonOn: html.
			self renderRegisterAsGroupManagerButtonOn: html.
			html mdlButton class: 'mdl-button--primary';
			with: 'Forgot Password'.
	]
]

{ #category : #rendering }
ERLoginView >> renderPasswordField: html [
	self
		createPasswordField: 'Password'
		id: 'passwordLogin'
		callback: [ :value | 
			self controller user
				password: (ERUserAccount hashPassword: value) asString ]
		pattern: ERComponentFactory regularExpressionForRequiredField
		textError: ERComponentFactory textErrorForRequiredField
		on: html
]

{ #category : #rendering }
ERLoginView >> renderRegisterAsGroupManagerButtonOn: html [
	html mdlButton
		beSubmit;
		primaryColor ;
		id: 'register-button-as-group-manager';
		callback: [ self answer: #registerUserAsGroupManager ];
		with: 'Group Manager'
]

{ #category : #rendering }
ERLoginView >> renderRegisterButtonOn: html [
	html mdlButton
		beSubmit;
		mdlTextColorAccent;
		class: 'login-button';
		id: 'register-button';
		callback: [ self registerUser ];
		with: 'Register'
]
