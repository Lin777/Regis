Extension { #name : #MADescriptionComponent }

{ #category : #'*ESUGApp-Extensions' }
MADescriptionComponent >> ajaxId [
	^ self magritteDescription id
]

{ #category : #'*ESUGApp-Extensions' }
MADescriptionComponent >> ajaxId: aString [
	|result|
	result := self magritteDescription id .
	result ifNil: [ result := super ajaxId: 'label' ].
	^ result
]
