Class {
	#name : #ERReductionTicket,
	#superclass : #SDActiveRecord,
	#instVars : [
		'ticketId',
		'discountStrategy',
		'limitStrategy',
		'usersOfTickets'
	],
	#category : #'ESUGApp-Model'
}

{ #category : #adding }
ERReductionTicket >> addAttendeeOfTicket: anAttendee [
	^ usersOfTickets add: anAttendee
]

{ #category : #adding }
ERReductionTicket >> addAttendeeOfTicketLimited: anAttendee [
	self usersOfTickets size < self limitStrategy limit
		ifTrue: [ ^ self addAttendeeOfTicket: anAttendee ]
		ifFalse: [ anAttendee coupon: ''.
			ERException new
				messageText: 'The ticket limit was exceeded, please use another ticket.';
				signal ]
]

{ #category : #accessing }
ERReductionTicket >> discountStrategy [
	^ discountStrategy
]

{ #category : #accessing }
ERReductionTicket >> discountStrategy: anObject [
	discountStrategy := anObject
]

{ #category : #'as yet unclassified' }
ERReductionTicket >> discountStrategyAsString [
	self strategyIsFixDiscount
		ifTrue: [ ^ 'Fix Discount' ].
	self strategyIsPercentageDiscount
		ifTrue: [ ^ 'Percentage Discount' ]
]

{ #category : #accessing }
ERReductionTicket >> initialize [
	super initialize.
	usersOfTickets := OrderedCollection new.
	discountStrategy := ERPercentageDiscount new.
	limitStrategy := ERLimitedReductionTicketUse new
]

{ #category : #accessing }
ERReductionTicket >> limitStrategy [
	^ limitStrategy
]

{ #category : #accessing }
ERReductionTicket >> limitStrategy: anObject [
	limitStrategy := anObject
]

{ #category : #'as yet unclassified' }
ERReductionTicket >> limitStrategyAsString [
	self limitStrategyIsLimited
		ifTrue: [ ^ 'Limit Strategy' ].
	self limitStrategyIsUnlimited
		ifTrue: [ ^ 'Unlimit strategy' ]
]

{ #category : #'as yet unclassified' }
ERReductionTicket >> limitStrategyIsLimited [
	^ limitStrategy isMemberOf: ERLimitedReductionTicketUse 
]

{ #category : #'as yet unclassified' }
ERReductionTicket >> limitStrategyIsUnlimited [
	^ limitStrategy isMemberOf: ERUnlimitedReductionTicketUse 
]

{ #category : #'as yet unclassified' }
ERReductionTicket >> obtainNewAmountAfterDiscountFor: amount [
	self strategyIsFixDiscount
		ifTrue: [ | amountWithDiscount |
			amountWithDiscount := amount - discountStrategy amount.
			^ self roundToZeroIfNegative: amountWithDiscount ].
	self strategyIsPercentageDiscount
		ifTrue: [ ^ amount - (amount * (discountStrategy percentage / 100)) ]
]

{ #category : #'as yet unclassified' }
ERReductionTicket >> roundToZeroIfNegative: amountWithDiscount [
	amountWithDiscount >= 0
		ifTrue: [ ^ amountWithDiscount ].
		 ^ 0 
]

{ #category : #'as yet unclassified' }
ERReductionTicket >> strategyIsFixDiscount [
	^ discountStrategy isMemberOf: ERFixDiscount 
]

{ #category : #'as yet unclassified' }
ERReductionTicket >> strategyIsPercentageDiscount [
	^ discountStrategy isMemberOf: ERPercentageDiscount 
]

{ #category : #accessing }
ERReductionTicket >> ticketId [
	^ ticketId
]

{ #category : #accessing }
ERReductionTicket >> ticketId: anObject [
	ticketId := anObject
]

{ #category : #accessing }
ERReductionTicket >> usersOfTickets [
	^ usersOfTickets
]

{ #category : #accessing }
ERReductionTicket >> usersOfTickets: anObject [
	usersOfTickets := anObject
]
