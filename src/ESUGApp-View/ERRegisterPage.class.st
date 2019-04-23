"
Description
--------------------

I am an abstract Page for register

"
Class {
	#name : #ERRegisterPage,
	#superclass : #ERPage,
	#instVars : [
		'currentTab',
		'tabs',
		'messageComponent',
		'basicInfoTab',
		'affiliationInfo',
		'doneTab'
	],
	#category : #'ESUGApp-View-Page'
}

{ #category : #accessing }
ERRegisterPage class >> content: aContent [
	| instance |
	instance := self new.
	instance content: aContent.
	instance initializeTabForms.
	^ instance
]

{ #category : #adding }
ERRegisterPage >> addBasicInfoTab [
	basicInfoTab := (self createBasicInfoTab: pageController attendee
							withContent: self) cancelCallback: self cancelRegister.
	^ self
		addTab: basicInfoTab .
]

{ #category : #adding }
ERRegisterPage >> addBillingInfoTab [
	affiliationInfo:= (self createBillingInfoTab: pageController attendee
								withContent: self) disabled: true; cancelCallback: self cancelRegister.
	^ self
		addTab: affiliationInfo .
]

{ #category : #adding }
ERRegisterPage >> addDoneTab [
	doneTab := (ERDoneButton
				on: self controller attendee
				button: [ :html | self renderDoneButtonOn: html ]
				container: self) 
	disabled: true.
	^ self
		addTab: doneTab .
]

{ #category : #adding }
ERRegisterPage >> addTab: aAttendeeTabForm [
	^ self tabs add: aAttendeeTabForm
]

{ #category : #actions }
ERRegisterPage >> cancelRegister [
	^ [self session logout.
    ^ self requestContext redirectTo: self application url]
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

{ #category : #actions }
ERRegisterPage >> redirectFinishRegister [
	self subclassResponsibility 
]

{ #category : #'tools registry' }
ERRegisterPage >> register [
	| user |
	user := pageController save.
	self validateRegister: user
]

{ #category : #rendering }
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
	html div style: self styleBackgound ;
	with: [ 
		html break. html break. html break. 
		aBlock value	
	]
]

{ #category : #rendering }
ERRegisterPage >> renderDoneButtonOn: html [
	
	html mdlButton
		beSubmit;
		raised;
		primaryColor;
		rippleEffect;
		id: 'registerButton';
		callback: [ [ self validateAndRegister ]
				on: ERException
				do: [ :exception | messageComponent errorMessage: exception messageText ] ];
		with: 'Save Information'
]

{ #category : #rendering }
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
		with: [ html mdlTabs rippleEffect with: 
			[ html render: (ERTabs tabs: self tabs) ] ]
]

{ #category : #saving }
ERRegisterPage >> saveAffilInfo [
	currentTab := affiliationInfo.
	pageController attendee affiliationInformation: 
	(affiliationInfo contentTab save) model
	
]

{ #category : #saving }
ERRegisterPage >> saveBasicInfo [
	currentTab := basicInfoTab.
	pageController attendee userAccount: 
	((basicInfoTab contentTab save) model as: ERUserAccount )
	
]

{ #category : #saving }
ERRegisterPage >> saveRegistration [
	self subclassResponsibility 
]

{ #category : #saving }
ERRegisterPage >> saveTabs [
	self subclassResponsibility 
]

{ #category : #accessing }
ERRegisterPage >> tabs [
	tabs ifNil: [ tabs:= OrderedCollection new].
	^ tabs.
]

{ #category : #validating }
ERRegisterPage >> validateAndRegister [
	 [self saveTabs.
		currentTab := tabs first. 
	pageController validateRegister.
	self saveRegistration.
	"pageController attendee: nil"
	"Add validator to when go back and press register not save this again"] 
	on: ERException 
	do: [ :exception | messageComponent errorMessage: exception messageText.
		currentTab updateStateTab: currentTab tabName.
		^ self ].
	self redirectFinishRegister
]

{ #category : #validating }
ERRegisterPage >> validateRegister: user [
	user notNil
		ifTrue: [ self answer: user ]
		ifFalse:
			[ messageComponent errorMessage: 'This email is already registered' ]
]
