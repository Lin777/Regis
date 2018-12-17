Class {
	#name : #ERBasicInformationTabForm,
	#superclass : #ERAttendeeRegistrationTabForm,
	#category : #'ESUGApp-Components'
}

{ #category : #accessing }
ERBasicInformationTabForm >> renderFormOn: html [
	html render: (self createTextField: 'First Name' for: #firstName:).
	html render: (self createTextField: 'Last Name' for: #lastName:).
	html render: (self createTextField: 'Email' for: #email:).
	html render: (self createPasswordField: 'Password' for: #password:).
	html render: (self createPasswordField: 'Confirm Password' for: #confirmPassword:)
]

{ #category : #accessing }
ERBasicInformationTabForm >> tabId [
	^ 'basicInfoForm'
]

{ #category : #accessing }
ERBasicInformationTabForm >> tabName [
	^ 'Registration'
]
