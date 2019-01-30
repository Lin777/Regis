Class {
	#name : #ERGroupManagerRegistrationPage,
	#superclass : #ERRegisterPage,
	#category : #'ESUGApp-View-Page'
}

{ #category : #initialization }
ERGroupManagerRegistrationPage >> initialize [
	super initialize.
	pageController attendee: ERGroupManager new.
	title := 'Group Manager'.
	actionRegister := [ self registerAsGroupManager ]
]

{ #category : #initialization }
ERGroupManagerRegistrationPage >> initializeTabForms [
	self addBasicInfoTab.
	self addAffiliationInfoTab.
	self addDoneTab.
	
	currentTab := basicInfoTab.
	currentTab updateStateTab: currentTab tabName.
]

{ #category : #initialize }
ERGroupManagerRegistrationPage >> redirectFinishRegister [
	| finishRegisterView |
	finishRegisterView := ERFinishRegisterGroupManagerPage
		on: pageController attendee
		withContent: content
		withController: pageController.
	content state: finishRegisterView
]

{ #category : #initialize }
ERGroupManagerRegistrationPage >> saveTabs [
	self saveBasicInfo.
	self saveAffilInfo.
]
