Class {
	#name : #ERAttendeeRegistrationView,
	#superclass : #ERRegister,
	#category : #'ESUGApp-Views'
}

{ #category : #'as yet unclassified' }
ERAttendeeRegistrationView class >> using: aPageController withAction: aBlock [
	| instance |
	instance := self new.
	instance controller: aPageController.
	instance actionRegister: aBlock.
	^ instance
]

{ #category : #'as yet unclassified' }
ERAttendeeRegistrationView class >> withAction: aBlock [
	| instance |
	instance := self new.
	instance actionRegister: aBlock.
	instance initializeTabForms.
	^ instance
]

{ #category : #initialization }
ERAttendeeRegistrationView >> initialize [
	actionRegister := [ self register ].
	super initialize.
	title := 'Registration'.
]

{ #category : #initialize }
ERAttendeeRegistrationView >> initializeTabForms [
	self
		addTab:
			(ERTabForAForm
				form: (ERBasicInformation on: self controller attendee)).
	self
		addTab:
			(ERTabForAForm
				form: (ERContactInformation on: self controller attendee)).
	self
		addTab:
			(ERTabForAForm
				form: (ERConferenceOptions on: self controller attendee)).
	self
		addTab:
			(ERTabForAForm
				form: (ERAffiliationInformation on: self controller attendee)).
	self
		addTab:
			(ERTabForAForm
				form: (ERAdditionalInformation on: self controller attendee)).
	self
		addTab:
			(ERTabForAForm
				form: (ERPaymentInformation on: self controller attendee)).
	self
		addTab:
			(ERDoneForm
				on: self controller attendee
				button: [ :html | "actionRegister" self renderDoneButtonOn: html ]).
	(self tabs at: 1) activate
]

{ #category : #initialize }
ERAttendeeRegistrationView >> validateAndRegister [
	| finishRegisterView |
	pageController validateRegister.
	finishRegisterView := ERFinishRegisterAttend
		on: pageController attendee
		withContent: content
		withController: pageController .
	content state: finishRegisterView
]
