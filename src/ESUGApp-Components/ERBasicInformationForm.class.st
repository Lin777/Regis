Class {
	#name : #ERBasicInformationForm,
	#superclass : #ERAttendeeRegistrationForm,
	#category : #'ESUGApp-Components'
}

{ #category : #initialization }
ERBasicInformationForm >> initialize [
	super initialize.
]

{ #category : #accessing }
ERBasicInformationForm >> renderFormOn: html [
	html render: (ERBasicInformation on: attendee)
]

{ #category : #accessing }
ERBasicInformationForm >> tabId [
	^ 'basicInfoForm'
]

{ #category : #accessing }
ERBasicInformationForm >> tabName [
	^ 'User'
]
