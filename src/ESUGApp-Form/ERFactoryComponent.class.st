Class {
	#name : #ERFactoryComponent,
	#superclass : #WAComponent,
	#instVars : [
		'attendee'
	],
	#category : #'ESUGApp-Form'
}

{ #category : #'instance creation' }
ERFactoryComponent class >> on: anAttendee [
	| form |
	form := self new.
	form attendee: anAttendee.
	^ form
]

{ #category : #accessing }
ERFactoryComponent >> attendee [
	^ attendee
]

{ #category : #accessing }
ERFactoryComponent >> attendee: anObject [
	attendee := anObject
]

{ #category : #'as yet unclassified' }
ERFactoryComponent >> createButtonField: aName with: aBlock id: anId on: html [
	html mdlButton
		beSubmit;
		id: anId;
		callback: aBlock;
		with: aName.

]

{ #category : #'as yet unclassified' }
ERFactoryComponent >> createCheckboxField: aName for: aSymbol on: html [
    html mdlCheckboxContainer
		rippleEffect;
		for: (self idFromSymbol: aSymbol);
		with: [ html mdlCheckbox
				value: true;
				id: (self idFromSymbol: aSymbol).
			html mdlCheckboxLabel: aName ]
]

{ #category : #building }
ERFactoryComponent >> createPasswordField: aName for: aSymbol on: html [
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

{ #category : #building }
ERFactoryComponent >> createPasswordField: aName id: anId callback: aBlock on: html [
	html mdlTextFieldContainer
		floatingLabel;
		with: [ html mdlTextFieldLabel
				for: anId ;
				with: aName.
			html mdlTextFieldInput
				id: anId ;
				type: 'password';
				callback: aBlock]
]

{ #category : #building }
ERFactoryComponent >> createPasswordField: aName withCallback: aBlock on: html [
	html mdlTextFieldContainer
		floatingLabel;
		with: [ html mdlTextFieldLabel
				with: aName.
			html mdlTextFieldInput
				type: 'password';
				callback: aBlock]
]

{ #category : #'as yet unclassified' }
ERFactoryComponent >> createSelectField: aName for: aSymbol list: aList on: html [
	html mdlTextFieldContainer
		floatingLabel;
		with: [ html mdlTextFieldLabel with: aName.
			html select
				class: 'mdl-textfield__input';
				id: (self idFromSymbol: aSymbol);
				list: aList;
				callback: [ :value | 
					attendee perform: aSymbol with: value asString ] ]
]

{ #category : #'as yet unclassified' }
ERFactoryComponent >> createSelectField: aName for: aSymbol list: aList percent: aNumber on: html [
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
ERFactoryComponent >> createSelectField: aName for: aSymbol with: anotherSymbol list: aList on: html [
	html mdlTextFieldContainer
		floatingLabel;
		with: [ html mdlTextFieldLabel with: aName.
			html select
				class: 'mdl-textfield__input';
				id: (self idFromSymbol: aSymbol);
				list: aList;
				selected: (attendee perform: anotherSymbol);
				callback: [ :value | attendee perform: aSymbol with: value asString ] ]
]

{ #category : #'as yet unclassified' }
ERFactoryComponent >> createSelectField: aName for: aSymbol with: anotherSymbol list: aList percent: aNumber on: html [
	html mdlTextFieldContainer
		floatingLabel;
		style: 'width:' , aNumber asString , '%';
		with: [ html mdlTextFieldLabel with: aName.
			html select
				class: 'mdl-textfield__input';
				id: (self idFromSymbol: aSymbol);
				list: aList;
				selected: (attendee perform: anotherSymbol);
				callback: [ :value | 
					attendee perform: aSymbol with: value asString ] ]
]

{ #category : #'as yet unclassified' }
ERFactoryComponent >> createTextAreaField: aName for: aSymbol on: html [
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
ERFactoryComponent >> createTextAreaField: aName for: aSymbol with: anotherSymbol on: html [
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
ERFactoryComponent >> createTextField: aName for: aSymbol with: anotherSymbol on: html [
	html mdlTextFieldContainer
		floatingLabel;
		with: [ html mdlTextFieldLabel
				for: (self idFromSymbol: aSymbol);
				with: aName.
			html mdlTextFieldInput
				id: (self idFromSymbol: aSymbol);
				value: (attendee perform: anotherSymbol);
				callback: [ :value | 
					attendee perform: aSymbol with: value asString ] ]
]

{ #category : #'as yet unclassified' }
ERFactoryComponent >> createTextField: aName for: aSymbol with: anotherSymbol percent: aNumber on: html [
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

{ #category : #building }
ERFactoryComponent >> createTextField: aName id: anId callback: aBlock on: html [
	html mdlTextFieldContainer
		floatingLabel;
		with: [ html mdlTextFieldLabel
				for: anId ;
				with: aName.
			html mdlTextFieldInput
				id: anId ;
				callback: aBlock]
]

{ #category : #building }
ERFactoryComponent >> createTextField: aName withCallback: aBlock on: html [
	html mdlTextFieldContainer
		floatingLabel;
		with: [ html mdlTextFieldLabel
				with: aName.
			html mdlTextFieldInput
				callback: aBlock]
]

{ #category : #'as yet unclassified' }
ERFactoryComponent >> createTextStrong: aString with: aSymbol on: html [
	html
		paragraph: [ html strong: aString.
			html text: (attendee perform: aSymbol) ]
]

{ #category : #'as yet unclassified' }
ERFactoryComponent >> createTextStrong: aString withText: aText on: html [
	html
		paragraph: [ html strong: aString.
			html text: aText ]
]

{ #category : #building }
ERFactoryComponent >> idFromSymbol: aSymbol [
	^ (aSymbol substrings: ':') first
]
