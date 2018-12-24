Class {
	#name : #ERGroupManagerRegistrationView,
	#superclass : #ERRegister,
	#category : #'ESUGApp-Views'
}

{ #category : #initialization }
ERGroupManagerRegistrationView >> initialize [
	actionRegister := [ self registerAsGroupManager ].
	super initialize.
	title := 'Group Manager'.
	
]

{ #category : #initialization }
ERGroupManagerRegistrationView >> initializeTabForms [
self addTab: (ERTabForAForm form: (ERBasicInformation on: self controller attendee)).
	self addTab: (ERTabForAForm form: (ERAffiliationInformation on: self controller attendee)).
	self
		addTab:
			(ERDoneForm on: self controller attendee callback: actionRegister).
	(self tabs at: 1) activate
]
