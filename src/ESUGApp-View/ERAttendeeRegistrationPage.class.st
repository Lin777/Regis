"
Description
--------------------

I am an Page of Register ERAttendee, I have all necessary fields to create an Attendee
"
Class {
	#name : #ERAttendeeRegistrationPage,
	#superclass : #ERRegisterPage,
	#instVars : [
		'regConfInfo',
		'addInfo',
		'isOnDevelopmentMode'
	],
	#category : #'ESUGApp-View-Page'
}

{ #category : #actions }
ERAttendeeRegistrationPage >> addAdditionalInfoTab [

	addInfo := (self createAdditionalInfoTab: self controllerAttendee withContent: self) 
						disabled: true;
						cancelCallback: self cancelRegister.
	^ self addTab: addInfo.
]

{ #category : #actions }
ERAttendeeRegistrationPage >> addRegisterConferenceInfoTab [
	"Add conference tab to attendee registration page"

	regConfInfo := (self createRegConferenceInfoTab: self controllerAttendee withContent: self)
							disabled: true;
							cancelCallback: self cancelRegister.
	^ self addTab: regConfInfo .
]

{ #category : #initialization }
ERAttendeeRegistrationPage >> initialize [
	super initialize.
	title := 'Registration'.
	isOnDevelopmentMode := false.
]

{ #category : #initialization }
ERAttendeeRegistrationPage >> initializeTabForms [
	self addBasicInfoTab.
	self addContactInfoTab.
	self addRegisterConferenceInfoTab.
	self addBillingInfoTab.
	self addAdditionalInfoTab.
	self addPaymentInfoTab buttonsOfTab: [ :html | self renderDoneButtonOn: html ].
	
	currentTab := basicInfoTab.
	currentTab updateStateTab: currentTab tabName.
]

{ #category : #actions }
ERAttendeeRegistrationPage >> redirectFinishRegister [
	| finishRegisterView |
	finishRegisterView := ERFinishRegisterAttendeePage
		on: pageController attendee
		withContent: content
		withController: pageController.
	content state: finishRegisterView
]

{ #category : #saving }
ERAttendeeRegistrationPage >> saveAddInfo [
	currentTab := addInfo.
	pageController attendee additionalInformation: 
	(addInfo contentTab save) model
	
]

{ #category : #saving }
ERAttendeeRegistrationPage >> saveAffilInfo [
	currentTab := affiliationInfo.
	pageController attendee affiliationInformation: 
	(affiliationInfo contentTab save) model
]

{ #category : #saving }
ERAttendeeRegistrationPage >> saveBasicInfo [

	currentTab := basicInfoTab.
	pageController attendee userAccount: 
	((basicInfoTab contentTab save) model as: ERUserAccount )
]

{ #category : #saving }
ERAttendeeRegistrationPage >> saveContactInfo [
	currentTab := contactInfoTab.
	pageController attendee contactInformation: 
	(contactInfoTab contentTab save) model
	
]

{ #category : #saving }
ERAttendeeRegistrationPage >> savePaymentInfo [
	currentTab := paymentInfoTab.
	pageController attendee paymentInformation: 
	(paymentInfoTab contentTab save) model.
	pageController updatePaymentRate: pageController attendee.
	
]

{ #category : #saving }
ERAttendeeRegistrationPage >> saveRegConfInfo [
	currentTab := regConfInfo.
	pageController attendee conferenceInformation:  
	(regConfInfo contentTab save) model
	
]

{ #category : #saving }
ERAttendeeRegistrationPage >> saveRegistration [
	"Save method to Attendees. Change the isOnDevelopmentMode instance variable if you want to test the application"
	
	| user |
	user := pageController saveAttendee.
	pageController attendee userAccount: user.
	isOnDevelopmentMode
		ifFalse: [ self sendEmailTo: user ].
	^ user
]

{ #category : #saving }
ERAttendeeRegistrationPage >> saveTabs [
	self saveBasicInfo.
	self saveContactInfo.
	self saveRegConfInfo.
	self saveAffilInfo.
	self saveAddInfo.
	self savePaymentInfo.
]
