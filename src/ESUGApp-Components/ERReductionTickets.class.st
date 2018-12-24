Class {
	#name : #ERReductionTickets,
	#superclass : #ERConfiguration,
	#category : #'ESUGApp-Components'
}

{ #category : #rendering }
ERReductionTickets >> renderContainer: html [
	html horizontalRule.
]

{ #category : #accessing }
ERReductionTickets >> tabId [
	^ 'tickets'
]

{ #category : #accessing }
ERReductionTickets >> tabName [
	^ 'Tickets'
]

{ #category : #accessing }
ERReductionTickets >> title [
	^ 'Reduction Tickets'
]
