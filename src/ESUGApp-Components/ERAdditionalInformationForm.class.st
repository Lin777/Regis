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
	html
		render: (self createTextField: 'Keywords ' for: #keywords:).
	html
		render:
			(self
				createTextAreaField: 'Additional text'
				for: #additionalText:).
	self renderPreviousTabFromOn: html.
	self renderNextTabFromOn: html
]

{ #category : #accessing }
ERAdditionalInformationForm >> tabId [
	^ 'additionalInfoForm'
]

{ #category : #accessing }
ERAdditionalInformationForm >> tabName [
	^ 'Additional'
]
