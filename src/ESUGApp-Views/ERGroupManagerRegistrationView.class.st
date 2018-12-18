Class {
	#name : #ERGroupManagerRegistrationView,
	#superclass : #ERRegister,
	#category : #'ESUGApp-Views'
}

{ #category : #initialization }
ERGroupManagerRegistrationView >> initialize [
	super initialize.
	title := 'Group Manager'.
]

{ #category : #initialization }
ERGroupManagerRegistrationView >> initializeTabForms [
	self
		addTab: ((ERBasicInformationForm on: self controller attendee) nextTabFrom: 'affiliationInfoForm' ).
	self
		addTab: ((ERAffiliationInformationForm on: self controller attendee)nextTabFrom: 'doneInfoForm'; previousTabFrom: 'basicInfoForm').
	self
		addTab:
			((ERDoneForm
				on: self controller attendee
				callback: [ self registerAsGroupManager ])previousTabFrom: 'affiliationInfoForm').
	(self tabs at: 1) activate
]
