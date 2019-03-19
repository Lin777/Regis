Extension { #name : #MAContainerComponent }

{ #category : #'*ESUGApp-Extensions' }
MAContainerComponent >> save [
	self validate ifFalse: [^ ERException new signal  ].
	self commit; answer: self model
]
