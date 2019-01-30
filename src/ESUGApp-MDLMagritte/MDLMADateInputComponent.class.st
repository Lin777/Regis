"
TODO when we will have a nice MDLCalendar
"
Class {
	#name : #MDLMADateInputComponent,
	#superclass : #MADateInputComponent,
	#instVars : [
		'date'
	],
	#category : #'ESUGApp-MDLMagritte'
}

{ #category : #rendering }
MDLMADateInputComponent >> choose [
]

{ #category : #rendering }
MDLMADateInputComponent >> initialize [
	super initialize.
	date := Date today mmddyyyy 
]

{ #category : #rendering }
MDLMADateInputComponent >> renderButtonOn: html [
]

{ #category : #rendering }
MDLMADateInputComponent >> renderContentOn: html [
			| inputId |
	inputId := self labelId.
	html mdlTextFieldContainer
		style: 'display: block';
		floatingLabel;
		with: [ html mdlTextFieldLabel
				for: inputId;
				with: self magritteDescription label.
			html mdlTextFieldInput
				id: inputId;
				on: #string of: self;
				script: (html jQuery new datepicker
			onSelect: (html jQuery ajax serializeThis)) ]
]
