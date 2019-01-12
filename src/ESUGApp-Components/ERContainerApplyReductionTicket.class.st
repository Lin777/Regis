Class {
	#name : #ERContainerApplyReductionTicket,
	#superclass : #ERGeneralContainerView,
	#instVars : [
		'listOfTickets'
	],
	#category : #'ESUGApp-Components'
}

{ #category : #accessing }
ERContainerApplyReductionTicket >> listOfTickets: anObject [
	listOfTickets := anObject
]

{ #category : #accessing }
ERContainerApplyReductionTicket >> renderPageOn: html [
	self
		createSelectField: 'Reduction Ticket Code: '
		for: #coupon:
		with: #coupon
		list: listOfTickets 
		to: attendee
		on: html
]

{ #category : #accessing }
ERContainerApplyReductionTicket >> title [
	^ 'Apply Reduction Ticket'
]
