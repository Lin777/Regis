Class {
	#name : #ERApplyReductionTicketView,
	#superclass : #ERTittledView,
	#instVars : [
		'listOfTickets',
		'updateTicketAttendee',
		'messageComponent'
	],
	#category : #'ESUGApp-View'
}

{ #category : #actions }
ERApplyReductionTicketView >> cancel [
	self returnToThePreviousState
]

{ #category : #accessing }
ERApplyReductionTicketView >> initialize [
	super initialize.
	messageComponent := ERAlert warningAlert id: 'formTicketAlert'
]

{ #category : #accessing }
ERApplyReductionTicketView >> listOfTickets: anObject [
	listOfTickets := anObject
]

{ #category : #accessing }
ERApplyReductionTicketView >> renderAcceptButtonOn: html [	
	self
		createColoredButton: 'Accept'
		with: [ updateTicketAttendee
				on: ERException
				do: [ :exception | messageComponent errorMessage: exception messageText ] ]
		id: 'accept-change-affiliation'
		on: html
]

{ #category : #rendering }
ERApplyReductionTicketView >> renderCancelButtonOn: html [
	self
		createColoredAnchorButton: 'Cancel'
		with: [ self cancel ]
		id: 'cancel-change-affiliation'
		on: html
]

{ #category : #accessing }
ERApplyReductionTicketView >> renderPageOn: html [
	html render: messageComponent .
	html form
		method: 'post';
		id: 'formApplyTicket';
		with: [ self renderSelectorOfTickets: html.
			self renderAcceptButtonOn: html.
			self renderCancelButtonOn: html ]
]

{ #category : #accessing }
ERApplyReductionTicketView >> renderSelectorOfTickets: html [
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

{ #category : #accessing }
ERApplyReductionTicketView >> updateTicketAttendee: aBlock [
	updateTicketAttendee := aBlock 
	
]
