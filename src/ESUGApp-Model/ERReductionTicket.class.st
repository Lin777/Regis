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

{ #category : #'as yet unclassified' }
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
		ifTrue: [ ^ amount - (amount * (discountStrategy percentage / 100))]
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
