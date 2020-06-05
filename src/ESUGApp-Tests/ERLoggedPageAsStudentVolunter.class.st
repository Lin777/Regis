"
Description
--------------------

A ERLoggedPageAsStudentVolunter is a test class for testing the behavior of page when the user sign in as StudentVolunter
"
Class {
	#name : #ERLoggedPageAsStudentVolunter,
	#superclass : #ERParasolTest,
	#instVars : [
		'studentVolunter'
	],
	#category : #'ESUGApp-Tests-Parasol'
}

{ #category : #actions }
ERLoggedPageAsStudentVolunter >> loginAsStudentVolunter [
	self selectElementWithID: 'email-login' send: studentVolunter userAccount email.
	self selectElementWithID: 'password-login' send: '12345678'.
	self clickElementWithID: 'login-button'
]

{ #category : #actions }
ERLoggedPageAsStudentVolunter >> pressOptionSearch [
	self clickElementWithID: 'Search-option'
]

{ #category : #running }
ERLoggedPageAsStudentVolunter >> setUp [
	super setUp.
	ERTest generateDataForTest.
	studentVolunter := controller conference attends first.
	controller := ERAttendeeController new.
	controller convertToStudentVolunterThis: studentVolunter .
	self loginAsStudentVolunter
	
]

{ #category : #tests }
ERLoggedPageAsStudentVolunter >> testPressSearchOption [
	self pressOptionSearch .
	self assert: (self textOfTagName: 'h3') equals: 'Attendees'.
	self shouldnt: [ driver findElementByID: 'selectStrategy' ] raise: BPNoSuchElementException .
	self shouldnt: [driver findElementByID: 'stringForStrategy'] raise: BPNoSuchElementException .
]
