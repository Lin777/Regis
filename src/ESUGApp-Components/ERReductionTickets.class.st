Class {
	#name : #ERReductionTickets,
	#superclass : #ERConfiguration,
	#instVars : [
		'formAddTicket'
	],
	#category : #'ESUGApp-Components'
}

{ #category : #rendering }
ERReductionTickets >> addTicket [
	
]

{ #category : #rendering }
ERReductionTickets >> initializeFormAddFee [
	formAddTicket := (ERContainerAddTicket on: attendee withContent: content)
]

{ #category : #rendering }
ERReductionTickets >> renderContainer: html [
	self
		createColoredAnchorButton: 'Add'
		with: [ self addTicket ]
		id: 'addTicket'
		on: html.
	html horizontalRule .
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
