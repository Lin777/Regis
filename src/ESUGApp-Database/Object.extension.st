Extension { #name : #Object }

{ #category : #'*ESUGApp-Database' }
Object >> deepCopyVisits: visitedParts [ 

	| newObject class index value |
	
	visitedParts at: self ifPresent: [ :it | ^ it ].
	class := self class.
	class isVariable 
		ifTrue: 
			[ index := self basicSize.
			newObject := class basicNew: index.
			[ index > 0 ] whileTrue: 
				[ newObject 
					basicAt: index
					put: ((self basicAt: index) deepCopyVisits: visitedParts).
				index := index - 1 ] ]
		ifFalse: [ newObject := class basicNew ].
	visitedParts at: self put: newObject.
	index := class instSize.
	[ index > 0 ] whileTrue: 
		[ value := self instVarAt: index.
		newObject 
			instVarAt: index
			put: (value isActiveRecord 
					ifTrue: [ value ]
					ifFalse: [ value deepCopyVisits: visitedParts ]).
		index := index - 1 ].
	^ newObject
]

{ #category : #'*ESUGApp-Database' }
Object >> markReferencesVisits: visitedParts [ 

	self class isMeta ifTrue: [ ^ self ].
	visitedParts at: self ifPresent: [:it | ^ it ].
	visitedParts at: self put: self.
	self class allInstVarNames do: 
		[ :name | 
		| var |
		var := self instVarNamed: name.
		var isActiveRecord 
			ifTrue: 
				[ self 
					instVarNamed: name
					put: var asReferenceMarker ]
			ifFalse: [ var markReferencesVisits: visitedParts ] ].
	^ self
]
