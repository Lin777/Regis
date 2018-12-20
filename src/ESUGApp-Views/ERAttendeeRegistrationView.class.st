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
		addTab: (ERBasicInformationForm on: self controller attendee).
	self
		addTab: (ERContactInformationForm on: self controller attendee).
	self
		addTab: (ERConferenceOptionsForm on: self controller attendee).
	self
		addTab: (ERAffiliationInformationForm on: self controller attendee).
	self
		addTab: (ERAdditionalInformationForm on: self controller attendee).
	self
		addTab: (ERPaymentInformationForm on: self controller attendee).
	self
		addTab:
			(ERDoneForm
				on: self controller attendee
				callback: actionRegister).
	(self tabs at: 1) activate
]
