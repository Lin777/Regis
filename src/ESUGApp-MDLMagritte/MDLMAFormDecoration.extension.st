Extension { #name : #MDLMAFormDecoration }

{ #category : #'*ESUGApp-MDLMagritte' }
MDLMAFormDecoration >> renderButtonsOn: html [
	html div
		class: 'mdl-typography--text-right';
		with: [ self buttons
						do: [ :each |
									html mdlButton
										colored 
								style: 'margin: 5px;';
								accessKey: each value first;
								callback: [ self execute: each key ];
								text: each value ] ]
]
