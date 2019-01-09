Class {
	#name : #ERReductionTicket,
	#superclass : #SDActiveRecord,
	#instVars : [
		'ticketId',
		'discountStrategy',
		'limitStrategy',
		'usersOfTickets'
	],
	#category : #'ESUGApp-Models'
}

{ #category : #accessing }
ERReductionTicket >> discountStrategy [
	^ discountStrategy
]

{ #category : #accessing }
ERReductionTicket >> discountStrategy: anObject [
	discountStrategy := anObject
]

{ #category : #accessing }
ERReductionTicket >> initialize [
	super initialize.
	usersOfTickets := OrderedCollection new.
	discountStrategy := ERPercentageDiscount new.
	limitStrategy := ERLimitedReductionTicketUse new
]

{ #category : #accessing }
ERReductionTicket >> limitStrategy [
	^ limitStrategy
]

{ #category : #accessing }
ERReductionTicket >> limitStrategy: anObject [
	limitStrategy := anObject
]

{ #category : #'as yet unclassified' }
ERReductionTicket >> limitStrategyIsLimited [
	^ limitStrategy isMemberOf: ERLimitedReductionTicketUse 
]

{ #category : #'as yet unclassified' }
ERReductionTicket >> limitStrategyIsUnlimited [
	^ limitStrategy isMemberOf: ERUnlimitedReductionTicketUse 
]

{ #category : #'as yet unclassified' }
ERReductionTicket >> strategyIsFixDiscount [
	^ discountStrategy isMemberOf: ERFixDiscount 
]

{ #category : #'as yet unclassified' }
ERReductionTicket >> strategyIsPercentageDiscount [
	^ discountStrategy isMemberOf: ERPercentageDiscount 
]

{ #category : #accessing }
ERReductionTicket >> ticketId [
	^ ticketId
]

{ #category : #accessing }
ERReductionTicket >> ticketId: anObject [
	ticketId := anObject
]

{ #category : #accessing }
ERReductionTicket >> usersOfTickets [
	^ usersOfTickets
]

{ #category : #accessing }
ERReductionTicket >> usersOfTickets: anObject [
	usersOfTickets := anObject
]
