Class {
	#name : #ERContainerFormTicket,
	#superclass : #ERGeneralContainerView,
	#instVars : [
		'ticket'
	],
	#category : #'ESUGApp-Components'
}

{ #category : #rendering }
ERContainerFormTicket >> addTicket [
]

{ #category : #rendering }
ERContainerFormTicket >> content: anObject [
	content := anObject
]

{ #category : #rendering }
ERContainerFormTicket >> initialize [
	super initialize .
	ticket := ERReductionTicket new.
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
			html anchor
				
				with: [ "self createStrongText: 'Use Limit Strategy' to: html."
					"For strategy limited use"
					"self
				createSelectField: 'Strategy'
				for: #limitStrategy:
				with: #limitStrategy
				list: ERLimitStrategy
				to: ticket
				on: html.
			self
				createTextField: 'Limit'
				for: #limit:
				with: #limit
				to: ticket
				on: html."
					"For strategy unlimit"
					"self
				createSelectField: 'Strategy'
				for: #limitStrategy:
				with: #limitStrategy
				list: ERLimitStrategy
				to: ticket
				on: html "
					self
						createSelectField: 'Strategy'
						list: ERDiscountStrategy typesDiscount
						callback: [ Transcript show: 'dfsasdgf' ]
						withId: 'selectStrategy'
						on: html ] ].
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
				on: html ]
]

{ #category : #rendering }
ERContainerFormTicket >> renderPageOn: html [
	self renderFormOn: html.
	
]

{ #category : #accessing }
ERContainerFormTicket >> title [
	^ 'Reduction Tickets'
]
