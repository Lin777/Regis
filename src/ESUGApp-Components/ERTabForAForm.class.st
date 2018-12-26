Class {
	#name : #ERTabForAForm,
	#superclass : #ERAttendeeRegistrationForm,
	#instVars : [
		'form'
	],
	#category : #'ESUGApp-Components'
}

{ #category : #accessing }
ERTabForAForm class >> form: aForm [
	| tab |
	tab := self new.
	tab form: aForm.
	^ tab
]

{ #category : #accessing }
ERTabForAForm >> form: anObject [
	form := anObject
]

{ #category : #rendering }
ERTabForAForm >> renderFormOn: html [
	html render: form
]

{ #category : #rendering }
ERTabForAForm >> tabId [
	^ form formId
]

{ #category : #rendering }
ERTabForAForm >> tabName [
	^ form formName
]
