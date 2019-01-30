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
	addInfo := (ERContentTab new contentTab: self initializeAdditionalInformationComponent;
			 tabId: 'additionalInfoForm'; 
			 tabName: 'Additional';
			 container: self).
	self
		addTab: addInfo.
]

{ #category : #initialize }
ERAttendeeRegistrationPage >> addContactInfoTab [
	contactInfoTab := (ERContentTab new contentTab: self initializeContactInformationComponent;
			 tabId: 'contactInfoForm'; 
			 tabName: 'Contact';
			 container: self).
	self
		addTab: contactInfoTab.
]

{ #category : #initialize }
ERAttendeeRegistrationPage >> addPaymentInfoTab [
	paymentInfoTab := (ERContentTab new contentTab: self initializePaymentInformationComponent;
			 tabId: 'paymentInfoForm'; 
			 tabName: 'Payment';
			 container: self).
	self
		addTab: paymentInfoTab.
]

{ #category : #initialize }
ERAttendeeRegistrationPage >> addRegisterConferenceInfoTab [
	regConfInfo := (ERContentTab new contentTab: self initializeRegConferenceInformationComponent;
			 tabId: 'conferenceOptionsForm'; 
			 tabName: 'Conference';
			 container: self).
	self
		addTab: regConfInfo .
]

{ #category : #initialization }
ERAttendeeRegistrationPage >> initialize [
	actionRegister := [ self register ].
	super initialize.
	title := 'Registration'
]

{ #category : #initialize }
ERAttendeeRegistrationPage >> initializeAdditionalInformationComponent [
	
	^ pageController attendee additionalInformation asComponent
	addDecoration: MAValidationDecoration new;
	 yourself
]

{ #category : #initialize }
ERAttendeeRegistrationPage >> initializeContactInformationComponent [
	^ pageController attendee contactInformation asComponent 
	addDecoration: MAValidationDecoration new;
	 yourself
]

{ #category : #initialize }
ERAttendeeRegistrationPage >> initializePaymentInformationComponent [
	^ pageController attendee paymentInformation asComponent 
	addDecoration: MAValidationDecoration new;
	 yourself
]

{ #category : #initialize }
ERAttendeeRegistrationPage >> initializeRegConferenceInformationComponent [
	^ pageController attendee conferenceInformation asComponent 
	addDecoration: MAValidationDecoration new;
	 yourself 
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
	(paymentInfoTab contentTab save) model
	
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
