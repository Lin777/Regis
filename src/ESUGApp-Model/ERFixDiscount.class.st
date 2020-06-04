"
Description
--------------------

I am a model of fix discount
"
Class {
	#name : #ERFixDiscount,
	#superclass : #ERDiscountStrategy,
	#instVars : [
		'amount',
		'currency'
	],
	#category : #'ESUGApp-Model'
}

{ #category : #accessing }
ERFixDiscount >> amount [
	^ amount
]

{ #category : #accessing }
ERFixDiscount >> amount: anObject [
	amount := anObject
]

{ #category : #accessing }
ERFixDiscount >> currency [
	^ currency
]

{ #category : #accessing }
ERFixDiscount >> currency: anObject [
	currency := anObject
]

{ #category : #accessing }
ERFixDiscount >> description [ 
	^ 'Discount of ', amount asString , ' ', currency, '(s)'
]

{ #category : #'magrittes-descriptions' }
ERFixDiscount >> descriptionAmount [
	<magritteDescription>
	| tmp |
	tmp := MANumberDescription new.
	tmp 
		accessor: #amount; 
		priority: 30;
		required: true;
		addCondition: [ :value | value >= 0 ]
  		labelled: 'Need to be a positive number';
		withoutLabel: true;
		id: 'amount';
		label: 'Amount (Required)';
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'magrittes-descriptions' }
ERFixDiscount >> descriptionCurrency [
	<magritteDescription>
	| tmp1 |
	tmp1 := MASingleOptionDescription new.
	tmp1
		accessor: #currency;
		priority: 40;
		beRequired;
		options: ERPaymentInformation currencyTypes;
		withoutLabel: true;
		id: 'currency';
		componentClass: MDLMASelectListComponent .
	^ tmp1 yourself
]

{ #category : #initialization }
ERFixDiscount >> initialize [
	super initialize.
]
