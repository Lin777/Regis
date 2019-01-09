Class {
	#name : #ERComponentFactory,
	#superclass : #WAComponent,
	#instVars : [
		'attendee'
	],
	#category : #'ESUGApp-Form'
}

{ #category : #'instance creation' }
ERComponentFactory class >> on: anAttendee [
	| form |
	form := self new.
	form attendee: anAttendee.
	^ form
]

{ #category : #accessing }
ERComponentFactory >> attendee [
	^ attendee
]

{ #category : #accessing }
ERComponentFactory >> attendee: anObject [
	attendee := anObject
]

{ #category : #'as yet unclassified' }
ERComponentFactory >> createButtonField: aName with: aBlock id: anId on: html [
	html mdlButton
		beSubmit;
		id: anId;
		callback: aBlock;
		with: aName.

]

{ #category : #'as yet unclassified' }
ERComponentFactory >> createCheckboxField: aName for: aSymbol on: html [
    html mdlCheckboxContainer
		rippleEffect;
		for: (self idFromSymbol: aSymbol);
		with: [ html mdlCheckbox
				value: true;
				id: (self idFromSymbol: aSymbol).
			html mdlCheckboxLabel: aName ]
]

{ #category : #'as yet unclassified' }
ERComponentFactory >> createCheckboxField: aName for: aSymbol with: anotherSymbol on: html [
	html mdlCheckboxContainer
		rippleEffect;
		for: (self idFromSymbol: aSymbol);
		with: [ html mdlCheckbox
				value: (attendee perform: anotherSymbol);
				callback: [ :value | attendee perform: aSymbol with: value ];
				id: (self idFromSymbol: aSymbol).
			html mdlCheckboxLabel: aName ]
]

{ #category : #'as yet unclassified' }
ERComponentFactory >> createColoredAnchorButton: aName id: anId dialogId: aDialogId condition: aCondition on: html [
	html mdlAnchorButton
		onClick: (html jQuery id: aDialogId) dialog open
		if: aCondition;
		colored;
		id: anId;
		with: aName
]

{ #category : #'as yet unclassified' }
ERComponentFactory >> createColoredAnchorButton: aName id: anId on: html [
	html mdlAnchorButton 
		openDialogWithId: anId; 
		colored;
		with: aName.
]

{ #category : #'as yet unclassified' }
ERComponentFactory >> createColoredAnchorButton: aName with: aBlock id: anId on: html [
	html mdlAnchorButton
		colored;
		id: anId;
		callback: aBlock;
		with: aName
]

{ #category : #'as yet unclassified' }
ERComponentFactory >> createColoredButton: aName with: aBlock id: anId on: html [
	html mdlButton
		colored;
		id: anId ;
		callback: aBlock;
		with: aName
]

{ #category : #'as yet unclassified' }
ERComponentFactory >> createColoredButtonAsSubmit: aName with: aBlock id: anId on: html [
	html mdlButton
		colored;
		beSubmit;
		id: anId;
		callback: aBlock;
		with: aName
]

{ #category : #'as yet unclassified' }
ERComponentFactory >> createDivCell6ColWith: aBlock on: html [
    html div class: 'mdl-cell mdl-cell--6-col'; with: [ aBlock value ]
]

{ #category : #'as yet unclassified' }
ERComponentFactory >> createDivGridWith: aBlock on: html [
    html div class: 'mdl-grid'; with: [ aBlock value ]
]

{ #category : #'as yet unclassified' }
ERComponentFactory >> createHeadingStrong: aString level: aNumber on: html [
	html heading
		level: aNumber;
		with: [ html strong: aString]
]

{ #category : #'as yet unclassified' }
ERComponentFactory >> createHeadingStrong: aString level: aNumber withValue: aValue on: html [
	html heading
		level: aNumber;
		with: [ html strong: aString.
			html text: aValue ]
]

{ #category : #building }
ERComponentFactory >> createPasswordField: aName for: aSymbol on: html [
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
ERComponentFactory >> createPasswordField: aName id: anId callback: aBlock on: html [
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
ERComponentFactory >> createPasswordField: aName id: anId callback: aBlock pattern: aRegularExpression textError: aTextFieldError on: html [
	html mdlTextFieldContainer
		floatingLabel;
		with: [ html mdlTextFieldLabel
				for: anId;
				with: aName.
			html mdlTextFieldInput
				id: anId;
				type: 'password';
				pattern: aRegularExpression;
				callback: aBlock.
			html mdlTextFieldError: aTextFieldError ]
]

{ #category : #building }
ERComponentFactory >> createPasswordField: aName withCallback: aBlock on: html [
	html mdlTextFieldContainer
		floatingLabel;
		with: [ html mdlTextFieldLabel
				with: aName.
			html mdlTextFieldInput
				type: 'password';
				callback: aBlock]
]

{ #category : #building }
ERComponentFactory >> createPasswordRequiredField: aName id: anId callback: aBlock on: html [
	html mdlTextFieldContainer
		floatingLabel;
		with: [ html mdlTextFieldLabel
				for: anId;
				with: aName.
			html mdlTextFieldInput
				id: anId;
				required;
				type: 'password';
				callback: aBlock ]
]

{ #category : #'as yet unclassified' }
ERComponentFactory >> createRaisedColoredRippleEffectAnchorButton: aName with: aBlock id: anId on: html [
	html mdlAnchorButton
		raised;
		colored;
		rippleEffect;
		id: anId;
		callback: aBlock;
		with: aName
]

{ #category : #'as yet unclassified' }
ERComponentFactory >> createRaisedRippleEffectAnchorButton: aName with: aBlock id: anId on: html [
	html mdlAnchorButton 
		raised;
		rippleEffect;
		id: anId;
		callback: aBlock;
		with: aName
]

{ #category : #'as yet unclassified' }
ERComponentFactory >> createRaisedRippleEffectButton: aName with: aBlock id: anId on: html [
	html mdlButton
		raised;
		rippleEffect;
		id: anId;
		callback: aBlock;
		with: aName
]

{ #category : #'as yet unclassified' }
ERComponentFactory >> createRaisedRippleEffectPrimaryAnchorButton: aName with: aBlock id: anId on: html [
	html mdlAnchorButton
		raised;
		primaryColor;
		rippleEffect;
		id: anId;
		callback: aBlock;
		with: aName
]

{ #category : #'as yet unclassified' }
ERComponentFactory >> createRaisedRippleEffectPrimaryButton: aName with: aBlock id: anId on: html [
	html mdlButton
		beSubmit;
		raised;
		primaryColor;
		rippleEffect;
		id: anId;
		callback: aBlock;
		with: aName
]

{ #category : #building }
ERComponentFactory >> createRequiredField: aName id: anId type: aType callback: aBlock on: html [
	html mdlTextFieldContainer
		floatingLabel;
		with: [ html mdlTextFieldLabel
				for: anId;
				with: aName.
			html mdlTextFieldInput
				id: anId;
				required;
				type: aType;
				callback: aBlock ]
]

{ #category : #building }
ERComponentFactory >> createRequiredTextField: aName for: aSymbol with: anotherSymbol on: html [
	html mdlTextFieldContainer
		floatingLabel;
		with: [ html mdlTextFieldLabel
				for: (self idFromSymbol: aSymbol);
				with: aName.
			html mdlTextFieldInput
				required;
				id: (self idFromSymbol: aSymbol);
				value: (attendee perform: anotherSymbol);
				callback: [ :value | 
					attendee perform: aSymbol with: value asString ] ]
]

{ #category : #'as yet unclassified' }
ERComponentFactory >> createRequiredTextField: aName for: aSymbol with: anotherSymbol percent: aNumber on: html [
	html mdlTextFieldContainer
		floatingLabel;
		style: 'width:' , aNumber asString , '%';
		with: [ html mdlTextFieldLabel
				for: (self idFromSymbol: aSymbol);
				with: aName.
			html mdlTextFieldInput
				required;
				id: (self idFromSymbol: aSymbol);
				value: (attendee perform: anotherSymbol);
				callback: [ :value | attendee perform: aSymbol with: value asString ]].
]

{ #category : #'as yet unclassified' }
ERComponentFactory >> createSelectField: aName for: aSymbol with: anotherSymbol list: aList on: html [
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
ERComponentFactory >> createSelectField: aName for: aSymbol with: anotherSymbol list: aList percent: aNumber on: html [
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
ERComponentFactory >> createSelectField: aName for: aSymbol with: anotherSymbol list: aList percent: aNumber to: anObject on: html [
	html mdlTextFieldContainer
		floatingLabel;
		style: 'width:' , aNumber asString , '%';
		with: [ html mdlTextFieldLabel with: aName.
			html select
				class: 'mdl-textfield__input';
				id: (self idFromSymbol: aSymbol);
				list: aList;
				selected: (anObject perform: anotherSymbol);
				callback: [ :value | anObject perform: aSymbol with: value asString ] ]
]

{ #category : #'as yet unclassified' }
ERComponentFactory >> createSelectField: aName for: aSymbol with: anotherSymbol list: aList to: anObject on: html [
	html mdlTextFieldContainer
		floatingLabel;
		with: [ html mdlTextFieldLabel with: aName.
			html select
				class: 'mdl-textfield__input';
				id: (self idFromSymbol: aSymbol);
				list: aList;
				selected: (anObject perform: anotherSymbol);
				callback: [ :value | anObject perform: aSymbol with: value asString ] ]
]

{ #category : #'as yet unclassified' }
ERComponentFactory >> createSelectField: aName list: aList callback: aBlock withId: anId on: html [
	html mdlTextFieldContainer
		floatingLabel;
		with: [ html mdlTextFieldLabel with: aName.
			html select
				onChange: 'submit()';
				class: 'mdl-textfield__input';
				id: anId;
				list: aList;
				callback: aBlock ]
]

{ #category : #'as yet unclassified' }
ERComponentFactory >> createStrongText: aString to: html [
	html paragraph: [ html strong: aString]
]

{ #category : #'as yet unclassified' }
ERComponentFactory >> createTextAreaField: aName for: aSymbol on: html [
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
ERComponentFactory >> createTextAreaField: aName for: aSymbol with: anotherSymbol on: html [
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

{ #category : #'as yet unclassified' }
ERComponentFactory >> createTextAreaField: aName for: aSymbol with: anotherSymbol to: anObject on: html [
	html mdlTextFieldContainer
		floatingLabel;
		with: [ html mdlTextFieldLabel
				for: (self idFromSymbol: aSymbol);
				with: aName.
			html mdlTextArea
				id: (self idFromSymbol: aSymbol);
				rows: 13;
				value: (anObject perform: anotherSymbol);
				callback: [ :value | anObject perform: aSymbol with: value asString ] ]
]

{ #category : #'as yet unclassified' }
ERComponentFactory >> createTextAreaField: aName for: aSymbol with: anotherSymbol withRows: cantOfRows to: anObject on: html [
	html mdlTextFieldContainer
		floatingLabel;
		with: [ html mdlTextFieldLabel
				for: (self idFromSymbol: aSymbol);
				with: aName.
			html mdlTextArea
				id: (self idFromSymbol: aSymbol);
				rows: cantOfRows;
				value: (anObject perform: anotherSymbol);
				callback: [ :value | anObject perform: aSymbol with: value asString ] ]
]

{ #category : #building }
ERComponentFactory >> createTextField: aName for: aSymbol with: anotherSymbol on: html [
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
ERComponentFactory >> createTextField: aName for: aSymbol with: anotherSymbol percent: aNumber on: html [
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
ERComponentFactory >> createTextField: aName for: aSymbol with: anotherSymbol percent: aNumber to: anObject on: html [
	html mdlTextFieldContainer
		floatingLabel;
		style: 'width:' , aNumber asString , '%';
		with: [ html mdlTextFieldLabel
				for: (self idFromSymbol: aSymbol);
				with: aName.
			html mdlTextFieldInput
				id: (self idFromSymbol: aSymbol);
				value: (anObject perform: anotherSymbol);
				callback: [ :value | anObject perform: aSymbol with: value asString ] ]
]

{ #category : #building }
ERComponentFactory >> createTextField: aName for: aSymbol with: anotherSymbol to: anObject on: html [
	html mdlTextFieldContainer
		floatingLabel;
		with: [ html mdlTextFieldLabel
				for: (self idFromSymbol: aSymbol);
				with: aName.
			html mdlTextFieldInput
				id: (self idFromSymbol: aSymbol);
				value: (anObject perform: anotherSymbol);
				callback: [ :value | anObject perform: aSymbol with: value asString ] ]
]

{ #category : #building }
ERComponentFactory >> createTextField: aName id: anId callback: aBlock on: html [
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
ERComponentFactory >> createTextField: aName id: anId callback: aBlock pattern: aRegularExpression textError: aTextFieldError on: html [
	html mdlTextFieldContainer
		floatingLabel;
		with: [ html mdlTextFieldLabel
				for: anId;
				with: aName.
			html mdlTextFieldInput
				id: anId;
				pattern: aRegularExpression;
				callback: aBlock.
			html mdlTextFieldError: aTextFieldError ]
]

{ #category : #building }
ERComponentFactory >> createTextField: aName withCallback: aBlock on: html [
	html mdlTextFieldContainer
		floatingLabel;
		with: [ html mdlTextFieldLabel
				with: aName.
			html mdlTextFieldInput
				callback: aBlock]
]

{ #category : #'as yet unclassified' }
ERComponentFactory >> createTextStrong: aString with: aSymbol on: html [
	html
		paragraph: [ html strong: aString.
			html text: (attendee perform: aSymbol) ]
]

{ #category : #'as yet unclassified' }
ERComponentFactory >> createTextStrong: aString withText: aText on: html [
	html
		paragraph: [ html strong: aString.
			html text: aText ]
]

{ #category : #'as yet unclassified' }
ERComponentFactory >> createTextStrongWithoutParagraph: aString with: aSymbol on: html [
	html strong: aString.
			html text: (attendee perform: aSymbol).
	html break.
]

{ #category : #'as yet unclassified' }
ERComponentFactory >> createTextStrongWithoutParagraph: aString withText: aText on: html [
	html strong: aString.
			html text: aText.
	html break .
]

{ #category : #building }
ERComponentFactory >> idFromSymbol: aSymbol [
	^ (aSymbol substrings: ':') first
]
