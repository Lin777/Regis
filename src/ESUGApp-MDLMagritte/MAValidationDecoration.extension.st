Extension { #name : #MAValidationDecoration }

{ #category : #'*ESUGApp-MDLMagritte' }
MAValidationDecoration >> renderErrorsOn: html [
	html break .
	html div class: 'errors'; with:[
	html unorderedList
		list: self errors;
		with: nil]
]
