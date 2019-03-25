Class {
	#name : #ERDoneButton,
	#superclass : #ERTab,
	#instVars : [
		'button'
	],
	#category : #'ESUGApp-Component'
}

{ #category : #callbacks }
ERDoneButton class >> on: anAttendee button: aBlock container: aContainer [
	| form |
	form := self new.
	form attendee: anAttendee.
	form button: aBlock.
	form container: aContainer.
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
