Class {
	#name : #ERAttendeeRegistrationTabForm,
	#superclass : #ERTab,
	#instVars : [
		'nextTabFrom',
		'previousTabFrom'
	],
	#category : #'ESUGApp-Components'
}

{ #category : #scripting }
ERAttendeeRegistrationTabForm class >> on: anAttendee [
	| form |
	form := self new.
	form attendee: anAttendee.
	^ form
]

{ #category : #building }
ERAttendeeRegistrationTabForm >> createCheckboxField: aName [
	^  ERCheckboxFieldLabel label: aName callback: [ :value |]
]

{ #category : #building }
ERAttendeeRegistrationTabForm >> createCheckboxField: aName for: aSymbol [
	^  ERCheckboxFieldLabel label: aName callback: [ :value | attendee perform: aSymbol with: value asString ]
]

{ #category : #building }
ERAttendeeRegistrationTabForm >> createPasswordField: aName [
		^ (self createTextField: aName) forPassword.
]

{ #category : #building }
ERAttendeeRegistrationTabForm >> createPasswordField: aName for: aSymbol [
	^ (ERTextFieldLabel label: aName callback: [ :value | attendee perform: aSymbol with: (ERUserAccount hashPassword: value asString)] id: (self idFromSymbol: aSymbol) ) forPassword
]

{ #category : #building }
ERAttendeeRegistrationTabForm >> createRadioField: aName for: aSymbol list: aList listValues: aListValues [
	^  ERRadioFieldLabel label: aName list: aList listValues: aListValues id: (self idFromSymbol: aSymbol )
]

{ #category : #building }
ERAttendeeRegistrationTabForm >> createSelectField: aName for: aSymbol list: aList [
	^  ERSelectFieldLabel label: aName callback: [ :value | attendee perform: aSymbol with: value asString .] list: aList id: (self idFromSymbol: aSymbol) 
]

{ #category : #building }
ERAttendeeRegistrationTabForm >> createSelectField: aName for: aSymbol list: aList percent: aNumber [
	^  ERSelectFieldLabel label: aName callback: [ :value | attendee perform: aSymbol with: value asString .] list: aList id: (self idFromSymbol: aSymbol) percent: aNumber  
]

{ #category : #building }
ERAttendeeRegistrationTabForm >> createTextAreaField: aName for: aSymbol [
	^  ERTextAreaFieldLabel label: aName callback: [ :value | attendee perform: aSymbol with: value asString .] id: (self idFromSymbol: aSymbol )
]

{ #category : #accessing }
ERAttendeeRegistrationTabForm >> id [
	^ id
]

{ #category : #accessing }
ERAttendeeRegistrationTabForm >> id: anObject [
	id := anObject
]

{ #category : #building }
ERAttendeeRegistrationTabForm >> idFromSymbol: aSymbol [
	^ (aSymbol substrings: ':') first 
]

{ #category : #accessing }
ERAttendeeRegistrationTabForm >> nextTabFrom [
	^ nextTabFrom
]

{ #category : #accessing }
ERAttendeeRegistrationTabForm >> nextTabFrom: anObject [
	nextTabFrom := anObject
]

{ #category : #accessing }
ERAttendeeRegistrationTabForm >> previousTabFrom [
	^ previousTabFrom
]

{ #category : #accessing }
ERAttendeeRegistrationTabForm >> previousTabFrom: anObject [
	previousTabFrom := anObject
]

{ #category : #rendering }
ERAttendeeRegistrationTabForm >> renderContentOn: html [
	self renderFormOn: html
]

{ #category : #rendering }
ERAttendeeRegistrationTabForm >> renderFormOn: html [
	self subclassResponsibility.
]
