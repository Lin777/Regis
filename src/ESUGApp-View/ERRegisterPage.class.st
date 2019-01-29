Class {
	#name : #ERRegisterPage,
	#superclass : #ERPage,
	#instVars : [
		'tabs',
		'actionRegister',
		'messageComponent'
	],
	#category : #'ESUGApp-View-Page'
}

{ #category : #accessing }
ERRegisterPage >> actionRegister: anObject [
	actionRegister := anObject
]

{ #category : #'as yet unclassified' }
ERRegisterPage >> actionsBody: html [
	^ [
	html mdlCardActions border with: [	
			self renderBackLoginButtonOn: html.
			self renderBackButtonOn: html.
			self renderSkipButtonOn: html.
			self renderNextButtonOn: html.
		].
	]
]

{ #category : #adding }
ERRegisterPage >> addTab: aAttendeeTabForm [
	self tabs add: aAttendeeTabForm
]

{ #category : #initialization }
ERRegisterPage >> convertToGroupManager [
	self attendee userAccount role: 'groupManager'
]

{ #category : #initialization }
ERRegisterPage >> initialize [
	super initialize.
	icon := 'assignment'.
	messageComponent := ERAlert warningAlert id: 'registerAlert'.
	pageController := ERRegistrationController new.
	id := 'login-conatiner'.
	classContainer := 'mdl-card-register'
]

{ #category : #initialization }
ERRegisterPage >> initializeTabForms [
	self subclassResponsibility 
]

{ #category : #'tools registry' }
ERRegisterPage >> register [
	| user |
	user := pageController save.
	self validateRegister: user
]

{ #category : #initialization }
ERRegisterPage >> registerAsGroupManager [
	| user |
	
	user := pageController saveAsGroupManager.
	self validateRegister: user
]

{ #category : #'as yet unclassified' }
ERRegisterPage >> renderBackButtonOn: html [
	html mdlAnchorButton
		colored;
		rippleEffect;
		id: 'previousButton';
		class: 'btnPrevious';
		with: 'Previous'
]

{ #category : #rendering }
ERRegisterPage >> renderBackLoginButtonOn: html [
	html mdlAnchorButton
		colored;
		rippleEffect;
		id: 'backLogin';
		callback: [ self returnToThePreviousState  ];
		with: 'Back Login'
]

{ #category : #rendering }
ERRegisterPage >> renderBody: html with: aBlock [
	html div style: 'background-image: url(''/files/CssForLoginMDL/profile_city.jpg''); background-repeat: repeat-y; background-size: cover; height: 100vh; ';
	with: [ 
		html break. html break. html break. 
		aBlock value	
	]
]

{ #category : #rendering }
ERRegisterPage >> renderDoneButtonOn: html [
	self
		createRaisedRippleEffectPrimaryButton: 'Save Information'
		with: [ [ self validateAndRegister ]
				on: ERException
				do:
					[ :exception | messageComponent errorMessage: exception messageText ] ]
		id: 'registerButton'
		on: html
]

{ #category : #'as yet unclassified' }
ERRegisterPage >> renderNextButtonOn: html [
	html mdlAnchorButton
		colored;
		rippleEffect;
		id: 'nextButton';
		class: 'btnNext';
		with: 'Next'
]

{ #category : #rendering }
ERRegisterPage >> renderPageOn: html [
	html render: messageComponent.
	html form
		id: 'registerForm';
		with: [ html mdlTabs rippleEffect with: [ html render: (ERTabs tabs: self tabs) ] ].
]

{ #category : #'as yet unclassified' }
ERRegisterPage >> renderSkipButtonOn: html [
]

{ #category : #hooks }
ERRegisterPage >> states [
    ^ Array with: self
]

{ #category : #accessing }
ERRegisterPage >> tabs [
	tabs ifNil: [ tabs:= OrderedCollection new].
	^ tabs.
]

{ #category : #initialize }
ERRegisterPage >> validateAndRegister [
	^ self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
ERRegisterPage >> validateRegister: user [
	user notNil
		ifTrue: [ self answer: user ]
		ifFalse:
			[ messageComponent errorMessage: 'This email is already registered' ]
]
