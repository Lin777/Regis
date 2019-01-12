Class {
	#name : #ERGroupManagerRegistrationPage,
	#superclass : #ERRegisterPage,
	#category : #'ESUGApp-View'
}

{ #category : #initialization }
ERGroupManagerRegistrationPage >> initialize [
	super initialize.
	title := 'Group Manager'.
	actionRegister := [ self registerAsGroupManager ]
]

{ #category : #initialization }
ERGroupManagerRegistrationPage >> initializeTabForms [
self addTab: (ERTabForAForm form: (ERBasicInformationForm on: self controller attendee)).
	self addTab: (ERTabForAForm form: (ERAffiliationInformationForm on: self controller attendee)).
	self
		addTab:
			(ERDoneButton on: self controller attendee button:  [ :html | self renderDoneButtonOn: html ]).
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
