Extension { #name : #MADescription }

{ #category : #'*ESUGApp-Extensions' }
MADescription >> withoutLabel [
	^ self propertyAt: #withoutLabel 
	ifAbsent: [ false ]
]

{ #category : #'*ESUGApp-Extensions' }
MADescription >> withoutLabel: aBoolean [
	self propertyAt: #withoutLabel put: aBoolean
]
