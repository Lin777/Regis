Class {
	#name : #ERAttendeeRegistrationForm,
	#superclass : #ERTab,
	#instVars : [
		'nextTabFrom',
		'previousTabFrom'
	],
	#category : #'ESUGApp-Components'
}

{ #category : #scripting }
ERAttendeeRegistrationForm class >> on: anAttendee [
	| form |
	form := self new.
	form attendee: anAttendee.
	^ form
]

{ #category : #building }
ERAttendeeRegistrationForm >> createCheckboxField: aName [
	^  ERCheckboxFieldLabel label: aName callback: [ :value |]
]

{ #category : #building }
ERAttendeeRegistrationForm >> createCheckboxField: aName for: aSymbol [
	^  ERCheckboxFieldLabel label: aName callback: [ :value | attendee perform: aSymbol with: value asString ]
]

{ #category : #building }
ERAttendeeRegistrationForm >> createPasswordField: aName [
		^ (self createTextField: aName) forPassword.
]

{ #category : #building }
ERAttendeeRegistrationForm >> createPasswordField: aName for: aSymbol [
	^ (ERTextFieldLabel label: aName callback: [ :value | attendee perform: aSymbol with: (ERUserAccount hashPassword: value asString)] id: (self idFromSymbol: aSymbol) ) forPassword
]

{ #category : #building }
ERAttendeeRegistrationForm >> createRadioField: aName for: aSymbol list: aList listValues: aListValues [
	^  ERRadioFieldLabel label: aName list: aList listValues: aListValues id: (self idFromSymbol: aSymbol )
]

{ #category : #building }
ERAttendeeRegistrationForm >> createSelectField: aName for: aSymbol list: aList [
	^  ERSelectFieldLabel label: aName callback: [ :value | attendee perform: aSymbol with: value asString .] list: aList id: (self idFromSymbol: aSymbol) 
]

{ #category : #building }
ERAttendeeRegistrationForm >> createSelectField: aName for: aSymbol list: aList percent: aNumber [
	^  ERSelectFieldLabel label: aName callback: [ :value | attendee perform: aSymbol with: value asString .] list: aList id: (self idFromSymbol: aSymbol) percent: aNumber  
]

{ #category : #building }
ERAttendeeRegistrationForm >> createTextAreaField: aName for: aSymbol [
	^  ERTextAreaFieldLabel label: aName callback: [ :value | attendee perform: aSymbol with: value asString .] id: (self idFromSymbol: aSymbol )
]

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
