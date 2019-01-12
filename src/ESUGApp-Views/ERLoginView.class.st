Class {
	#name : #ERLoginView,
	#superclass : #ERPageView,
	#instVars : [
		'messageComponent'
	],
	#category : #'ESUGApp-Views'
}

{ #category : #'as yet unclassified' }
ERLoginView >> actionsBody: html [
	^ [
	html mdlCardActions with: [	
		self renderRegisterAsGroupManagerButtonOn: html.
		html mdlAnchorButton 
		class: 'mdl-color-text--blue'"primaryColor";
		with: 'Forgot Password'
		]
	]
]

{ #category : #initialization }
ERLoginView >> initialize [
	super initialize.
	title := 'User Login'.
	icon := 'person'.
	messageComponent := ERComponentAlert warningAlert id: 'loginAlert'.
	id := 'login-conatiner'.
	pageController := ERLoginController new
]

{ #category : #rendering }
ERLoginView >> loginUser [
	| userValidate |
	userValidate := self controller validateLogin.
	userValidate notNil
		ifTrue: [ 
			self session login: userValidate.
			self call: ERPageLoggedView new ]
		ifFalse: [ messageComponent errorMessage: 'Login failed.' ]
]

{ #category : #rendering }
ERLoginView >> registerAsGroupManager [
	pageController conferenceIsOpenRegistration
		ifTrue: [ 
			| formRegister |
			formRegister := ERGroupManagerRegistrationView new.
			formRegister content: self content.
			formRegister initializeTabForms ]
		ifFalse: [ messageComponent errorMessage: 'The registration is not open' ]
]

{ #category : #rendering }
ERLoginView >> registerUser [
	pageController conferenceIsOpenRegistration
		ifTrue: [
			| formRegister |
			formRegister := ERAttendeeRegistrationView new.
			formRegister content: self content.
			formRegister initializeTabForms ]
		ifFalse: [ messageComponent errorMessage: 'The registration is not open' ]
]

{ #category : #rendering }
ERLoginView >> renderBody: html with: aBlock [
	html div style: 'background-image: url(''/files/CssForLoginMDL/profile_city.jpg''); background-size: cover; height: 100vh; ';
	with: [ 
		html mdlLayout	with: aBlock
	]
]

{ #category : #rendering }
ERLoginView >> renderEmailField: html [
	self
	createRequiredField: 'Email' id: 'email-login' type: 'email' callback: [ :value | self controller user email: value asString ] on: html.
"
		createTextField: 'Email'
		id: 'email-login'
		callback: [ :value | self controller user email: value asString ]
		on: html."
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
		"colored;"
		rippleEffect;
		accentColor;
		id: 'login-button';
		class: 'login-button mdl-color--blue-700 mdl-color-text--white';
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
			self renderLoginButtonOn: html.].
			self renderRegisterButtonOn: html.

]

{ #category : #rendering }
ERLoginView >> renderPasswordField: html [
	self
		createPasswordField: 'Password'
		id: 'password-login'
		with: [:mdlTxtInput | 
			mdlTxtInput required;
			callback: [ :value | 
			self controller user
				password: (ERUserAccount hashPassword: value) asString ] ]
		on: html
]

{ #category : #rendering }
ERLoginView >> renderRegisterAsGroupManagerButtonOn: html [
	html mdlAnchorButton
		class: 'mdl-color-text--blue';
		"primaryColor ;"
		id: 'register-button-as-group-manager';
		callback: [ self registerAsGroupManager ];
		with: 'Group Manager'
]

{ #category : #rendering }
ERLoginView >> renderRegisterButtonOn: html [
	html mdlAnchorButton
		class: 'mdl-button login-button mdl-color-text-colored';
		id: 'register-button';
		callback: [ self registerUser ];
		with: 'Register'
	"mdlTextColorAccent;"
]
