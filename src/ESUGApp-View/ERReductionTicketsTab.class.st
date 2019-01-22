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
	controller modifyTicket: aReductionTicket.

	self returnToThePreviousState.
	self updateStateTab: self tabName.
]

{ #category : #rendering }
ERReductionTicketsTab >> addTicket [
	self initializeFormAddTicket.
	content state: formAddTicket.
	self updateStateTab: self tabName.
]

{ #category : #rendering }
ERReductionTicketsTab >> addTicketToConference [
	controller addTicket: ticket.

	self returnToThePreviousState.
	self updateStateTab: self tabName.

]

{ #category : #rendering }
ERReductionTicketsTab >> blockTableToExecute [
	^ [ :anTicket | 
	OrderedCollection new
		add: ([ :att | att ticketId ] value: anTicket);
		add: ([ :att | att discountStrategy description ] value: anTicket );
		add: ([ :att | att limitStrategy description ] value: anTicket );
		add: ([:att | (self listOfAttendees: att)size] value: anTicket);
		yourself ]
]

{ #category : #rendering }
ERReductionTicketsTab >> deleteTicket: aTicket [
	controller deleteReductionTicket: aTicket.
	self updateStateTab: self tabName. 
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
				with: 'edit'
				with: [ :anTicket | self modifyTicket: anTicket ]
				with: [ :anTicket | anTicket id , '-modify' ]);
		add:
			(Array
				with: 'delete'
				with: [ :anTicket | self deleteTicket: anTicket ]
				with: [ :anTicket | anTicket id , '-delete' ]);
		add:
			(Array
				with: 'list'
				with: [ :anTicket | self listOfTicket: anTicket ]
				with: [ :anTicket | anTicket id , '-list' ]);
		yourself
]

{ #category : #accessing }
ERReductionTicketsTab >> listOfAttendees: aTicket [
	^ ERController new attendeesForATicket: aTicket ticketId
]

{ #category : #rendering }
ERReductionTicketsTab >> listOfTicket: anTicket [
	|list|
	list := (ERAttendeesOfTicket on: anTicket withContent: content ) cancelCallback: [ self returnToThePreviousState. 
			self updateStateTab: self tabName].
	content state: list.
	self updateStateTab: self tabName.
]

{ #category : #rendering }
ERReductionTicketsTab >> modifyTicket: aReductionTicket [
	self initializeFormModifyTicket: aReductionTicket.
	
	content state: formAddTicket.
	self updateStateTab: self tabName.
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
