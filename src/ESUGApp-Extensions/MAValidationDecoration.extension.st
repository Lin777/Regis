Extension { #name : #MAValidationDecoration }

{ #category : #'*ESUGApp-Extensions' }
MAValidationDecoration >> renderErrorsOn: html [
	html break .
	html div class: 'errors'; with:[
		self errors do: [:error | html render: error]
	]
]
