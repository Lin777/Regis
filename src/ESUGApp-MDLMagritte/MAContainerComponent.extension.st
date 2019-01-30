Extension { #name : #MAContainerComponent }

{ #category : #'*ESUGApp-MDLMagritte' }
MAContainerComponent >> save [
	self validate ifFalse: [ "^ self"ERException new signal  ].
	self commit; answer: self model
]
