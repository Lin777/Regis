Extension { #name : #String }

{ #category : #'*ESUGApp-Database' }
String >> deepCopyVisits: visitedParts [ 

	^ self shallowCopy
]

{ #category : #'*ESUGApp-Database' }
String >> markReferencesVisits: visitedParts [

	^ self
]
