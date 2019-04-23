Extension { #name : #MAContainerComponent }

{ #category : #'*ESUGApp-Extensions' }
MAContainerComponent >> save [
	"Extension to show an ERException when exist an error"
	self validate ifFalse: [^ ERException new signal  ].
	self commit; answer: self model
]
