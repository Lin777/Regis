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
ERReductionTicket >> limitStrategy [
	^ limitStrategy
]

{ #category : #accessing }
ERReductionTicket >> limitStrategy: anObject [
	limitStrategy := anObject
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
