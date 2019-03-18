Class {
	#name : #ERRegisterAsAttendeePageTest,
	#superclass : #ERParasolTest,
	#category : #'ESUGApp-Test-Parasol'
}

{ #category : #tests }
ERRegisterAsAttendeePageTest >> firstName: aString1 lastName: aString2 email: aString3 password: aString4 confirmPassword: aString5 [
	|firstName lastName email password confirmPassword|
	firstName := driver findElementByID: 'firstName'.
	lastName := driver findElementByID: 'lastName'.
	email := driver findElementByID: 'email'.
	password := driver findElementByID: 'password'.
	confirmPassword := driver findElementByID: 'confirmPassword'.
	firstName sendKeys: aString1 .
	lastName sendKeys: aString2.
	email sendKeys: aString3.
	password sendKeys: aString4.
	confirmPassword sendKeys: aString5.
]

{ #category : #'as yet unclassified' }
ERRegisterAsAttendeePageTest >> pushRegisterButton [
	|register|
	register := driver findElementByID: 'register-button'.
	register click.
	self assert: (driver findElementByID: 'card-heading') getText = 'Registration'
]

{ #category : #'as yet unclassified' }
ERRegisterAsAttendeePageTest >> setUp [
	super setUp.
	self pushRegisterButton 
]

{ #category : #tests }
ERRegisterAsAttendeePageTest >> testPressFirstNextButtonWithoutConfirmPasswordField [
	|next|
	self firstName: 'register' lastName: 'register' email: 'register@gmail.com' password: '12345678' confirmPassword: '12345678'.
	(driver findElementByID: 'confirmPassword') clear.
	next := driver findElementByID: 'basicInfoForm-nextButton'.
	next click.
	self shouldnt: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	
]

{ #category : #tests }
ERRegisterAsAttendeePageTest >> testPressFirstNextButtonWithoutEmailField [
	|next|
	self firstName: 'register' lastName: 'register' email: 'register@gmail.com' password: '12345678' confirmPassword: '12345678'.
	(driver findElementByID: 'email') clear.
	next := driver findElementByID: 'basicInfoForm-nextButton'.
	next click.
	self shouldnt: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	
]

{ #category : #tests }
ERRegisterAsAttendeePageTest >> testPressFirstNextButtonWithoutFillingAnyField [
	|next|
	next := driver findElementByID: 'basicInfoForm-nextButton'.
	next click.
	self shouldnt: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	
]

{ #category : #tests }
ERRegisterAsAttendeePageTest >> testPressFirstNextButtonWithoutFirstNameField [
	|next|
	self firstName: 'register' lastName: 'register' email: 'register@gmail.com' password: '12345678' confirmPassword: '12345678'.
	(driver findElementByID: 'firstName') clear.
	next := driver findElementByID: 'basicInfoForm-nextButton'.
	next click.
	self shouldnt: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	
]

{ #category : #tests }
ERRegisterAsAttendeePageTest >> testPressFirstNextButtonWithoutLastNameField [
	|next|
	self firstName: 'register' lastName: 'register' email: 'register@gmail.com' password: '12345678' confirmPassword: '12345678'.
	(driver findElementByID: 'lastName') clear.
	next := driver findElementByID: 'basicInfoForm-nextButton'.
	next click.
	self shouldnt: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	
]

{ #category : #tests }
ERRegisterAsAttendeePageTest >> testPressUserNextButtonWithoutFillingAnyField [
	|next|
	next := driver findElementByID: 'basicInfoForm-nextButton'.
	next click.
	self shouldnt: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	"
	errors := driver findElementByClassName: 'errors'.
	errors:=errors findElementByTagName: 'ul'.
	self halt.
	errors findElementsByTagName: 'li'"
]
