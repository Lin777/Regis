Class {
	#name : #ERAdditionalInformationTabForm,
	#superclass : #ERAttendeeRegistrationTabForm,
	#category : #'ESUGApp-Components'
}

{ #category : #rendering }
ERAdditionalInformationTabForm >> renderFormOn: html [
	html render: (self createTextField: 'Keywords ' for: #keywords:).
	html render: (self createTextAreaField: 'Additional text' for: #additionalText:)
]

{ #category : #accessing }
ERAdditionalInformationTabForm >> tabId [
	^ 'additionalInfoForm'
]

{ #category : #accessing }
ERAdditionalInformationTabForm >> tabName [
	^ 'Additional Information'
]
