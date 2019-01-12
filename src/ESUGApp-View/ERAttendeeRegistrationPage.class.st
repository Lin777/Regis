Class {
	#name : #ERAttendeeRegistrationPage,
	#superclass : #ERRegisterPage,
	#instVars : [
		'currentTab'
	],
	#category : #'ESUGApp-View'
}

{ #category : #accessing }
ERAttendeeRegistrationPage >> currentTab: anObject [
	currentTab := anObject
]

{ #category : #initialization }
ERAttendeeRegistrationPage >> initialize [
	actionRegister := [ self register ].
	super initialize.
	currentTab := 1.
	title := 'Registration'
]

{ #category : #initialize }
ERAttendeeRegistrationPage >> initializeTabForms [
	self
		addTab:
			(ERTabForAForm
				form: (ERBasicInformationForm on: self controller attendee)).
	self
		addTab:
			(ERTabForAForm
				form: (ERContactInformationForm on: self controller attendee)
				).
	self
		addTab:
			(ERTabForAForm
				form: (ERRegisterConferenceForm on: self controller attendee)
				).
	self
		addTab:
			(ERTabForAForm
				form: (ERAffiliationInformationForm on: self controller attendee)
				).
	self
		addTab:
			(ERTabForAForm
				form: (ERAdditionalInformationForm on: self controller attendee)
				).
	self
		addTab:
			(ERTabForAForm
				form: (ERPaymentForm on: self controller attendee)
				).
	self
		addTab:
			(ERDoneButton
				on: self controller attendee
				button: [ :html | self renderDoneButtonOn: html ]).
	(self tabs at: currentTab) activate
]

{ #category : #initialize }
ERAttendeeRegistrationPage >> validateAndRegister [
	| finishRegisterView |
	pageController validateRegister.
	finishRegisterView := ERFinishRegisterAttendeePage
		on: pageController attendee
		withContent: content
		withController: pageController.
	content state: finishRegisterView
]
