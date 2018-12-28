Class {
	#name : #ERContainerAddTicket,
	#superclass : #ERGeneralContainerView,
	#instVars : [
		'ticket'
	],
	#category : #'ESUGApp-Components'
}

{ #category : #rendering }
ERContainerAddTicket >> addTicket [
]

{ #category : #rendering }
ERContainerAddTicket >> content: anObject [
	content := anObject
]

{ #category : #rendering }
ERContainerAddTicket >> initialize [
	super initialize .
	ticket := ERReductionTicket new.
]

{ #category : #rendering }
ERContainerAddTicket >> renderAcceptButton: html [
	self createColoredAnchorButton: 'Accept' with: [ self addTicket ] id: 'acceptAddTicket' on: html
	
]

{ #category : #rendering }
ERContainerAddTicket >> renderCancelButton: html [
	self createColoredAnchorButton: 'Cancel' with: [ self returnToThePreviousState ] id: 'cancelAddTicket' on: html
	
]

{ #category : #rendering }
ERContainerAddTicket >> renderFormOn: html [
	html div class: 'mdl-js-ripple-effect'; with: [ 
		self createTextField: 'Id:' for: #ticketId: with: #ticketId on: html.
		self createStrongText: 'Discount Strategy' to: html. 
		"for Fix Discount"
		self createSelectField: 'Strategy' for: #discountStrategy: with: #discountStrategy list: ERDiscountStrategy typesDiscount on: html.
		self createTextField: 'Amount' for: #amount: with: #amount on: html.
		self createSelectField: 'Currency' for: #currency: with: #currency list: ERAttendee currencyTypes on: html.
		"for percentage Discount"
		self createSelectField: 'Strategy' for: #discountStrategy: with: #discountStrategy list: ERDiscountStrategy typesDiscount on: html.
		self createTextField: 'Percentage' for: #percentage: with: #percentage on: html.
		self createStrongText: 'Use Limit Strategy' to: html.
		"For strategy limited use"
		self createSelectField: 'Strategy' for: #limitStrategy: with: #limitStrategy list: ERLimitStrategy typeLimit on: html.
		self createTextField: 'Limit' for: #limit: with: #limit on: html.
		"For strategy unlimit"
		self createSelectField: 'Strategy' for: #limitStrategy: with: #limitStrategy list: ERLimitStrategy typeLimit on: html.
		 ]
]

{ #category : #rendering }
ERContainerAddTicket >> renderPageOn: html [
	self renderFormOn: html.
	
]

{ #category : #accessing }
ERContainerAddTicket >> title [
	^ 'Reduction Tickets'
]
