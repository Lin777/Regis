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

{ #category : #'as yet unclassified' }
ERLoginPage >> actionsBody: html [
	^ [
	html mdlCardActions with: [	
		self renderRegisterAsGroupManagerButtonOn: html.
		html mdlAnchorButton 
		class: 'mdl-color-text--blue';
		with: 'Forgot Password'
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
	pageController := ERController new.
]

{ #category : #rendering }
ERLoginPage >> loginUser [
	| userValidate |
	userValidate := self controller validateLoginFor: email password: password.
	userValidate notNil
		ifTrue: [ 
			self session login: userValidate.
			self call: ERLoggedPage new ]
		ifFalse: [ messageComponent errorMessage: 'Login failed.' ]
]

{ #category : #accessing }
ERLoginPage >> password: anObject [
	password := anObject
]

{ #category : #rendering }
ERLoginPage >> registerAsGroupManager [
	pageController conferenceIsOpenRegistration
		ifTrue: [ 
			| formRegister |
			formRegister := ERGroupManagerRegistrationPage new.
			formRegister content: self content.
			formRegister initializeTabForms ]
		ifFalse: [ messageComponent errorMessage: 'The registration is not open' ]
]

{ #category : #rendering }
ERLoginPage >> registerUser [
	pageController conferenceIsOpenRegistration
		ifTrue: [
			| formRegister |
			formRegister := ERAttendeeRegistrationPage 
								content: self content ]
		ifFalse: [ messageComponent errorMessage: 'The registration is not open' ]
]

{ #category : #rendering }
ERLoginPage >> renderBody: html with: aBlock [
	html div style: 'background-image: url(''/files/CssForLoginMDL/profile_city.jpg''); background-repeat: repeat-y; background-size: cover; height: 100vh;';
	with: [ 
		html mdlLayout	with: aBlock
	]
]

{ #category : #rendering }
ERLoginPage >> renderEmailField: html [
	html mdlTextFieldContainer
		floatingLabel;
		with: [ html mdlTextFieldLabel
				for: 'email-login';
				with: 'Email'.
			html mdlTextFieldInput
				id: 'email-login';
				required;
				type: 'email';
				callback: [ :value | self email: value asString ] ]
"
		createTextField: 'Email'
		id: 'email-login'
		callback: [ :value | self controller user email: value asString ]
		on: html."
]

{ #category : #rendering }
ERLoginPage >> renderFieldsLoginOn: html [
	self renderEmailField: html.
	self renderPasswordFieldOn: html
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
			self renderLoginButtonOn: html.].
			self renderRegisterButtonOn: html
]

{ #category : #rendering }
ERLoginPage >> renderPasswordFieldOn: html [
	self
		createPasswordField: 'Password'
		id: 'password-login'
		with: [:mdlTxtInput | 
			mdlTxtInput required;
			callback: [ :value | 
			self password: (ERUserAccount hashPassword: value) asString ] ]
		on: html
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
	html mdlAnchorButton
		class: 'mdl-button login-button mdl-color-text-colored';
		id: 'register-button';
		callback: [ self registerUser ];
		with: 'Register'
]
