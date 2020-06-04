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
		'doneTab',
		'paymentInfoTab',
		'contactInfoTab'
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
	"Create Basic information tab on all register pages"

	basicInfoTab := (self createBasicInfoTab: self controllerAttendee withContent: self)
							cancelCallback: self cancelRegister.
	^ self addTab: basicInfoTab
]

{ #category : #adding }
ERRegisterPage >> addBillingInfoTab [
	"Create billing information tab on all register pages"

	affiliationInfo := (self createBillingInfoTab: self controllerAttendee withContent: self) 
								disabled: true; 
								cancelCallback: self cancelRegister.
	^ self addTab: affiliationInfo.
]

{ #category : #adding }
ERRegisterPage >> addContactInfoTab [
	"Create Contact information tab on all register pages"
	
	contactInfoTab := (self createContactInfoTab: self controllerAttendee withContent: self) 
								disabled: true;
								cancelCallback: self cancelRegister.
	^ self addTab: contactInfoTab.
]

{ #category : #adding }
ERRegisterPage >> addPaymentInfoTab [
	"Add payment information tab in all register pages"

	paymentInfoTab := (self createPaymentInfoTab: self controllerAttendee withContent: self andConference: pageController conference) 
								disabled: true;
								cancelCallback: self cancelRegister.
	^ self addTab: paymentInfoTab.
]

{ #category : #adding }
ERRegisterPage >> addTab: aAttendeeTabForm [
	"Add a tab into a register page"
	
	^ self tabs add: aAttendeeTabForm
]

{ #category : #actions }
ERRegisterPage >> cancelRegister [
	^ [self session logout.
    ^ self requestContext redirectTo: self application url]
]

{ #category : #accessing }
ERRegisterPage >> controllerAttendee [

	^ pageController attendee
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
		aBlock value. ].
]

{ #category : #rendering }
ERRegisterPage >> renderDoneButtonOn: html [
	html mdlButton
		style: 'float:right';
		beSubmit;
		raised;
		primaryColor;
		rippleEffect;
		id: 'registerButton';
		class: 'btnNext';
		callback: [ [ self validateAndRegister ]
				on: ERException
				do: [ :exception | messageComponent errorMessage: exception messageText ] ];
		with: 'Finalize Registration'
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
	self subclassResponsibility.
]

{ #category : #saving }
ERRegisterPage >> saveBasicInfo [
	self subclassResponsibility.
	
]

{ #category : #saving }
ERRegisterPage >> saveRegistration [
	self subclassResponsibility 
]

{ #category : #saving }
ERRegisterPage >> saveTabs [
	self subclassResponsibility 
]

{ #category : #actions }
ERRegisterPage >> sendEmailTo: user [
	pageController sendInvoiceTo: (pageController conference attendeeFromUser: user)
]

{ #category : #accessing }
ERRegisterPage >> tabs [
	tabs ifNil: [ tabs:= OrderedCollection new].
	^ tabs.
]

{ #category : #validating }
ERRegisterPage >> validateAndRegister [
	[ self saveTabs.
		currentTab := tabs first.
		pageController validateRegister.
		self saveRegistration. ] 
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
