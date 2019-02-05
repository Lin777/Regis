Extension { #name : #MAContainerComponent }

{ #category : #'*ESUGApp-MDLMagritte' }
MAContainerComponent >> save [
	self validate ifFalse: [ ERException new signal  ].
	self commit; answer: self model
]
