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
	super initialize.
	pageController attendee: ERGroupManager new.
	title := 'Group Manager'
]

{ #category : #initialization }
ERGroupManagerRegistrationPage >> initializeTabForms [
	self addBasicInfoTab nextTabName: 'Affiliation'.
	self addBillingInfoTab previousTabName: 'User'; nextTabName: 'Done'.
	self addDoneTab.
	
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
ERGroupManagerRegistrationPage >> saveRegistration [
	| user |
	user := pageController saveGroupManager.
	pageController attendee userAccount: user.
	^ user
]

{ #category : #saving }
ERGroupManagerRegistrationPage >> saveTabs [
	self saveBasicInfo.
	self saveAffilInfo.
]
