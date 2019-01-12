Class {
	#name : #ERContainerFormTicket,
	#superclass : #ERGeneralContainerView,
	#instVars : [
		'ticket',
		'messageComponent',
		'callback'
	],
	#category : #'ESUGApp-Components'
}

{ #category : #'as yet unclassified' }
ERContainerFormTicket class >> on: aTicket withContent: aContent [
	| form |
	form := self new.
	form ticket: aTicket.
	form content: aContent.
	^ form
]

{ #category : #rendering }
ERContainerFormTicket >> addTicket [
]

{ #category : #accessing }
ERContainerFormTicket >> callback: anObject [
	callback := anObject
]

{ #category : #rendering }
ERContainerFormTicket >> changeDiscountStrategy: value [
	(ERDiscountStrategy isPercentageStrategy: value)
		ifTrue: [ ticket discountStrategy: ERPercentageDiscount new ].
	(ERDiscountStrategy isFixStrategy: value)
		ifTrue: [ ticket discountStrategy: ERFixDiscount new ]
]

{ #category : #rendering }
ERContainerFormTicket >> changeLimitStrategy: value [
	(ERLimitStrategy isUnlimitStrategy: value)
		ifTrue: [ ticket limitStrategy: ERUnlimitedReductionTicketUse new ].
	(ERLimitStrategy isLimitStrategy: value)
		ifTrue: [ ticket limitStrategy: ERLimitedReductionTicketUse new ].
	
]

{ #category : #rendering }
ERContainerFormTicket >> content: anObject [
	content := anObject
]

{ #category : #rendering }
ERContainerFormTicket >> discountStrategy [
	^ ticket discountStrategyAsString
]

{ #category : #rendering }
ERContainerFormTicket >> initialize [
	super initialize.
	messageComponent := ERComponentAlert warningAlert
		id: 'formTicketAlert'.
	
]

{ #category : #rendering }
ERContainerFormTicket >> limitStrategy [
	^ ticket limitStrategyAsString
]

{ #category : #rendering }
ERContainerFormTicket >> renderAcceptButton: html [
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
ERContainerFormTicket >> renderAcceptCancelButtonsOn: html [
	self renderAcceptButton: html.
	self renderCancelButtonOn: html
]

{ #category : #rendering }
ERContainerFormTicket >> renderCancelButtonOn: html [
	self createColoredAnchorButton: 'Cancel' with: [ self returnToThePreviousState ] id: 'cancelAddTicket' on: html
	
]

{ #category : #rendering }
ERContainerFormTicket >> renderDiscountStrategyOn: html [
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
ERContainerFormTicket >> renderFixStrategyOn: html [
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
ERContainerFormTicket >> renderFormOn: html [
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
ERContainerFormTicket >> renderLimitStrategyOn: html [
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
ERContainerFormTicket >> renderLimitedStrategyOn: html [
	self
				createTextField: 'Limit'
				for: #limit:
				with: #limit
				to: ticket limitStrategy
				on: html 
]

{ #category : #rendering }
ERContainerFormTicket >> renderPageOn: html [
	html render: messageComponent .
	self renderFormOn: html
]

{ #category : #rendering }
ERContainerFormTicket >> renderPercentageStrategyOn: html [
	self
				createTextField: 'Percentage'
				for: #percentage:
				with: #percentage
				to: ticket discountStrategy
				on: html
]

{ #category : #rendering }
ERContainerFormTicket >> renderTicketIdOn: html [
	self
		createTextField: 'Id:'
		for: #ticketId:
		with: #ticketId
		to: ticket
		on: html.
]

{ #category : #accessing }
ERContainerFormTicket >> ticket: anObject [
	ticket := anObject
]

{ #category : #accessing }
ERContainerFormTicket >> title [
	^ 'Reduction Tickets'
]
