Class {
	#name : #ERAttendeeRegistrationPage,
	#superclass : #ERRegisterPage,
	#instVars : [
		'contactInfoTab',
		'regConfInfo',
		'addInfo',
		'paymentInfoTab'
	],
	#category : #'ESUGApp-View-Page'
}

{ #category : #initialize }
ERAttendeeRegistrationPage >> addAdditionalInfoTab [
	addInfo := (self createAdditionalInfoTab: pageController attendee
						withContent: self) disabled: true.
	self
		addTab: addInfo.
]

{ #category : #initialize }
ERAttendeeRegistrationPage >> addContactInfoTab [
	contactInfoTab := (self createContactInfoTab: pageController attendee 
								withContent: self ) disabled: true.
	self
		addTab: contactInfoTab.
]

{ #category : #initialize }
ERAttendeeRegistrationPage >> addPaymentInfoTab [
	paymentInfoTab := (self createPaymentInfoTab: pageController attendee
								 withContent: self ) disabled: true.
	self
		addTab: paymentInfoTab.
]

{ #category : #initialize }
ERAttendeeRegistrationPage >> addRegisterConferenceInfoTab [
	regConfInfo := (self createRegConferenceInfoTab: pageController attendee
							 withContent: self )disabled: true.
	self
		addTab: regConfInfo .
]

{ #category : #initialization }
ERAttendeeRegistrationPage >> initialize [
	super initialize.
	title := 'Registration'
]

{ #category : #initialize }
ERAttendeeRegistrationPage >> initializeTabForms [
	self addBasicInfoTab.
	self addContactInfoTab.
	self addRegisterConferenceInfoTab.
	self addAffiliationInfoTab.
	self addAdditionalInfoTab.
	self addPaymentInfoTab.
	self addDoneTab.
	
	currentTab := basicInfoTab.
	currentTab updateStateTab: currentTab tabName.
]

{ #category : #initialize }
ERAttendeeRegistrationPage >> redirectFinishRegister [
	| finishRegisterView |
	finishRegisterView := ERFinishRegisterAttendeePage
		on: pageController attendee
		withContent: content
		withController: pageController.
	content state: finishRegisterView
]

{ #category : #initialize }
ERAttendeeRegistrationPage >> saveAddInfo [
	currentTab := addInfo.
	pageController attendee additionalInformation: 
	(addInfo contentTab save) model
	
]

{ #category : #initialize }
ERAttendeeRegistrationPage >> saveContactInfo [
	currentTab := contactInfoTab.
	pageController attendee contactInformation: 
	(contactInfoTab contentTab save) model
	
]

{ #category : #initialize }
ERAttendeeRegistrationPage >> savePaymentInfo [
	currentTab := paymentInfoTab.
	pageController attendee paymentInformation: 
	(paymentInfoTab contentTab save) model.
	pageController updatePaymentRate: pageController attendee.
	
]

{ #category : #initialize }
ERAttendeeRegistrationPage >> saveRegConfInfo [
	currentTab := regConfInfo.
	pageController attendee conferenceInformation:  
	(regConfInfo contentTab save) model
	
]

{ #category : #initialize }
ERAttendeeRegistrationPage >> saveTabs [
	self saveBasicInfo.
	self saveContactInfo.
	self saveRegConfInfo.
	self saveAffilInfo.
	self saveAddInfo.
	self savePaymentInfo.
]
