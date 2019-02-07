Class {
	#name : #ERReductionTicketForm,
	#superclass : #ERTittledView,
	#instVars : [
		'ticket',
		'messageComponent',
		'callback',
		'dialog'
	],
	#category : #'ESUGApp-Form'
}

{ #category : #'as yet unclassified' }
ERReductionTicketForm class >> on: aTicket withContent: aContent [
	| form |
	form := self new.
	form ticket: aTicket.
	form content: aContent.
	^ form
]

{ #category : #accessing }
ERReductionTicketForm >> callback: anObject [
	callback := anObject
]

{ #category : #rendering }
ERReductionTicketForm >> changeDiscountStrategy: value [
	(ERDiscountStrategy isPercentageStrategy: value)
		ifTrue: [ ticket strategyIsPercentageDiscount ifFalse: 
			[  ticket discountStrategy: ERPercentageDiscount new ]].
	(ERDiscountStrategy isFixStrategy: value)
		ifTrue: [ ticket strategyIsFixDiscount ifFalse: 
			[ticket discountStrategy: ERFixDiscount new ]]
]

{ #category : #rendering }
ERReductionTicketForm >> changeLimitStrategy: value [
	(ERLimitStrategy isUnlimitStrategy: value)
		ifTrue: [ ticket limitStrategyIsUnlimited
				ifFalse: [ ticket limitStrategy: ERUnlimitedReductionTicketUse new ] ].
	(ERLimitStrategy isLimitStrategy: value)
		ifTrue: [ ticket limitStrategyIsLimited
				ifFalse: [ ticket limitStrategy: ERLimitedReductionTicketUse new ] ]
]

{ #category : #rendering }
ERReductionTicketForm >> children [
	^ OrderedCollection new
		add: dialog;
		add: messageComponent;
		yourself
]

{ #category : #rendering }
ERReductionTicketForm >> content: anObject [
	content := anObject
]

{ #category : #rendering }
ERReductionTicketForm >> discountStrategy [
	^ ticket discountStrategyAsString
]

{ #category : #rendering }
ERReductionTicketForm >> initialize [
	super initialize.
	messageComponent := ERAlert warningAlert id: 'formTicketAlert'.
	dialog := ERDialog cancelDialog 
		idOpen: 'cancelAddTicket';
		okCallback: [ self returnToThePreviousState ]
]

{ #category : #rendering }
ERReductionTicketForm >> limitStrategy [
	^ ticket limitStrategyAsString
]

{ #category : #rendering }
ERReductionTicketForm >> renderAcceptButton: html [
	html mdlButton
		colored;
		id: 'acceptAddTicket' ;
		callback: [ callback
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
ERReductionTicketForm >> renderDiscountStrategyOn: html [
	html paragraph: [ html strong: 'Discount Strategy'].
	self renderSelectDiscountStrategyOn: html.
	ticket strategyIsFixDiscount
		ifTrue: [ self renderFixStrategyOn: html ].
	ticket strategyIsPercentageDiscount
		ifTrue: [ self renderPercentageStrategyOn: html ]
]

{ #category : #rendering }
ERReductionTicketForm >> renderFixStrategyOn: html [
	html mdlTextFieldContainer
		floatingLabel;
		with: [ html mdlTextFieldLabel
				with: 'Amount'.
			html mdlTextFieldInput
				id: 'amountToReduction';
				value: ticket discountStrategy amount;
				callback: [ :value | ticket strategyIsFixDiscount ifTrue:
					[ticket discountStrategy amount: value asString ]]].
	
	html mdlTextFieldContainer
		floatingLabel;
		with: [ html mdlTextFieldLabel 
			for: 'currencyOfTicket'; 
			with: 'Currency'.
			html select
				class: 'mdl-textfield__input';
				id: 'currencyOfTicket';
				list: ERAttendee currencyTypes;
				selected: ticket discountStrategy currency;
				callback: [ :value | ticket strategyIsFixDiscount ifTrue: 
					[ticket discountStrategy currency: value asString ] ]].
]

{ #category : #rendering }
ERReductionTicketForm >> renderFormOn: html [
	html div
		with: [ html form
				method: 'post';
				id: 'formTicket';
				with: [ self renderTicketIdOn: html.
					self renderDiscountStrategyOn: html.
					self renderLimitStrategyOn: html.
					self renderAcceptCancelButtonsOn: html ] ]
]

{ #category : #rendering }
ERReductionTicketForm >> renderLimitStrategyOn: html [
	html paragraph: [ html strong: 'Use Limit Strategy'].
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
				callback: [ :value | self changeLimitStrategy: value ]. ].
	ticket limitStrategyIsLimited
		ifTrue: [ self renderLimitedStrategyOn: html ].
	ticket limitStrategyIsUnlimited
		ifTrue: [ html paragraph: 'Is unlimited' ].
]

{ #category : #rendering }
ERReductionTicketForm >> renderLimitedStrategyOn: html [
	html mdlTextFieldContainer
		floatingLabel;
		with: [ html mdlTextFieldLabel
				for: 'limitOfReductionticket';
				with: 'Limit'.
			html mdlTextFieldInput
				id: 'limitOfReductionticket';
				value: ticket limitStrategy limit;
				callback: [ :value | ticket limitStrategyIsLimited ifTrue: 
					[ ticket limitStrategy limit: value asString ] ]]. 
]

{ #category : #rendering }
ERReductionTicketForm >> renderPageOn: html [
	html render: messageComponent.
	self renderFormOn: html.
	html render: dialog
]

{ #category : #rendering }
ERReductionTicketForm >> renderPercentageStrategyOn: html [
	html mdlTextFieldContainer
		floatingLabel;
		with: [ html mdlTextFieldLabel
				with: 'Percentage'.
			html mdlTextFieldInput
				id: 'percentageOfTicket';
				value: ticket discountStrategy percentage;
				callback: [ :value | 
					ticket strategyIsPercentageDiscount ifTrue: 
					[ticket discountStrategy percentage: value asString] ] ].
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
				callback: [ :value | self changeDiscountStrategy: value ]. ].
]

{ #category : #rendering }
ERReductionTicketForm >> renderTicketIdOn: html [
	html mdlTextFieldContainer
		style: 'display: block';
		floatingLabel;
		with: [ html mdlTextFieldLabel
				for: 'ticketId';
				with: 'Id:'.
			html mdlTextFieldInput
				id: 'ticketId';
				value: ticket ticketId;
				callback: [ :value | ticket ticketId: value asString ] ]
]

{ #category : #accessing }
ERReductionTicketForm >> ticket: anObject [
	ticket := anObject
]

{ #category : #accessing }
ERReductionTicketForm >> title [
	^ 'Reduction Tickets'
]
