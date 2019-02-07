Extension { #name : #MADescription }

{ #category : #'*ESUGApp-MDLMagritte' }
MADescription >> withoutLabel [
	^ self propertyAt: #withoutLabel 
	ifAbsent: [ false ]
]

{ #category : #'*ESUGApp-MDLMagritte' }
MADescription >> withoutLabel: aBoolean [
	self propertyAt: #withoutLabel put: aBoolean
]
