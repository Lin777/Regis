Extension { #name : #WAHtmlCanvas }

{ #category : #'*ESUGApp-Views' }
WAHtmlCanvas >> icon [
	"Defines an icon element."

	^ self tag: 'i'
]

{ #category : #'*ESUGApp-Views' }
WAHtmlCanvas >> main [
	"Defines a section in a document."

	^ self tag: 'main'
]
