Class {
	#name : #ERReductionTickets,
	#superclass : #ERConfiguration,
	#instVars : [
		'formAddTicket',
		'ticket'
	],
	#category : #'ESUGApp-Components'
}

{ #category : #rendering }
ERReductionTickets >> actionModifyTicket: aReductionTicket [
	controller modifyTicket: aReductionTicket 
]

{ #category : #rendering }
ERReductionTickets >> addTicket [
	self initializeFormAddTicket.
	content state: formAddTicket
]

{ #category : #rendering }
ERReductionTickets >> addTicketToConference [
	controller addTicket: ticket
]

{ #category : #rendering }
ERReductionTickets >> blockTableToExecute [
	^ [ :ticket | 
	OrderedCollection new
		add: ([ :att | att ticketId ] value: ticket);
		add: ([ :att | att discountStrategy description ] value: ticket );
		add: ([ :att | att limitStrategy description ] value: ticket );
		add: '0';
		yourself ]
]

{ #category : #rendering }
ERReductionTickets >> deleteTicket: ticket [
	controller deleteReductionTicket: ticket 
]

{ #category : #accessing }
ERReductionTickets >> headers [ 	
	^ #('Id'	'Discount Strategy'	'Use Limit Strategy'	'Used Times' '')
]

{ #category : #rendering }
ERReductionTickets >> initializeFormAddTicket [
	ticket := ERReductionTicket new.
	formAddTicket := (ERContainerFormTicket on: ticket withContent: content).
	formAddTicket callback: [ self addTicketToConference ]
]

{ #category : #rendering }
ERReductionTickets >> initializeFormModifyTicket: aReductionTicket [
	formAddTicket := ERContainerFormTicket
		on: aReductionTicket
		withContent: content.
	formAddTicket callback: [ self actionModifyTicket: aReductionTicket  ]
]

{ #category : #rendering }
ERReductionTickets >> listDataToRenderButton [
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
ERReductionTickets >> modifyTicket: aReductionTicket [
	self initializeFormModifyTicket: aReductionTicket.
	
	content state: formAddTicket
]

{ #category : #rendering }
ERReductionTickets >> renderContainer: html [
	self
		createColoredAnchorButton: 'Add'
		with: [ self addTicket ]
		id: 'addTicket'
		on: html.
	html horizontalRule.
	self renderTableOfTickets: html
]

{ #category : #rendering }
ERReductionTickets >> renderTableOfTickets: html [
	| table |
	table := ERTableGenericData new
		headers: self headers;
		levelTotal: 6;
		listObject: self tickets;
		blockToExecute: self blockTableToExecute;
		listToRenderButton: self listDataToRenderButton.
	html render: table
]

{ #category : #accessing }
ERReductionTickets >> tabId [
	^ 'tickets'
]

{ #category : #accessing }
ERReductionTickets >> tabName [
	^ 'Tickets'
]

{ #category : #rendering }
ERReductionTickets >> tickets [
	^ controller reductionTickets
]

{ #category : #accessing }
ERReductionTickets >> title [
	^ 'Reduction Tickets'
]
