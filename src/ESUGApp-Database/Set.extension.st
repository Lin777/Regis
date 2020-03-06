Extension { #name : #Set }

{ #category : #'*ESUGApp-Database' }
Set >> resolveReferencesVisits: visitedParts [

	super resolveReferencesVisits: visitedParts.
	self rehash.
	^ self
]
