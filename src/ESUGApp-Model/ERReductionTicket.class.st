"
Description
--------------------

I am a model of Reduction Ticket
"
Class {
	#name : #ERReductionTicket,
	#superclass : #SDActiveRecord,
	#instVars : [
		'ticketId',
		'discountStrategy',
		'limitStrategy'
	],
	#category : #'ESUGApp-Model'
}

{ #category : #'magrittes-descriptions' }
ERReductionTicket >> descriptionTicketId [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #ticketId; 
		priority: 10;
		required: true;
		label: 'Id (Required)';
		withoutLabel: true;
		id: 'ticketId';
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #accessing }
ERReductionTicket >> discountStrategy [
	^ discountStrategy
]

{ #category : #accessing }
ERReductionTicket >> discountStrategy: anObject [
	discountStrategy := anObject
]

{ #category : #action }
ERReductionTicket >> discountStrategyAsString [
	self strategyIsFixDiscount
		ifTrue: [ ^ 'Fix Discount' ].
	self strategyIsPercentageDiscount
		ifTrue: [ ^ 'Percentage Discount' ]
]

{ #category : #initialization }
ERReductionTicket >> initialize [
	super initialize.
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

{ #category : #action }
ERReductionTicket >> limitStrategyAsString [
	self limitStrategyIsLimited
		ifTrue: [ ^ 'Limit Strategy' ].
	self limitStrategyIsUnlimited
		ifTrue: [ ^ 'Unlimit strategy' ]
]

{ #category : #action }
ERReductionTicket >> limitStrategyIsLimited [
	^ limitStrategy isMemberOf: ERLimitedReductionTicketUse 
]

{ #category : #action }
ERReductionTicket >> limitStrategyIsUnlimited [
	^ limitStrategy isMemberOf: ERUnlimitedReductionTicketUse 
]

{ #category : #action }
ERReductionTicket >> obtainNewAmountAfterDiscountFor: amount [
	self strategyIsFixDiscount
		ifTrue: [ | amountWithDiscount |
			amountWithDiscount := amount - discountStrategy amount.
			^ self roundToZeroIfNegative: amountWithDiscount ].
	self strategyIsPercentageDiscount
		ifTrue: [ ^ amount - (amount * (discountStrategy percentage / 100.0))]
]

{ #category : #action }
ERReductionTicket >> roundToZeroIfNegative: amountWithDiscount [
	amountWithDiscount >= 0
		ifTrue: [ ^ amountWithDiscount ].
		 ^ 0 
]

{ #category : #action }
ERReductionTicket >> strategyIsFixDiscount [
	^ discountStrategy isMemberOf: ERFixDiscount 
]

{ #category : #action }
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
