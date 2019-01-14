Class {
	#name : #ERReductionTicketsTab,
	#superclass : #ERConfigurationTab,
	#instVars : [
		'formAddTicket',
		'ticket'
	],
	#category : #'ESUGApp-View-Tab'
}

{ #category : #rendering }
ERReductionTicketsTab >> actionModifyTicket: aReductionTicket [
	controller modifyTicket: aReductionTicket 
]

{ #category : #rendering }
ERReductionTicketsTab >> addTicket [
	self initializeFormAddTicket.
	content state: formAddTicket
]

{ #category : #rendering }
ERReductionTicketsTab >> addTicketToConference [
	controller addTicket: ticket
]

{ #category : #rendering }
ERReductionTicketsTab >> blockTableToExecute [
	^ [ :ticket | 
	OrderedCollection new
		add: ([ :att | att ticketId ] value: ticket);
		add: ([ :att | att discountStrategy description ] value: ticket );
		add: ([ :att | att limitStrategy description ] value: ticket );
		add: '0';
		yourself ]
]

{ #category : #rendering }
ERReductionTicketsTab >> deleteTicket: ticket [
	controller deleteReductionTicket: ticket 
]

{ #category : #accessing }
ERReductionTicketsTab >> headers [ 	
	^ #('Id'	'Discount Strategy'	'Use Limit Strategy'	'Used Times' '')
]

{ #category : #rendering }
ERReductionTicketsTab >> initializeFormAddTicket [
	ticket := ERReductionTicket new.
	formAddTicket := (ERReductionTicketForm on: ticket withContent: content).
	formAddTicket callback: [ self addTicketToConference ]
]

{ #category : #rendering }
ERReductionTicketsTab >> initializeFormModifyTicket: aReductionTicket [
	formAddTicket := ERReductionTicketForm
		on: aReductionTicket
		withContent: content.
	formAddTicket callback: [ self actionModifyTicket: aReductionTicket  ]
]

{ #category : #rendering }
ERReductionTicketsTab >> listDataToRenderButton [
	^ OrderedCollection new
		add:
			(Array
				with: 'Modify'
				with: [ :ticket | self modifyTicket: ticket ]
				with: [ :ticket | ticket id , '-modify' ]);
		add:
			(Array
				with: 'Delete'
				with: [ :ticket | self deleteTicket: ticket ]
				with: [ :ticket | ticket id , '-delete' ]);
		yourself
]

{ #category : #rendering }
ERReductionTicketsTab >> modifyTicket: aReductionTicket [
	self initializeFormModifyTicket: aReductionTicket.
	
	content state: formAddTicket
]

{ #category : #rendering }
ERReductionTicketsTab >> renderContainer: html [
	self
		createColoredAnchorButton: 'Add'
		with: [ self addTicket ]
		id: 'addTicket'
		on: html.
	html horizontalRule.
	self renderTableOfTickets: html
]

{ #category : #rendering }
ERReductionTicketsTab >> renderTableOfTickets: html [
	| table |
	table := ERTable new
		headers: self headers;
		levelTotal: 6;
		listObject: self tickets;
		blockToExecute: self blockTableToExecute;
		listToRenderButton: self listDataToRenderButton.
	html render: table
]

{ #category : #accessing }
ERReductionTicketsTab >> tabId [
	^ 'tickets'
]

{ #category : #accessing }
ERReductionTicketsTab >> tabName [
	^ 'Tickets'
]

{ #category : #rendering }
ERReductionTicketsTab >> tickets [
	^ controller reductionTickets
]

{ #category : #accessing }
ERReductionTicketsTab >> title [
	^ 'Reduction Tickets'
]
