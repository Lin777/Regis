"
A ERLoggedPageAsStudentVolunter is a test class for testing the behavior of page when the user sign in as StudentVolunter
"
Class {
	#name : #ERLoggedPageAsStudentVolunter,
	#superclass : #ERParasolTest,
	#instVars : [
		'studentVolunter'
	],
	#category : #'ESUGApp-Test-Parasol'
}

{ #category : #accessing }
ERLoggedPageAsStudentVolunter >> loginAsStudentVolunter [
	self selectElementWithID: 'email-login' send: studentVolunter userAccount email.
	self selectElementWithID: 'password-login' send: '12345678'.
	self clickElementWithID: 'login-button'
]

{ #category : #tests }
ERLoggedPageAsStudentVolunter >> pressOptionAdmin [
	self clickElementWithID: 'Search-option'
]

{ #category : #accessing }
ERLoggedPageAsStudentVolunter >> setUp [
	super setUp.
	ERTest generateDataForTest.
	studentVolunter := controller conference attends first.
	controller := ERConfigurationController new.
	controller convertToStudentVolunterThis: studentVolunter .
	self loginAsStudentVolunter
	
]

{ #category : #tests }
ERLoggedPageAsStudentVolunter >> testPressAdminOption [
	self pressOptionAdmin .
	self assert: ( driver findElementByTagName: 'h3') getText equals: 'Attendees'.
	self shouldnt: [driver findElementByID: 'selectStrategy'] raise: BPNoSuchElementException .
	self shouldnt: [driver findElementByID: 'stringForStrategy'] raise: BPNoSuchElementException .
]
