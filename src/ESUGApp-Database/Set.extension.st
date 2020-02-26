Extension { #name : #Set }

{ #category : #'*ESUGApp-Database' }
Set >> deepCopyVisits: visitedParts [ 

	
]

{ #category : #'*ESUGApp-Database' }
Set >> resolveReferencesVisits: visitedParts [

	super sandstoneResolveReferencesVisits: visitedParts.
	self rehash.
	^ self
]
