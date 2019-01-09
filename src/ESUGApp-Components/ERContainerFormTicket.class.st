Class {
	#name : #ERContainerFormTicket,
	#superclass : #ERGeneralContainerView,
	#instVars : [
		'ticket'
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

{ #category : #rendering }
ERContainerFormTicket >> changeDiscountStrategy: value [
	(ERDiscountStrategy isPercentageStrategy: value)
		ifTrue: [ Transcript show: value.ticket discountStrategy: ERPercentageDiscount new ].
	(ERDiscountStrategy isFixStrategy: value)
		ifTrue: [ Transcript show: value.ticket discountStrategy: ERFixDiscount new ]
]

{ #category : #rendering }
ERContainerFormTicket >> content: anObject [
	content := anObject
]

{ #category : #rendering }
ERContainerFormTicket >> initialize [
	super initialize.
]

{ #category : #rendering }
ERContainerFormTicket >> renderAcceptButton: html [
	self createColoredAnchorButton: 'Accept' with: [ self addTicket ] id: 'acceptAddTicket' on: html
	
]

{ #category : #rendering }
ERContainerFormTicket >> renderCancelButton: html [
	self createColoredAnchorButton: 'Cancel' with: [ self returnToThePreviousState ] id: 'cancelAddTicket' on: html
	
]

{ #category : #rendering }
ERContainerFormTicket >> renderFormOn: html [
	html div
		class: 'mdl-js-ripple-effect';
		with: [ self
				createTextField: 'Id:'
				for: #ticketId:
				with: #ticketId
				to: ticket
				on: html.
			self createStrongText: 'Discount Strategy' to: html.
			html
				form: [ self
						createSelectField: 'Discount Strategy'
						list: (ERDiscountStrategy typesDiscount: html)
						callback: [ :value | self changeDiscountStrategy: value ]
						withId: 'selectStrategy'
						on: html ].
			ticket strategyIsFixDiscount
				ifTrue: [ self
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
						on: html ].
			ticket strategyIsPercentageDiscount
				ifTrue: [ self
						createTextField: 'Percentage'
						for: #percentage:
						with: #percentage
						to: ticket discountStrategy
						on: html ].
			self createStrongText: 'Use Limit Strategy' to: html.
			self
				createSelectField: 'Strategy'
				list: ERLimitStrategy typesLimitStrategy
				callback: [ Transcript show: 'Strategy Limit' ]
				withId: 'selectLimitStrategy'
				on: html.
			ticket limitStrategyIsLimited
				ifTrue: [ self
						createTextField: 'Limit'
						for: #limit:
						with: #limit
						to: ticket limitStrategy
						on: html ].
			ticket limitStrategyIsUnlimited
				ifTrue: [ html paragraph: 'Is unlimited' ] ]
]

{ #category : #rendering }
ERContainerFormTicket >> renderPageOn: html [
	self renderFormOn: html.
	
]

{ #category : #accessing }
ERContainerFormTicket >> ticket: anObject [
	ticket := anObject
]

{ #category : #accessing }
ERContainerFormTicket >> title [
	^ 'Reduction Tickets'
]
