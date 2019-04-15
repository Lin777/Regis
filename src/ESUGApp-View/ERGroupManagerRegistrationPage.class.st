Class {
	#name : #ERGroupManagerRegistrationPage,
	#superclass : #ERRegisterPage,
	#category : #'ESUGApp-View-Page'
}

{ #category : #initialization }
ERGroupManagerRegistrationPage >> initialize [
	super initialize.
	pageController attendee: ERGroupManager new.
	title := 'Group Manager'
]

{ #category : #initialization }
ERGroupManagerRegistrationPage >> initializeTabForms [
	self addBasicInfoTab nextTabName: 'Affiliation'.
	self addAffiliationInfoTab previousTabName: 'User'; nextTabName: 'Done'.
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
ERGroupManagerRegistrationPage >> saveRegistration [
	| user |
	user := pageController saveGroupManager.
	pageController attendee userAccount: user.
	^ user
]

{ #category : #initialize }
ERGroupManagerRegistrationPage >> saveTabs [
	self saveBasicInfo.
	self saveAffilInfo.
]
