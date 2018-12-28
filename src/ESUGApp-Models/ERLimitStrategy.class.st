Class {
	#name : #ERLimitStrategy,
	#superclass : #SDActiveRecord,
	#instVars : [
		'limit'
	],
	#category : #'ESUGApp-Models'
}

{ #category : #'as yet unclassified' }
ERLimitStrategy class >> typeLimit [
	^ #('Limited Use' 'Unlimited Use')
]

{ #category : #accessing }
ERLimitStrategy >> limit [
	^ limit
]

{ #category : #accessing }
ERLimitStrategy >> limit: anObject [
	limit := anObject
]
