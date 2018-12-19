Class {
	#name : #ERDoneForm,
	#superclass : #ERAttendeeRegistrationForm,
	#instVars : [
		'callback'
	],
	#category : #'ESUGApp-Components'
}

{ #category : #callbacks }
ERDoneForm class >> callback: aBlock [
	| instance |
	instance := self new.
	instance callback: aBlock.
	^ instance
]

{ #category : #callbacks }
ERDoneForm class >> on: anAttendee callback: aBlock [
	| form |
	form := self new.
	form attendee: anAttendee.
	form callback: aBlock.
	^ form
]

{ #category : #accessing }
ERDoneForm >> callback [
	^ callback
]

{ #category : #accessing }
ERDoneForm >> callback: anObject [
	callback := anObject
]

{ #category : #initialization }
ERDoneForm >> initialize [
	super initialize.
]

{ #category : #'as yet unclassified' }
ERDoneForm >> registerAttendee [
	|user|
	user :=attendee userAccount save.
	attendee userAccount: user.
	^ attendee save.
	
]

{ #category : #rendering }
ERDoneForm >> renderFormOn: html [
	html
		html:
			' <h2>Complete</h2><br>
                   <p>You have successfully completed all steps.</p><br>'.
	html
		render:
			(self
				createButtonField: 'Save Information'
				with: self callback
				id: 'registerButton').
	html html: '<br><br><br><br><br><br><br><br><br>'.
	self renderPreviousTabFromOn: html
]

{ #category : #accessing }
ERDoneForm >> tabId [
	^ 'doneInfoForm'
]

{ #category : #accessing }
ERDoneForm >> tabName [
	^ 'Done'
]
