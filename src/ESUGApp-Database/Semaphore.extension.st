Extension { #name : #Semaphore }

{ #category : #'*ESUGApp-Database' }
Semaphore >> deepCopyVisits: visitedParts [ 

	ESUGDatabaseCommitError signal: 'An ActiveRecord can not reference a semaphore or another object that references a semaphore.'
]
