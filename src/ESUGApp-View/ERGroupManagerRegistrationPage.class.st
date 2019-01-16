Class {
	#name : #ERGroupManagerRegistrationPage,
	#superclass : #ERRegisterPage,
	#category : #'ESUGApp-View-Page'
}

{ #category : #initialization }
ERGroupManagerRegistrationPage >> initialize [
	super initialize.
	title := 'Group Manager'.
	actionRegister := [ self registerAsGroupManager ]
]

{ #category : #initialization }
ERGroupManagerRegistrationPage >> initializeTabForms [
self addTab: (ERTabForAForm form: (ERBasicInformationForm on: self controller attendee) withContainer: self).
	self addTab: (ERTabForAForm form: (ERAffiliationInformationForm on: self controller attendee) withContainer: self).
	self
		addTab:
			(ERDoneButton on: self controller attendee 
			button:  [ :html | self renderDoneButtonOn: html ]
			container: self).
	(self tabs at: 1) activate
]

{ #category : #initialize }
ERGroupManagerRegistrationPage >> validateAndRegister [
	| finishRegisterView |
	pageController validateRegisterForGroupManager.
	finishRegisterView := ERFinishRegisterGroupManagerPage
		on: pageController attendee
		withContent: content
		withController: pageController.
	content state: finishRegisterView
]
