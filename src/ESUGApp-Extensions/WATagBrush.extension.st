Extension { #name : #WATagBrush }

{ #category : #'*ESUGApp-Extensions' }
WATagBrush >> addAttributeAt: aKey if: aBlock [
	aBlock value ifTrue: [ self attributeAt: aKey put: 'true']
]
