Extension { #name : #MADescription }

{ #category : #'*ESUGApp-Extensions' }
MADescription >> beDisabled [
	self disabled: true
]

{ #category : #'*ESUGApp-Extensions' }
MADescription >> disabled [

	^ self propertyAt: #disabled ifAbsent: [ false ]
]

{ #category : #'*ESUGApp-Extensions' }
MADescription >> disabled: aBoolean [
	self propertyAt: #disabled put: aBoolean
]

{ #category : #'*ESUGApp-Extensions' }
MADescription >> id [
	^ self propertyAt: #id 
	ifAbsent: [ nil ]
]

{ #category : #'*ESUGApp-Extensions' }
MADescription >> id: aString [
	self propertyAt: #id put: aString
]

{ #category : #'*ESUGApp-Extensions' }
MADescription >> withoutLabel [
	^ self propertyAt: #withoutLabel 
	ifAbsent: [ false ]
]

{ #category : #'*ESUGApp-Extensions' }
MADescription >> withoutLabel: aBoolean [
	self propertyAt: #withoutLabel put: aBoolean
]
