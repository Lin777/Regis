Class {
	#name : #ERApplyReductionTicketView,
	#superclass : #ERTittledView,
	#instVars : [
		'ticketSelected',
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
ERApplyReductionTicketView >> children [ 	
	^ Array with: messageComponent
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
		callback: [ [ updateTicketAttendee cull: ticketSelected ]
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
	html mdlTextFieldContainer
		floatingLabel;
		with: [ html mdlTextFieldLabel with: 'Reduction Ticket Code: '.
			html select
				class: 'mdl-textfield__input';
				id: 'selectTickets';
				list: listOfTickets;
				selected: attendee paymentInformation coupon;
				callback: [ :value | self ticketSelected: value asString ] ].
]

{ #category : #accessing }
ERApplyReductionTicketView >> ticketSelected: aString [
	ticketSelected := aString 
	
]

{ #category : #accessing }
ERApplyReductionTicketView >> title [
	^ 'Apply Reduction Ticket'
]

{ #category : #accessing }
ERApplyReductionTicketView >> updateTicketAttendee: aBlock [
	updateTicketAttendee := aBlock 
	
]
