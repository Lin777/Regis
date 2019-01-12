Class {
	#name : #ERLimitStrategy,
	#superclass : #SDActiveRecord,
	#category : #'ESUGApp-Models'
}

{ #category : #testing }
ERLimitStrategy class >> isLimitStrategy: value [
	^ value = 'Limit Strategy'

]

{ #category : #testing }
ERLimitStrategy class >> isUnlimitStrategy: value [
	^ value = 'Unlimit strategy'
		
]

{ #category : #'as yet unclassified' }
ERLimitStrategy class >> typesLimitStrategy [
	^ #('Limit Strategy' 'Unlimit strategy')
]
