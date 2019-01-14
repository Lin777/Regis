Class {
	#name : #ERReductionTicketForm,
	#superclass : #ERTittledView,
	#instVars : [
		'ticket',
		'messageComponent',
		'callback'
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

{ #category : #rendering }
ERReductionTicketForm >> addTicket [
]

{ #category : #accessing }
ERReductionTicketForm >> callback: anObject [
	callback := anObject
]

{ #category : #rendering }
ERReductionTicketForm >> changeDiscountStrategy: value [
	(ERDiscountStrategy isPercentageStrategy: value)
		ifTrue: [ ticket strategyIsPercentageDiscount ifFalse: [  ticket discountStrategy: ERPercentageDiscount new ]].
	(ERDiscountStrategy isFixStrategy: value)
		ifTrue: [ ticket strategyIsFixDiscount ifFalse: [ticket discountStrategy: ERFixDiscount new ]]
]

{ #category : #rendering }
ERReductionTicketForm >> changeLimitStrategy: value [
	(ERLimitStrategy isUnlimitStrategy: value)
		ifTrue: [ ticket limitStrategyIsUnlimited
				ifFalse: [ticket limitStrategy: ERUnlimitedReductionTicketUse new ]].
	(ERLimitStrategy isLimitStrategy: value)
		ifTrue: [ ticket limitStrategyIsLimited
				ifFalse: [ticket limitStrategy: ERLimitedReductionTicketUse new ]]
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
	messageComponent := ERAlert warningAlert
		id: 'formTicketAlert'.
	
]

{ #category : #rendering }
ERReductionTicketForm >> limitStrategy [
	^ ticket limitStrategyAsString
]

{ #category : #rendering }
ERReductionTicketForm >> renderAcceptButton: html [
	self
		createColoredAnchorButton: 'Accept'
		with: [ callback
				on: ERException
				do:
					[ :exception | messageComponent errorMessage: exception messageText ] ]
		id: 'acceptAddTicket'
		on: html
]

{ #category : #rendering }
ERReductionTicketForm >> renderAcceptCancelButtonsOn: html [
	self renderAcceptButton: html.
	self renderCancelButtonOn: html
]

{ #category : #rendering }
ERReductionTicketForm >> renderCancelButtonOn: html [
	self createColoredAnchorButton: 'Cancel' with: [ self returnToThePreviousState ] id: 'cancelAddTicket' on: html
	
]

{ #category : #rendering }
ERReductionTicketForm >> renderDiscountStrategyOn: html [
	self createStrongText: 'Discount Strategy' to: html.
	self
		createSelectField: 'Discount Strategy'
		list: (ERDiscountStrategy typesDiscount)
		callback: [ :value | self changeDiscountStrategy: value ]
		withId: 'selectStrategy'
		selected: self discountStrategy
		on: html.
	ticket strategyIsFixDiscount
		ifTrue: [ self renderFixStrategyOn: html ].
	ticket strategyIsPercentageDiscount
		ifTrue: [ self renderPercentageStrategyOn: html ]
]

{ #category : #rendering }
ERReductionTicketForm >> renderFixStrategyOn: html [
	self
				createTextField: 'Amount'
				for: #amount:
				with: #amount
				to: ticket discountStrategy
				on: html.
			self
				createSelectField: 'Currency'
				for: #currency:
				with: #currency
				list: ERAttendee currencyTypes
				to: ticket discountStrategy
				on: html
]

{ #category : #rendering }
ERReductionTicketForm >> renderFormOn: html [
	html div
		class: 'mdl-js-ripple-effect';
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
	self createStrongText: 'Use Limit Strategy' to: html.
	self
		createSelectField: 'Strategy'
		list: ERLimitStrategy typesLimitStrategy
		callback: [ :value | self changeLimitStrategy: value ]
		withId: 'selectLimitStrategy'
		selected: self limitStrategy
		on: html.
	ticket limitStrategyIsLimited
		ifTrue: [ self renderLimitedStrategyOn: html ].
	ticket limitStrategyIsUnlimited
		ifTrue: [ html paragraph: 'Is unlimited' ]
]

{ #category : #rendering }
ERReductionTicketForm >> renderLimitedStrategyOn: html [
	self
				createTextField: 'Limit'
				for: #limit:
				with: #limit
				to: ticket limitStrategy
				on: html 
]

{ #category : #rendering }
ERReductionTicketForm >> renderPageOn: html [
	html render: messageComponent .
	self renderFormOn: html
]

{ #category : #rendering }
ERReductionTicketForm >> renderPercentageStrategyOn: html [
	self
				createTextField: 'Percentage'
				for: #percentage:
				with: #percentage
				to: ticket discountStrategy
				on: html
]

{ #category : #rendering }
ERReductionTicketForm >> renderTicketIdOn: html [
	self
		createTextField: 'Id:'
		for: #ticketId:
		with: #ticketId
		to: ticket
		on: html.
]

{ #category : #accessing }
ERReductionTicketForm >> ticket: anObject [
	ticket := anObject
]

{ #category : #accessing }
ERReductionTicketForm >> title [
	^ 'Reduction Tickets'
]
