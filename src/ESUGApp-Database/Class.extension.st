Extension { #name : #Class }

{ #category : #'*ESUGApp-Database' }
Class >> deepCopyVisits: visitedParts [ 

	ESUGDatabaseCommitError signal: 'An ActiveRecord can not reference a class or another object that references a class. '
]
