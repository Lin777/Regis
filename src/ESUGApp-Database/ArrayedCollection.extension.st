Extension { #name : #ArrayedCollection }

{ #category : #'*ESUGApp-Database' }
ArrayedCollection >> deepCopyVisits: visitedParts [ 

	| newObject |
	visitedParts at: self ifPresent: [ :it | ^ it ].
	newObject := self copy.
	visitedParts at: self put: newObject.
	newObject doWithIndex: 
		[ :each :index | 
		each isActiveRecord ifFalse: 
			[ newObject 
				at: index
				put: (each deepCopyVisits: visitedParts) ] ].
	^ newObject
]

{ #category : #'*ESUGApp-Database' }
ArrayedCollection >> markReferencesVisits: visitedParts [ 
	
	self class isMeta ifTrue: [ ^ self ].
	visitedParts at: self ifPresent: [:it | ^ self ].
	visitedParts at: self put: self.
	self doWithIndex: 
		[ :each :index | 
		each isActiveRecord 
			ifTrue: [ self at: index put: each asReferenceMarker ]
			ifFalse: [ each markReferencesVisits: visitedParts ] ].
	^ self
]

{ #category : #'*ESUGApp-Database' }
ArrayedCollection >> resolveReferencesVisits: visitedParts [ 

	self class isMeta ifTrue: [ ^ self ].
	visitedParts at: self ifPresent: [ :it | ^ it ].
	visitedParts at: self put: self.
	self copy doWithIndex: 
		[ :each :index | 
		each isMarker 
			ifTrue: [ self at: index put: each asOriginalObject ]
			ifFalse: [ each resolveReferencesVisits: visitedParts ] ].
	^ self
]
