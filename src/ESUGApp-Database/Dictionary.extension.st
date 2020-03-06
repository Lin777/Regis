Extension { #name : #Dictionary }

{ #category : #'*ESUGApp-Database' }
Dictionary >> resolveReferencesVisits: visitedParts [

	super resolveReferencesVisits: visitedParts.
	self rehash.
	^ self
]
