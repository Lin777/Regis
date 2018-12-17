Class {
	#name : #ERAttendeeRegistrationView,
	#superclass : #ERRegister,
	#category : #'ESUGApp-Views'
}

{ #category : #'options-generated' }
ERAttendeeRegistrationView class >> canBeRoot [ 
    ^ true
]

{ #category : #'options-generated' }
ERAttendeeRegistrationView class >> initialize [
	"self initialize"

	(WAAdmin register: self asApplicationAt: 'Reg')
		addLibrary: JQDeploymentLibrary;
		addLibrary: MDLLibrary;
		addLibrary: ERMaterialBlueRedMinCss ;
		addLibrary: CssForRegisterFormsMDL;
		addLibrary: ERJQValidateForm ;
		addLibrary: ERLibrary ;
		preferenceAt: #sessionClass put: ERSession
]

{ #category : #initialization }
ERAttendeeRegistrationView >> initialize [
	super initialize.
	title := 'Registration'.
]

{ #category : #initialize }
ERAttendeeRegistrationView >> initializeTabForms [
	self
		addTab: (ERBasicInformationTabForm on: self controller attendee).
	self
		addTab: (ERContactInformationTabForm on: self controller attendee).
	self
		addTab: (ERConferenceOptionsTabForm on: self controller attendee).
	self
		addTab: (ERAffiliationInformationTabForm on: self controller attendee).
	self
		addTab: (ERAdditionalInformationTabForm on: self controller attendee).
	self
		addTab: (ERPaymentInformationTabForm on: self controller attendee).
	self
		addTab:
			(ERDoneTabForm
				on: self controller attendee
				callback: [ self register ]).
	(self tabs at: 1) activate
]
