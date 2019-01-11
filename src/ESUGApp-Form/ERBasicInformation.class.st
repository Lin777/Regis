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
		createTextField: 'First Name'
		for: #firstName:
		with: #firstName
		on: html.
	self
		createTextField: 'Last Name'
		for: #lastName:
		with: #lastName
		on: html.
	self
		createTextField: 'Email'
		for: #email:
		with: #email
		on: html.
	self createPasswordField: 'Password' id: 'password' 
	with: [ :mdlTxtInput | 
		mdlTxtInput callback: [ :value | 
			self attendee perform: #password: with: (ERUserAccount hashPassword: value asString )].
		html mdlTextFieldError: 'Must contain: numbers, letters, ''.'' and/or ''_'', and at least 8 or more characters' ] on: html.
	self createPasswordField: 'Confirm Password' id: 'confirmPassword' with: [ :mdlTxtInput | 
		mdlTxtInput callback: [ :value | 
			self attendee perform: #confirmPassword: with: (ERUserAccount hashPassword: value asString )] ] on: html.
]
