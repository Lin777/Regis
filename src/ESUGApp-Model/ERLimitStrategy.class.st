"
Description
--------------------

I am a model of Limit strategy
"
Class {
	#name : #ERLimitStrategy,
	#superclass : #Object,
	#category : #'ESUGApp-Model'
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
