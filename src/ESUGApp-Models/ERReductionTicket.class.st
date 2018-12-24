Class {
	#name : #ERReductionTicket,
	#superclass : #SDActiveRecord,
	#instVars : [
		'name',
		'currency',
		'percentage',
		'type',
		'limit'
	],
	#category : #'ESUGApp-Models'
}

{ #category : #accessing }
ERReductionTicket >> currency [
	^ currency
]

{ #category : #accessing }
ERReductionTicket >> currency: anObject [
	currency := anObject
]

{ #category : #accessing }
ERReductionTicket >> limit [
	^ limit
]

{ #category : #accessing }
ERReductionTicket >> limit: anObject [
	limit := anObject
]

{ #category : #accessing }
ERReductionTicket >> name1 [
	^ name
]

{ #category : #accessing }
ERReductionTicket >> name: anObject [
	name := anObject
]

{ #category : #accessing }
ERReductionTicket >> percentage [
	^ percentage
]

{ #category : #accessing }
ERReductionTicket >> percentage: anObject [
	percentage := anObject
]

{ #category : #accessing }
ERReductionTicket >> type [
	^ type
]

{ #category : #accessing }
ERReductionTicket >> type: anObject [
	type := anObject
]
