Class {
	#name : #ERDoneButton,
	#superclass : #ERContentTab,
	#instVars : [
		'button'
	],
	#category : #'ESUGApp-Component'
}

{ #category : #callbacks }
ERDoneButton class >> callback: aBlock [
	| instance |
	instance := self new.
	instance callback: aBlock.
	^ instance
]

{ #category : #callbacks }
ERDoneButton class >> on: anAttendee button: aBlock [
	| form |
	form := self new.
	form attendee: anAttendee.
	form button: aBlock.
	^ form
]

{ #category : #callbacks }
ERDoneButton class >> on: anAttendee callback: aBlock [
	| form |
	form := self new.
	form attendee: anAttendee.
	form callback: aBlock.
	^ form
]

{ #category : #accessing }
ERDoneButton >> button: anObject [
	button := anObject
]

{ #category : #initialization }
ERDoneButton >> initialize [
	super initialize.
]

{ #category : #'as yet unclassified' }
ERDoneButton >> registerAttendee [
	|user|
	user :=attendee userAccount save.
	attendee userAccount: user.
	^ attendee save.
	
]

{ #category : #rendering }
ERDoneButton >> renderContentOn: html [
	html heading level2 with: 'Complete'.
	html break.
	html paragraph: 'You have successfully completed all steps.'.
	html break.
	button cull: html.
	1 to: 9 do: [ :i | html break ]
]

{ #category : #accessing }
ERDoneButton >> tabId [
	^ 'doneInfoForm'
]

{ #category : #accessing }
ERDoneButton >> tabName [
	^ 'Done'
]
