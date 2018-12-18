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
	self addTab: (ERBasicInformationForm on: self controller attendee).
	self addTab: (ERContactInformationForm on: self controller attendee).
	self addTab: (ERConferenceOptionsForm on: self controller attendee).
	self addTab: (ERAffiliationInformationForm on: self controller attendee).
	self addTab: (ERAdditionalInformationForm on: self controller attendee).
	self addTab: (ERPaymentInformationForm on: self controller attendee).
	self addTab: (ERDoneForm on: self controller attendee callback: [ self register ]).
	(self tabs at: 1) activate
]
