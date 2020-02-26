Extension { #name : #Dictionary }

{ #category : #'*ESUGApp-Database' }
Dictionary >> deepCopyVisits: visitedParts [ 

	
]

{ #category : #'*ESUGApp-Database' }
Dictionary >> resolveReferencesVisits: visitedParts [

	super sandstoneResolveReferencesVisits: visitedParts.
	self rehash.
	^ self
]
