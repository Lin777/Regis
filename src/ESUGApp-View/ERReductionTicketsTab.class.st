"
Description
--------------------

Tab to render all Reduction tickets of ESUG page in a table.
"
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

{ #category : #adding }
ERReductionTicketsTab >> addTicket [
	self initializeFormAddTicket.
	content state: formAddTicket.
	self updateStateTab: self tabName.
]

{ #category : #adding }
ERReductionTicketsTab >> addTicketToConference [
	controller addReductionTicketToConference: ticket.
	self returnToThePreviousState.
	self updateStateTab: self tabName.

]

{ #category : #tableBlock }
ERReductionTicketsTab >> blockTableToExecute [
	^ [ :anTicket | 
	OrderedCollection new
		add: ([ :att | att ticketId ] value: anTicket);
		add: ([ :att | att discountStrategy description ] value: anTicket);
		add: ([ :att | att limitStrategy description ] value: anTicket);
		add: ([ :att | (self listOfAttendees: att)size ] value: anTicket);
		yourself ]
]

{ #category : #rendering }
ERReductionTicketsTab >> children [
	^ super children asOrderedCollection copyWithAll: (OrderedCollection new
		add: messageComponent;
		yourself) yourself 
]

{ #category : #rendering }
ERReductionTicketsTab >> deleteTicket: aTicket [
	[controller deleteReductionTicket: aTicket]
	on: ERException 
	do: [ :exception | 
			messageComponent errorMessage: exception messageText ].
	self updateStateTab: self tabName. 
]

{ #category : #accessing }
ERReductionTicketsTab >> filterTicketInformation [

	^ [ :object :text | 
		((object ticketId) includesSubstring: text caseSensitive: false)
			or: [ ((object discountStrategy description) includesSubstring: text caseSensitive: false)
			or: [ ((object limitStrategy description) includesSubstring: text caseSensitive: false) ] ] ]
]

{ #category : #accessing }
ERReductionTicketsTab >> headers [ 	
	^ {'Id' .	'Discount Strategy' .	'Use Limit Strategy'	. 'Used Times' . PSTableSortableHeaderOptions new cell: ''}
]

{ #category : #initialization }
ERReductionTicketsTab >> initializeFormAddTicket [
	ticket := ERReductionTicket new.
	formAddTicket := (ERReductionTicketForm on: ticket withContent: content).
	formAddTicket callback: [ self addTicketToConference ].
]

{ #category : #initialization }
ERReductionTicketsTab >> initializeFormModifyTicket: aReductionTicket [
	formAddTicket := ERReductionTicketForm
		on: aReductionTicket
		withContent: content.
	formAddTicket callback: [ self actionModifyTicket: aReductionTicket ]
]

{ #category : #tableBlock }
ERReductionTicketsTab >> listDataToRenderButton [
	^ OrderedCollection new
		add:
			(Array
				with: 'edit'
				with: [ :anTicket | self modifyTicket: anTicket ]
				with: [ :anTicket | anTicket id , '-modify' ]
				with: 'Modify'
				with: ''
				with: false);
		add:
			(Array
				with: 'delete'
				with: [ :anTicket | self deleteTicket: anTicket ]
				with: [ :anTicket | anTicket id , '-delete' ]
				with: 'Delete'
				with: 'return confirm(''Are you sure you want to delete this item?'');'
				with: false);
		add:
			(Array
				with: 'list'
				with: [ :anTicket | self listOfTicket: anTicket ]
				with: [ :anTicket | anTicket id , '-list' ]
				with: 'List of Assistants'
				with: ''
				with: false);
		yourself
]

{ #category : #accessing }
ERReductionTicketsTab >> listOfAttendees: aTicket [
	^ controller conference attendeesForATicket: aTicket ticketId
]

{ #category : #rendering }
ERReductionTicketsTab >> listOfTicket: anTicket [
	| list |
	list := (ERAttendeesOfTicketView on: anTicket withContent: content)
		cancelCallback: [ 
			self returnToThePreviousState. 
			self updateStateTab: self tabName ].
	content state: list.
	self updateStateTab: self tabName.
]

{ #category : #updating }
ERReductionTicketsTab >> modifyTicket: aReductionTicket [
	self initializeFormModifyTicket: aReductionTicket.
	content state: formAddTicket.
	self updateStateTab: self tabName
]

{ #category : #rendering }
ERReductionTicketsTab >> renderContainerOn: html [
	html mdlAnchorButton
		colored;
		id: 'addTicket';
		callback: [ self addTicket ];
		with: 'Add'.
	html horizontalRule.
	html render: messageComponent .
	self renderTableOfTicketsOn: html
]

{ #category : #rendering }
ERReductionTicketsTab >> renderTableOfTicketsOn: html [
	table := ERTable new
		tableId: 'tickets-table';
		limitPageShowed: 3;
		header: self headers;
		validation: self filterTicketInformation;
		levelTotal: 6;
		rows: self tickets;
		blockToExecute: self blockTableToExecute;
		listToRenderButton: self listDataToRenderButton;
		sortingMethod: self sortingMethodTickets.
	html render: table
]

{ #category : #accessing }
ERReductionTicketsTab >> sortingMethodTickets [
	^ { [ :att | att ticketId ] 
		. [ :att | att discountStrategy description]
		. [ :att | att limitStrategy description ]
		. [ :att | (self listOfAttendees: att)size ] }
]

{ #category : #accessing }
ERReductionTicketsTab >> tabId [
	^ 'tickets'
]

{ #category : #accessing }
ERReductionTicketsTab >> tabName [
	^ 'Tickets'
]

{ #category : #accessing }
ERReductionTicketsTab >> tickets [
	^ controller conference reductionTickets
]

{ #category : #accessing }
ERReductionTicketsTab >> title [
	^ 'Reduction Tickets'
]
