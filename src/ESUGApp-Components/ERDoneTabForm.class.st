Class {
	#name : #ERDoneTabForm,
	#superclass : #ERAttendeeRegistrationTabForm,
	#instVars : [
		'callback'
	],
	#category : #'ESUGApp-Components'
}

{ #category : #callbacks }
ERDoneTabForm class >> callback: aBlock [
	| instance |
	instance := self new.
	instance callback: aBlock.
	^ instance
]

{ #category : #callbacks }
ERDoneTabForm class >> on: anAttendee callback: aBlock [
	| form |
	form := self new.
	form attendee: anAttendee.
	form callback: aBlock.
	^ form
]

{ #category : #accessing }
ERDoneTabForm >> callback [
	^ callback
]

{ #category : #accessing }
ERDoneTabForm >> callback: anObject [
	callback := anObject
]

{ #category : #'as yet unclassified' }
ERDoneTabForm >> registerAttendee [
	|user|
	user :=attendee userAccount save.
	attendee userAccount: user.
	^ attendee save.
	
]

{ #category : #rendering }
ERDoneTabForm >> renderFormOn: html [
   html html:' <h2>Complete</h2><br>
                   <p>You have successfully completed all steps.</p><br>'.
	html render: (self createButtonField: 'Save Information' with: self callback id: 'registerButton').
	html html: '<br><br><br><br><br><br><br><br><br>'
]

{ #category : #accessing }
ERDoneTabForm >> tabId [
	^ 'doneInfoForm'
]

{ #category : #accessing }
ERDoneTabForm >> tabName [
	^ 'Done'
]
