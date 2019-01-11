Class {
	#name : #ERBasicInformation,
	#superclass : #ERForm,
	#category : #'ESUGApp-Form'
}

{ #category : #'as yet unclassified' }
ERBasicInformation >> formId [
	^ 'basicInfoForm'
]

{ #category : #'as yet unclassified' }
ERBasicInformation >> formName [
	^ 'User'
]

{ #category : #rendering }
ERBasicInformation >> renderContentOn: html [
	self
		createTextField: 'First Name (*):'
		for: #firstName:
		with: #firstName
		on: html.
	self
		createTextField: 'Last Name (*):'
		for: #lastName:
		with: #lastName
		on: html.
	self
		createTextField: 'Email (*):'
		for: #email:
		with: #email
		on: html.
	self createPasswordField: 'Password (*):' for: #password: on: html.
	self
		createPasswordField: 'Confirm Password (*):'
		for: #confirmPassword:
		on: html
]
