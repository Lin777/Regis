"
Description
--------------------

MDL component class for a MAPasswordDescription
"
Class {
	#name : #MDLMATextPasswordComponent,
	#superclass : #MDLMATextInputComponent,
	#category : #'ESUGApp-Extensions'
}

{ #category : #visiting }
MDLMATextPasswordComponent >> acceptMagritte: aVisitor [
	aVisitor visitPasswordDescription: self
]

{ #category : #visiting }
MDLMATextPasswordComponent >> isObfuscated: anObject [
	^ anObject notNil
		and: [ anObject isString
		and: [ anObject isEmpty not
		and: [ anObject allSatisfy: [ :each | each = $* ] ] ] ]
]

{ #category : #visiting }
MDLMATextPasswordComponent >> isSortable [
	^ false
]

{ #category : #visiting }
MDLMATextPasswordComponent >> obfuscated: anObject [
	^ String new: anObject size withAll: $*
]

{ #category : #visiting }
MDLMATextPasswordComponent >> renderInputOn: html [
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
				type: 'password';
				addAttributeAt: 'disabled' if: self disabled;
				on: #string of: self ]
]
