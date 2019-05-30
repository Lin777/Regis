"
Description
--------------------

I am a model of Payment Information
"
Class {
	#name : #ERPaymentInformation,
	#superclass : #Object,
	#instVars : [
		'paymentType',
		'paymentCurrency',
		'coupon',
		'invoiceNumber',
		'paymentAmount',
		'hasPaid',
		'readOnly'
	],
	#category : #'ESUGApp-Model-Magritte'
}

{ #category : #'as yet unclassified' }
ERPaymentInformation class >> currencyTypes [
	^ #('Euro')
]

{ #category : #'as yet unclassified' }
ERPaymentInformation class >> paymentTypes [
	^ #('Bank transfer' 'Credit Card')
]

{ #category : #accessing }
ERPaymentInformation >> coupon [
	^ coupon
]

{ #category : #accessing }
ERPaymentInformation >> coupon: anObject [
	coupon := anObject
]

{ #category : #'magrittes-descriptions' }
ERPaymentInformation >> descriptionCoupon [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #coupon; 
		priority: 20;
		required: false;
		addCondition: [ :value | ERController new conference
			existReductionTicketWithName: value]
		labelled: 'There is no ticket with the ticket id provided.';
		label: 'Reduction Ticket Code';
		withoutLabel: true;
		id: 'coupon';
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'magrittes-descriptions' }
ERPaymentInformation >> descriptionPaymentCurrency [
	<magritteDescription>
	| tmp1 |
	tmp1 := MASingleOptionDescription new.
	tmp1
		accessor: #paymentCurrency;
		priority: 30;
		required: true;
		options: self class currencyTypes;
		withoutLabel: true;
		id: 'paymentCurrency';
		componentClass: MDLMASelectListComponent .
	self readOnly ifTrue: [ tmp1 beDisabled ].
	^ tmp1 yourself
]

{ #category : #'magrittes-descriptions' }
ERPaymentInformation >> descriptionPaymentType [
	<magritteDescription>
	| tmp1 |
	tmp1 := MASingleOptionDescription new.
	tmp1
		accessor: #paymentType;
		priority: 10;
		required: true;
		options: self class paymentTypes;
		withoutLabel: true;
		id: 'paymentType';
		componentClass: MDLMASelectListComponent .
	self readOnly ifTrue: [ tmp1 beDisabled ].
	^ tmp1 yourself
]

{ #category : #accessing }
ERPaymentInformation >> hasPaid [
	^ hasPaid 
]

{ #category : #accessing }
ERPaymentInformation >> hasPaid: anObject [
	hasPaid := anObject
]

{ #category : #initialization }
ERPaymentInformation >> initialize [
	super initialize.
	hasPaid := false.
	paymentType := 'Bank transfer'.
	paymentCurrency := 'Euro'.
	paymentAmount := 0
]

{ #category : #accessing }
ERPaymentInformation >> invoiceNumber [
	^ invoiceNumber
]

{ #category : #accessing }
ERPaymentInformation >> invoiceNumber: anObject [
	invoiceNumber := anObject
]

{ #category : #action }
ERPaymentInformation >> invoiceNumberIfNone: aBlock [
	invoiceNumber ifNil: [ invoiceNumber := aBlock value ].
	^ invoiceNumber
]

{ #category : #accessing }
ERPaymentInformation >> paymentAmount [
	^ paymentAmount
]

{ #category : #accessing }
ERPaymentInformation >> paymentAmount: anObject [
	paymentAmount := anObject
]

{ #category : #accessing }
ERPaymentInformation >> paymentCurrency [
	^ paymentCurrency
]

{ #category : #accessing }
ERPaymentInformation >> paymentCurrency: anObject [
	paymentCurrency := anObject
]

{ #category : #accessing }
ERPaymentInformation >> paymentType [
	^ paymentType
]

{ #category : #accessing }
ERPaymentInformation >> paymentType: anObject [
	paymentType := anObject
]

{ #category : #accessing }
ERPaymentInformation >> paymentTypeIsBankTransfer [
	^ 'Bank transfer' = paymentType
]

{ #category : #accessing }
ERPaymentInformation >> paymentTypeIsCreditCard [
	^  'Credit Card' = paymentType
]

{ #category : #accessing }
ERPaymentInformation >> readOnly [
	^ readOnly ifNil: [ false ]
]

{ #category : #accessing }
ERPaymentInformation >> readOnly: aBoolean [
	readOnly := aBoolean
]

{ #category : #accessing }
ERPaymentInformation >> swapPaymentType [
	self paymentTypeIsBankTransfer ifTrue: [ ^ paymentType := 'Credit Card' ].
	self paymentTypeIsCreditCard ifTrue: [ ^ paymentType := 'Bank transfer' ]
]
