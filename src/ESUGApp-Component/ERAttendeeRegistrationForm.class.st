Class {
	#name : #ERAttendeeRegistrationForm,
	#superclass : #ERTab,
	#instVars : [
		'nextTabFrom',
		'previousTabFrom'
	],
	#category : #'ESUGApp-Component'
}

{ #category : #accessing }
ERAttendeeRegistrationForm >> id [
	^ id
]

{ #category : #accessing }
ERAttendeeRegistrationForm >> id: anObject [
	id := anObject
]

{ #category : #initialization }
ERAttendeeRegistrationForm >> initialize [
	super initialize.
	
]

{ #category : #rendering }
ERAttendeeRegistrationForm >> renderContentOn: html [
	self renderFormOn: html
]

{ #category : #rendering }
ERAttendeeRegistrationForm >> renderFormOn: html [
	self subclassResponsibility.
]
