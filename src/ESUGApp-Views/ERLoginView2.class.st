Class {
	#name : #ERLoginView2,
	#superclass : #ERPageView,
	#instVars : [
		'tabs',
		'messageComponent'
	],
	#category : #'ESUGApp-Views'
}

{ #category : #'as yet unclassified' }
ERLoginView2 >> actionsBody: html [
	^ [
	html mdlCardActions with: [	
		self renderRegisterAsGroupManagerButtonOn: html.
		html mdlAnchorButton primaryColor;
		with: 'Forgot Password'
		]
	]
]

{ #category : #initialization }
ERLoginView2 >> initialize [
	super initialize.
	title := 'User Login'.
	icon := 'person'.
	messageComponent := ERComponentAlert warningAlert id: 'loginAlert'.
	id := 'login-conatiner'.
	pageController := ERLoginController new
]

{ #category : #rendering }
ERLoginView2 >> loginUser [
	| userValidate  |
	userValidate := self controller validateLogin.
	userValidate notNil
		ifTrue: [ self answer: userValidate ]
		ifFalse:
			[ messageComponent errorMessage: 'Login failed.' ]
]

{ #category : #rendering }
ERLoginView2 >> registerUser [
	self answer: #registerUser

]

{ #category : #rendering }
ERLoginView2 >> renderBody: html with: aBlock [
	html div style: 'background-image: url(''/files/CssForLoginMDL/profile_city.jpg''); background-size: cover; height: 100vh; ';
	with: [ 
		html mdlLayout	with: aBlock
	]
]

{ #category : #rendering }
ERLoginView2 >> renderEmailField: html [
	self
	createRequiredField: 'Email' id: 'email-login' type: 'email' callback: [ :value | self controller user email: value asString ] on: html.
"
		createTextField: 'Email'
		id: 'email-login'
		callback: [ :value | self controller user email: value asString ]
		on: html."
]

{ #category : #rendering }
ERLoginView2 >> renderFieldsLoginOn: html [
	self renderEmailField: html.
	self renderPasswordField: html
]

{ #category : #rendering }
ERLoginView2 >> renderLoginButtonOn: html [
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
ERLoginView2 >> renderMessageComponent: html [
	html render: messageComponent 
]

{ #category : #rendering }
ERLoginView2 >> renderPageOn: html [
	html form
		id: 'loginForm';
		with: [ 
			self renderMessageComponent: html.
			self renderFieldsLoginOn:html.
			self renderLoginButtonOn: html.
			self renderRegisterButtonOn: html.
	]
]

{ #category : #rendering }
ERLoginView2 >> renderPasswordField: html [
	self
		createPasswordRequiredField: 'Password'
		id: 'password-login'
		callback: [ :value | 
			self controller user
				password: (ERUserAccount hashPassword: value) asString ]
		on: html
]

{ #category : #rendering }
ERLoginView2 >> renderRegisterAsGroupManagerButtonOn: html [
	html mdlAnchorButton
		primaryColor ;
		id: 'register-button-as-group-manager';
		callback: [ self answer: #registerUserAsGroupManager ];
		with: 'Group Manager'
]

{ #category : #rendering }
ERLoginView2 >> renderRegisterButtonOn: html [
	html mdlButton
		beSubmit;
		mdlTextColorAccent;
		class: 'login-button';
		id: 'register-button';
		callback: [ self registerUser ];
		with: 'Register'
]
