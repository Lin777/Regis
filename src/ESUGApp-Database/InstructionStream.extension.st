Extension { #name : #InstructionStream }

{ #category : #'*ESUGApp-Database' }
InstructionStream >> deepCopyVisits: visitedParts [ 

		ESUGDatabaseCommitError signal: 'An ActiveRecord can not reference any sub instances of instruction stream.  Make sure you are not saving blocks.'
]
