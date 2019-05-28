Extension { #name : #MDLMATextAreaComponent }

{ #category : #'*ESUGApp-Extensions' }
MDLMATextAreaComponent >> renderEditorOn: html [
	| inputId |
	inputId := self labelId.
	html mdlTextFieldContainer
		floatingLabel;
		style: 'display: block';
		with: [ 
			html mdlTextFieldLabel
				for: inputId;
				with: self magritteDescription label .
			html mdlTextArea
				id: inputId;
				rows: self magritteDescription lineCount;
				addAttributeAt: 'disabled' if: self disabled;
				on: #string of: self ]
]
