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
	super initialize .
	title := 'User Login'.
	icon := 'person'.
	messageComponent := (ERComponentAlert warningAlert id: 'loginAlert').
	id := 'login'.
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
ERLoginView >> renderFieldsLoginOn: html [
	html
		render:
			(ERTextFieldLabel
				label: 'Email'
				callback: [ :value | self controller user email: value asString ]
				id: 'emailLogin').
	html
		render:
			(ERTextFieldLabel
				label: 'Password'
				callback: [ :value | 
					self controller user
						password: (ERUserAccount hashPassword: value) asString ]
				id: 'passwordLogin') forPassword
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
	html html: '<button class="mdl-button mdl-js-button mdl-button--primary">Forgot Password</button> </div>']
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
		id: 'register-button';
		callback: [ self registerUser ];
		with: 'Register'
]
