Class {
	#name : #ERAttendeeRegistrationPage,
	#superclass : #ERRegisterPage,
	#instVars : [
		'currentTab',
		'basicInfoTab',
		'contactInfoTab',
		'regConfInfo',
		'addInfo',
		'affiliationInfo',
		'doneTab',
		'paymentInfoTab'
	],
	#category : #'ESUGApp-View-Page'
}

{ #category : #accessing }
ERAttendeeRegistrationPage class >> content: aContent [
	| instance |
	instance := self new.
	instance content: aContent.
	instance initializeTabForms.
	^ instance
]

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
ERAttendeeRegistrationPage >> addAffiliationInfoTab [
	affiliationInfo:= (ERContentTab new contentTab: self initializeAffiliationInformationComponent;
			 tabId: 'affiliationInfoForm'; 
			 tabName: 'Affiliation';
			 container: self).
	self
		addTab: affiliationInfo .
]

{ #category : #initialize }
ERAttendeeRegistrationPage >> addBasicInfoTab [
	basicInfoTab := (ERContentTab new contentTab: self initializeBasicInformationComponent;
			 tabId: 'basicInfoForm'; 
			 tabName: 'User';
			 container: self).
	self
		addTab: basicInfoTab .
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
ERAttendeeRegistrationPage >> addDoneTab [
	doneTab := (ERDoneButton
				on: self controller attendee
				button: [ :html | self renderDoneButtonOn: html ]
				container: self).
	self
		addTab: doneTab .
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

{ #category : #accessing }
ERAttendeeRegistrationPage >> currentTab: anObject [
	currentTab := anObject
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
ERAttendeeRegistrationPage >> initializeAffiliationInformationComponent [
	^ pageController attendee affiliationInformation asComponent 
	addDecoration: MAValidationDecoration new;
	 yourself
]

{ #category : #initialize }
ERAttendeeRegistrationPage >> initializeBasicInformationComponent [
	^ ((pageController attendee userAccount) 
	as: ERUserAccountForRegister) asComponent 
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
ERAttendeeRegistrationPage >> saveAddInfo [
	currentTab := addInfo.
	pageController attendee additionalInformation: 
	(addInfo contentTab save) model
	
]

{ #category : #initialize }
ERAttendeeRegistrationPage >> saveAffilInfo [
	currentTab := affiliationInfo.
	pageController attendee affiliationInformation: 
	(affiliationInfo contentTab save) model
	
]

{ #category : #initialize }
ERAttendeeRegistrationPage >> saveBasicInfo [
	currentTab := basicInfoTab.
	pageController attendee userAccount: 
	((basicInfoTab contentTab save) model as: ERUserAccount1 )
	
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

{ #category : #initialize }
ERAttendeeRegistrationPage >> validateAndRegister [
	| finishRegisterView |
	 [self saveTabs] 
	on: ERException 
	do: [ currentTab updateStateTab: currentTab tabName.
		^ self ]."
	pageController save."
	"pageController validateRegister."
	
	finishRegisterView := ERFinishRegisterAttendeePage
		on: pageController attendee
		withContent: content
		withController: pageController.
	content state: finishRegisterView
]
