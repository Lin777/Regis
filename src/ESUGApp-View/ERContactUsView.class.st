"
Description
-----------

I am the view to contact us when you have problems
"
Class {
	#name : #ERContactUsView,
	#superclass : #ERTittledView,
	#category : #'ESUGApp-View-View'
}

{ #category : #'as yet unclassified' }
ERContactUsView class >> withContent: aContent withController: aController [
	| form |
	form := self new.
	form content: aContent.
	form controller: aController.
	^ form
]

{ #category : #rendering }
ERContactUsView >> emailToContactUs [
	^ controller conference configuration emailConfiguration emailHelp
]

{ #category : #rendering }
ERContactUsView >> renderPageOn: html [

	html div
		with: [ 
			html heading 
				level: 4;
				with: 'You have a problem with your registration?'.
			html heading
				level: 5;
				with: 'Send an email to: ', self emailToContactUs, '. We try to solved your problems.'.
			html span
				style: 'display: flex; justify-content: flex-end;';
				with: 'ESUG version 2.0' ]
]

{ #category : #accessing }
ERContactUsView >> title [

	^ 'Contact Us'
]
