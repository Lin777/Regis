Class {
	#name : #ERContactInformationForm,
	#superclass : #ERAttendeeRegistrationForm,
	#category : #'ESUGApp-Components'
}

{ #category : #initialization }
ERContactInformationForm >> initialize [
	super initialize.
]

{ #category : #rendering }
ERContactInformationForm >> renderFormOn: html [
	
	html render: (ERContactInformation on: attendee)
]

{ #category : #accessing }
ERContactInformationForm >> tabId [
	^ 'contactInfoForm'
]

{ #category : #accessing }
ERContactInformationForm >> tabName [
	^ 'Contact'
]
