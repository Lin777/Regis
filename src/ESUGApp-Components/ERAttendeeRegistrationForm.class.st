Class {
	#name : #ERAttendeeRegistrationForm,
	#superclass : #ERTab,
	#instVars : [
		'nextTabFrom',
		'previousTabFrom'
	],
	#category : #'ESUGApp-Components'
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

{ #category : #accessing }
ERAttendeeRegistrationForm >> nextTabFrom [
	^ nextTabFrom
]

{ #category : #accessing }
ERAttendeeRegistrationForm >> nextTabFrom: anObject [
	nextTabFrom := anObject
]

{ #category : #accessing }
ERAttendeeRegistrationForm >> previousTabFrom [
	^ previousTabFrom
]

{ #category : #accessing }
ERAttendeeRegistrationForm >> previousTabFrom: anObject [
	previousTabFrom := anObject
]

{ #category : #rendering }
ERAttendeeRegistrationForm >> renderContentOn: html [
	self renderFormOn: html
]

{ #category : #rendering }
ERAttendeeRegistrationForm >> renderFormOn: html [
	self subclassResponsibility.
]

{ #category : #rendering }
ERAttendeeRegistrationForm >> renderNextTabFromOn: html [
	html mdlButton
		bePush;
		primaryColor;
		class: 'btnNext';
		with: 'Next'
]

{ #category : #rendering }
ERAttendeeRegistrationForm >> renderPreviousTabFromOn: html [
	html mdlButton
		bePush;
		primaryColor;
		class: 'btnPrevious';
		with: 'Previous'
]
