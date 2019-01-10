Class {
	#name : #ERGroupManagerRegistrationView,
	#superclass : #ERRegister,
	#category : #'ESUGApp-Views'
}

{ #category : #initialization }
ERGroupManagerRegistrationView >> initialize [
	super initialize.
	title := 'Group Manager'.
	actionRegister := [ self registerAsGroupManager ]
]

{ #category : #initialization }
ERGroupManagerRegistrationView >> initializeTabForms [
self addTab: (ERTabForAForm form: (ERBasicInformation on: self controller attendee)).
	self addTab: (ERTabForAForm form: (ERAffiliationInformation on: self controller attendee)).
	self
		addTab:
			(ERDoneForm on: self controller attendee button:  [ :html | "actionRegister" self renderDoneButtonOn: html ]).
	(self tabs at: 1) activate
]

{ #category : #initialize }
ERGroupManagerRegistrationView >> validateAndRegister [
	| finishRegisterView |
	pageController validateRegisterForGroupManager.
	finishRegisterView := ERFinishRegisterGroupManager
		on: pageController attendee
		withContent: content.
	content state: finishRegisterView
]
