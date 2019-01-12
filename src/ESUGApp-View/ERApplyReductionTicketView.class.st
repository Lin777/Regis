Class {
	#name : #ERApplyReductionTicketView,
	#superclass : #ERTittledView,
	#instVars : [
		'listOfTickets'
	],
	#category : #'ESUGApp-View'
}

{ #category : #accessing }
ERApplyReductionTicketView >> listOfTickets: anObject [
	listOfTickets := anObject
]

{ #category : #accessing }
ERApplyReductionTicketView >> renderPageOn: html [
	self
		createSelectField: 'Reduction Ticket Code: '
		for: #coupon:
		with: #coupon
		list: listOfTickets 
		to: attendee
		on: html
]

{ #category : #accessing }
ERApplyReductionTicketView >> title [
	^ 'Apply Reduction Ticket'
]
