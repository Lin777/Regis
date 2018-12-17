Class {
	#name : #ERJQValidateForm,
	#superclass : #WAFileLibrary,
	#category : #'ESUGApp-Library-MDL'
}

{ #category : #updating }
ERJQValidateForm >> updateRoot: anHtmlRoot [
	"super updateRoot: anHtmlRoot."
	anHtmlRoot javascript
		url: 'https://cdn.jsdelivr.net/npm/jquery-validation@1.17.0/dist/jquery.validate.min.js'
]
