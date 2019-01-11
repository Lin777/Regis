Class {
	#name : #ERAttendeeRegistrationView,
	#superclass : #ERRegister,
	#instVars : [
		'currentTab'
	],
	#category : #'ESUGApp-Views'
}

{ #category : #accessing }
ERAttendeeRegistrationView >> currentTab: anObject [
	currentTab := anObject
]

{ #category : #initialization }
ERAttendeeRegistrationView >> initialize [
	actionRegister := [ self register ].
	super initialize.
	currentTab := 1.
	title := 'Registration'
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
				form: (ERContactInformation on: self controller attendee)
				).
	self
		addTab:
			(ERTabForAForm
				form: (ERConferenceOptions on: self controller attendee)
				).
	self
		addTab:
			(ERTabForAForm
				form: (ERAffiliationInformation on: self controller attendee)
				).
	self
		addTab:
			(ERTabForAForm
				form: (ERAdditionalInformation on: self controller attendee)
				).
	self
		addTab:
			(ERTabForAForm
				form: (ERPaymentInformation on: self controller attendee)
				).
	self
		addTab:
			(ERDoneForm
				on: self controller attendee
				button: [ :html | self renderDoneButtonOn: html ]).
	(self tabs at: currentTab) activate
]

{ #category : #initialize }
ERAttendeeRegistrationView >> validateAndRegister [
	| finishRegisterView |
	pageController validateRegister.
	finishRegisterView := ERFinishRegisterAttend
		on: pageController attendee
		withContent: content
		withController: pageController.
	content state: finishRegisterView
]
