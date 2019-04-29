"
Description
--------------------

I am a form for edit or create a reduction ticket.
"
Class {
	#name : #ERReductionTicketForm,
	#superclass : #ERTittledView,
	#instVars : [
		'ticket',
		'messageComponent',
		'callback',
		'dialog',
		'ticketForm',
		'discountStrategyForm',
		'limitStrategyForm'
	],
	#category : #'ESUGApp-Form'
}

{ #category : #'instance creation' }
ERReductionTicketForm class >> on: aTicket withContent: aContent [
	| form |
	form := self new.
	form ticket: aTicket.
	form content: aContent.
	form initializeForms.
	^ form
]

{ #category : #accessing }
ERReductionTicketForm >> callback: anObject [
	callback := anObject
]

{ #category : #actions }
ERReductionTicketForm >> cancel [
	ticket version = 0 ifFalse: [ticket := ticket abortChanges] .
	self initializeForms .
	self returnToThePreviousState
]

{ #category : #'change-strategy' }
ERReductionTicketForm >> changeDiscountStrategy: value [
	(ERDiscountStrategy isPercentageStrategy: value)
		ifTrue: [ ticket strategyIsPercentageDiscount ifFalse: 
			[  ticket discountStrategy: ERPercentageDiscount new.
			self initializeDiscountStrategyForm ]].
	(ERDiscountStrategy isFixStrategy: value)
		ifTrue: [ ticket strategyIsFixDiscount ifFalse: 
			[ticket discountStrategy: ERFixDiscount new.
			self initializeDiscountStrategyForm ]].
	
]

{ #category : #'change-strategy' }
ERReductionTicketForm >> changeLimitStrategy: value [
	(ERLimitStrategy isUnlimitStrategy: value)
		ifTrue: [ ticket limitStrategyIsUnlimited
				ifFalse: [ ticket limitStrategy: ERUnlimitedReductionTicketUse new.
					self initializeLimitStrategyForm  ] ].
	(ERLimitStrategy isLimitStrategy: value)
		ifTrue: [ ticket limitStrategyIsLimited
				ifFalse: [ ticket limitStrategy: ERLimitedReductionTicketUse new.
					self initializeLimitStrategyForm  ] ].
	
]

{ #category : #rendering }
ERReductionTicketForm >> children [
	^ OrderedCollection new
		add: dialog;
		add: messageComponent;
		add: ticketForm ;
		add: discountStrategyForm ;
		add: limitStrategyForm ;
		yourself
]

{ #category : #accessing }
ERReductionTicketForm >> content: anObject [
	content := anObject
]

{ #category : #accessing }
ERReductionTicketForm >> discountStrategy [
	^ ticket discountStrategyAsString
]

{ #category : #initialization }
ERReductionTicketForm >> initialize [
	super initialize.
	messageComponent := ERAlert warningAlert id: 'formTicketAlert'.
	dialog := ERDialog cancelDialog 
		idOpen: 'cancelAddTicket';
		okCallback: [ self cancel  ]
]

{ #category : #initialization }
ERReductionTicketForm >> initializeDiscountStrategyForm [
	discountStrategyForm := self createFormOf: ticket discountStrategy
]

{ #category : #initialization }
ERReductionTicketForm >> initializeForms [
	ticketForm := self createFormOf: ticket.
	self initializeDiscountStrategyForm. 
	self initializeLimitStrategyForm 
]

{ #category : #initialization }
ERReductionTicketForm >> initializeLimitStrategyForm [
	limitStrategyForm := self createFormOf: ticket limitStrategy
]

{ #category : #accessing }
ERReductionTicketForm >> limitStrategy [
	^ ticket limitStrategyAsString
]

{ #category : #rendering }
ERReductionTicketForm >> renderAcceptButton: html [
	html mdlButton
		colored;
		id: 'acceptAddTicket';
		callback: [ [ self saveForms.
				callback value]
				on: ERException
				do: [ :exception | messageComponent errorMessage: exception messageText ]];
		with: 'Accept'
]

{ #category : #rendering }
ERReductionTicketForm >> renderAcceptCancelButtonsOn: html [
	self renderCancelButtonOn: html.
	self renderAcceptButton: html
]

{ #category : #rendering }
ERReductionTicketForm >> renderCancelButtonOn: html [
	html mdlAnchorButton 
		openDialogWithId: 'cancelAddTicket'; 
		colored;
		with: 'Cancel'
]

{ #category : #rendering }
ERReductionTicketForm >> renderFormOn: html [
	html div
		with: [ html form
				method: 'post';
				id: 'formTicket';
				with: [ 
					html render: ticketForm .
					html paragraph: [ html strong: 'Discount Strategy'].
					self renderSelectDiscountStrategyOn: html.
					html render: discountStrategyForm .
					html paragraph: [ html strong: 'Use Limit Strategy'].
					self renderSelectLimitStrategyOn: html.
					html render: limitStrategyForm.
					self renderAcceptCancelButtonsOn: html ] ]
]

{ #category : #rendering }
ERReductionTicketForm >> renderPageOn: html [
	html render: messageComponent.
	self renderFormOn: html.
	html render: dialog
]

{ #category : #rendering }
ERReductionTicketForm >> renderSelectDiscountStrategyOn: html [
	html mdlTextFieldContainer
		style: 'display: block';
		floatingLabel;
		with: [ html mdlTextFieldLabel for: 'selectStrategy';
			 with: 'Discount Strategy'.
			html select
				onChange: 'submit()';
				class: 'mdl-textfield__input';
				id: 'selectStrategy';
				list: (ERDiscountStrategy typesDiscount);
				selected: self discountStrategy;
				callback: [ :value | self changeDiscountStrategy: value ] ].
]

{ #category : #rendering }
ERReductionTicketForm >> renderSelectLimitStrategyOn: html [
	html mdlTextFieldContainer
		floatingLabel;
		with: [ html mdlTextFieldLabel 
			for: 'selectLimitStrategy';
			with: 'Strategy'.
			html select
				onChange: 'submit()';
				class: 'mdl-textfield__input';
				selected: self limitStrategy;
				id: 'selectLimitStrategy';
				list: ERLimitStrategy typesLimitStrategy;
				callback: [ :value | self changeLimitStrategy: value ]. ]
]

{ #category : #actions }
ERReductionTicketForm >> saveForms [
	ticketForm save.
	discountStrategyForm save.
	limitStrategyForm save.
]

{ #category : #accessing }
ERReductionTicketForm >> ticket: anObject [
	ticket := anObject
]

{ #category : #accessing }
ERReductionTicketForm >> title [
	^ 'Reduction Tickets'
]
