Extension { #name : #MDLMATextAreaComponent }

{ #category : #'*ESUGApp-MDLMagritte' }
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
				on: #string of: self ]
]
