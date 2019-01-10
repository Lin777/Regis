Class {
	#name : #ERDoneForm,
	#superclass : #ERAttendeeRegistrationForm,
	#instVars : [
		'button'
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
ERDoneForm class >> on: anAttendee button: aBlock [
	| form |
	form := self new.
	form attendee: anAttendee.
	form button: aBlock.
	^ form
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
ERDoneForm >> button: anObject [
	button := anObject
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
	html heading level2 with: 'Complete'.
	html break.
	html paragraph: 'You have successfully completed all steps.'.
	html break.
	button cull: html.
	"self
		createRaisedRippleEffectPrimaryButton: 'Save Information'
		with: self callback
		id: 'registerButton'
		on: html."
	1 to: 9 do: [ :i | html break ]
]

{ #category : #accessing }
ERDoneForm >> tabId [
	^ 'doneInfoForm'
]

{ #category : #accessing }
ERDoneForm >> tabName [
	^ 'Done'
]
