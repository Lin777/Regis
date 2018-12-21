Class {
	#name : #ERAffiliationInformationForm,
	#superclass : #ERAttendeeRegistrationForm,
	#category : #'ESUGApp-Components'
}

{ #category : #initialization }
ERAffiliationInformationForm >> initialize [
	super initialize.
]

{ #category : #rendering }
ERAffiliationInformationForm >> renderFormOn: html [
		html render: (ERAffiliationInformation on: attendee)
]

{ #category : #accessing }
ERAffiliationInformationForm >> tabId [
	^ 'affiliationInfoForm'
]

{ #category : #accessing }
ERAffiliationInformationForm >> tabName [
	^ 'Affiliation'
]
