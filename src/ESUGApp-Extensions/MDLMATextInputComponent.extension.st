Extension { #name : #MDLMATextInputComponent }

{ #category : #'*ESUGApp-Extensions' }
MDLMATextInputComponent >> renderInputOn: html [
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
				addAttributeAt: 'disabled' if: self disabled;
				on: #string of: self ]
]
