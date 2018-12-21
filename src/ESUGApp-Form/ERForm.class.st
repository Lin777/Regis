Class {
	#name : #ERForm,
	#superclass : #WAComponent,
	#instVars : [
		'attendee'
	],
	#category : #'ESUGApp-Form'
}

{ #category : #'instance creation' }
ERForm class >> on: anAttendee [
	| form |
	form := self new.
	form attendee: anAttendee.
	^ form
]

{ #category : #accessing }
ERForm >> attendee [
	^ attendee
]

{ #category : #accessing }
ERForm >> attendee: anObject [
	attendee := anObject
]

{ #category : #'as yet unclassified' }
ERForm >> createButtonField: aName with: aBlock id: anId on: html [
	html mdlButton
		beSubmit;
		id: anId;
		callback: aBlock;
		with: aName.

]

{ #category : #'as yet unclassified' }
ERForm >> createCheckboxField: aName for: aSymbol on: html [
    html mdlCheckboxContainer
		rippleEffect;
		for: (self idFromSymbol: aSymbol);
		with: [ html mdlCheckbox
				value: true;
				id: (self idFromSymbol: aSymbol).
			html mdlCheckboxLabel: aName ]
]

{ #category : #building }
ERForm >> createPasswordField: aName for: aSymbol on: html [
	html mdlTextFieldContainer
		floatingLabel;
		with: [ html mdlTextFieldLabel
				for: (self idFromSymbol: aSymbol);
				with: aName.
			html mdlTextFieldInput
				id: (self idFromSymbol: aSymbol);
				type: 'password';
				callback: [ :value | 
			attendee
				perform: aSymbol
				with: (ERUserAccount hashPassword: value asString) ] ]
]

{ #category : #'as yet unclassified' }
ERForm >> createSelectField: aName for: aSymbol list: aList on: html [
html mdlTextFieldContainer
		floatingLabel;
		with: [ html mdlTextFieldLabel with: aName.
			html select
				class: 'mdl-textfield__input';
				id: (self idFromSymbol: aSymbol);
				list: aList;
				callback: [ :value | attendee perform: aSymbol with: value asString ] ].
]

{ #category : #'as yet unclassified' }
ERForm >> createSelectField: aName for: aSymbol list: aList percent: aNumber on: html [
	html mdlTextFieldContainer
		floatingLabel;
		style: 'width:' , aNumber asString , '%';
		with: [ html mdlTextFieldLabel with: aName.
			html select
				class: 'mdl-textfield__input';
				id: (self idFromSymbol: aSymbol);
				list: aList;
				callback: [ :value | attendee perform: aSymbol with: value asString ] ]
]

{ #category : #'as yet unclassified' }
ERForm >> createTextAreaField: aName for: aSymbol on: html [
	html mdlTextFieldContainer
		floatingLabel;
		with: [ html mdlTextFieldLabel
				for: (self idFromSymbol: aSymbol);
				with: aName .
			html mdlTextArea
				id: (self idFromSymbol: aSymbol);
				rows: 13;
				callback: [ :value | attendee perform: aSymbol with: value asString ] ].
]

{ #category : #'as yet unclassified' }
ERForm >> createTextAreaField: aName for: aSymbol with: anotherSymbol on: html [
	html mdlTextFieldContainer
		floatingLabel;
		with: [ html mdlTextFieldLabel
				for: (self idFromSymbol: aSymbol);
				with: aName.
			html mdlTextArea
				id: (self idFromSymbol: aSymbol);
				rows: 13;
				value: (attendee perform: anotherSymbol);
				callback: [ :value | attendee perform: aSymbol with: value asString ] ]
]

{ #category : #building }
ERForm >> createTextField: aName for: aSymbol with: anotherSymbol on: html [
	html mdlTextFieldContainer
		floatingLabel;
		with: [ html mdlTextFieldLabel
				for: (self idFromSymbol: aSymbol);
				with: aName.
			html mdlTextFieldInput
				id: (self idFromSymbol: aSymbol);
				value: (attendee perform: anotherSymbol);
				callback: [ :value | attendee perform: aSymbol with: value asString ] ].
]

{ #category : #'as yet unclassified' }
ERForm >> createTextField: aName for: aSymbol with: anotherSymbol percent: aNumber on: html [
	html mdlTextFieldContainer
		floatingLabel;
		style: 'width:' , aNumber asString , '%';
		with: [ html mdlTextFieldLabel
				for: (self idFromSymbol: aSymbol);
				with: aName.
			html mdlTextFieldInput
				id: (self idFromSymbol: aSymbol);
				value: (attendee perform: anotherSymbol);
				callback: [ :value | attendee perform: aSymbol with: value asString ]].
]

{ #category : #'as yet unclassified' }
ERForm >> createTextStrong: aString with: aSymbol on: html [
	html
		paragraph: [ html strong: aString.
			html text: (attendee perform: aSymbol) ]
]

{ #category : #building }
ERForm >> idFromSymbol: aSymbol [
	^ (aSymbol substrings: ':') first
]
