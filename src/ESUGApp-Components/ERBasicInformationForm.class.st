Class {
	#name : #ERBasicInformationForm,
	#superclass : #ERAttendeeRegistrationForm,
	#category : #'ESUGApp-Components'
}

{ #category : #initialization }
ERBasicInformationForm >> initialize [
	super initialize.
	nextTabFrom := 'contactInfoForm'.
	previousTabFrom := 'login'
]

{ #category : #accessing }
ERBasicInformationForm >> renderFormOn: html [
	html
		render: (self createTextField: 'First Name' for: #firstName:).
	html
		render: (self createTextField: 'Last Name' for: #lastName:).
	html render: (self createTextField: 'Email' for: #email:).
	html
		render: (self createPasswordField: 'Password' for: #password:).
	html
		render:
			(self
				createPasswordField: 'Confirm Password'
				for: #confirmPassword:).
	self renderNextTabFromOn: html
]

{ #category : #accessing }
ERBasicInformationForm >> tabId [
	^ 'basicInfoForm'
]

{ #category : #accessing }
ERBasicInformationForm >> tabName [
	^ 'User'
]
