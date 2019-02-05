Class {
	#name : #ERApplyReductionTicketView,
	#superclass : #ERTittledView,
	#instVars : [
		'listOfTickets',
		'updateTicketAttendee',
		'cancel',
		'messageComponent'
	],
	#category : #'ESUGApp-View'
}

{ #category : #actions }
ERApplyReductionTicketView >> cancel: aBlock [
	cancel := aBlock 
	
]

{ #category : #accessing }
ERApplyReductionTicketView >> content: anObject [
	content := anObject
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
	html mdlButton
		colored;
		id: 'accept-change-affiliation' ;
		callback: [ updateTicketAttendee
				on: ERException
				do: [ :exception | messageComponent errorMessage: exception messageText ] ];
		with: 'Accept'
]

{ #category : #rendering }
ERApplyReductionTicketView >> renderCancelButtonOn: html [
	html mdlAnchorButton
		colored;
		id: 'cancel-change-affiliation';
		callback: cancel;
		with: 'Cancel'
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
