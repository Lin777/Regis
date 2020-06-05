"
Description
--------------------

I am an Page of Register an Group Manager, I have all necessary fields to create an Group Manager
"
Class {
	#name : #ERGroupManagerRegistrationPage,
	#superclass : #ERRegisterPage,
	#category : #'ESUGApp-View-Page'
}

{ #category : #initialization }
ERGroupManagerRegistrationPage >> initialize [
	| group |
	super initialize.
	group := ERGroup new.
	pageController attendee: group.
	title := 'Group Registration'
]

{ #category : #initialization }
ERGroupManagerRegistrationPage >> initializeTabForms [
	self addBasicInfoTab 
		nextTabName: 'Affiliation';
		tabName: 'Group Manager'.
	self addContactInfoTab 
		tabName: 'Group Contact'.
	self addBillingInfoTab
		buttonsOfTab: [ :html | self renderDoneButtonOn: html ].
	currentTab := basicInfoTab.
	currentTab updateStateTab: currentTab tabName.
]

{ #category : #actions }
ERGroupManagerRegistrationPage >> redirectFinishRegister [
	| finishRegisterView |
	finishRegisterView := ERFinishRegisterGroupManagerPage
		on: pageController attendee
		withContent: content
		withController: pageController.
	content state: finishRegisterView
]

{ #category : #saving }
ERGroupManagerRegistrationPage >> saveAffilInfo [
	currentTab := affiliationInfo.
	pageController attendee affiliationInformation: (affiliationInfo contentTab save) model
]

{ #category : #saving }
ERGroupManagerRegistrationPage >> saveBasicInfo [
	
	currentTab := basicInfoTab.
	pageController attendee userAccount: ((basicInfoTab contentTab save) model as: ERUserAccount).
]

{ #category : #saving }
ERGroupManagerRegistrationPage >> saveContactInfo [
	currentTab := contactInfoTab.
	pageController attendee contactInformation: (contactInfoTab contentTab save) model
]

{ #category : #saving }
ERGroupManagerRegistrationPage >> saveRegistration [
	"Save method to Group Manager. Do not send email to group manager when register because this not have an invoice"
	
	| user |
	user := pageController saveGroupManager.
	pageController attendee userAccount: user.
	^ user
]

{ #category : #saving }
ERGroupManagerRegistrationPage >> saveTabs [

	self saveBasicInfo.
	self saveContactInfo.
	self saveAffilInfo.
]
