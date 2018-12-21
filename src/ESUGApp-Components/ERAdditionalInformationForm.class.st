Class {
	#name : #ERAdditionalInformationForm,
	#superclass : #ERAttendeeRegistrationForm,
	#category : #'ESUGApp-Components'
}

{ #category : #initialization }
ERAdditionalInformationForm >> initialize [
	super initialize.
]

{ #category : #rendering }
ERAdditionalInformationForm >> renderFormOn: html [
	
	html render: (ERAdditionalInformation on: attendee)
]

{ #category : #accessing }
ERAdditionalInformationForm >> tabId [
	^ 'additionalInfoForm'
]

{ #category : #accessing }
ERAdditionalInformationForm >> tabName [
	^ 'Additional'
]
