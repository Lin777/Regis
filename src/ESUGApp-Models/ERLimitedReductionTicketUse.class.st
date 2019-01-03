Class {
	#name : #ERLimitedReductionTicketUse,
	#superclass : #ERLimitStrategy,
	#instVars : [
		'limit'
	],
	#category : #'ESUGApp-Models'
}

{ #category : #'instance creation' }
ERLimitedReductionTicketUse class >> of: aLimitNumber [
	^ self new limit: aLimitNumber ; yourself 
]

{ #category : #accessing }
ERLimitedReductionTicketUse >> limit [
	^ limit
]

{ #category : #accessing }
ERLimitedReductionTicketUse >> limit: anObject [
	limit := anObject
]
