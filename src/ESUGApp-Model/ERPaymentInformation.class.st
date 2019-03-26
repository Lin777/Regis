Class {
	#name : #ERPaymentInformation,
	#superclass : #Object,
	#instVars : [
		'paymentType',
		'paymentCurrency',
		'coupon',
		'invoiceNumber',
		'paymentAmount',
		'hasPaid'
	],
	#category : #'ESUGApp-Model-Magritte'
}

{ #category : #accessing }
ERPaymentInformation >> coupon [
	^ coupon
]

{ #category : #accessing }
ERPaymentInformation >> coupon: anObject [
	coupon := anObject
]

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
ERPaymentInformation >> descriptionPaymentCurrency [
	<magritteDescription>
	| tmp1 |
	tmp1 := MASingleOptionDescription new.
	tmp1
		accessor: #paymentCurrency;
		priority: 30;
		required: false;
		options: ERAttendee currencyTypes;
		withoutLabel: true;
		id: 'paymentCurrency';
		componentClass: MDLMASelectListComponent .
	^ tmp1 yourself
]

{ #category : #'as yet unclassified' }
ERPaymentInformation >> descriptionPaymentType [
	<magritteDescription>
	| tmp1 |
	tmp1 := MASingleOptionDescription new.
	tmp1
		accessor: #paymentType;
		priority: 10;
		required: false;
		options: ERAttendee paymentTypes;
		withoutLabel: true;
		id: 'paymentType';
		componentClass: MDLMASelectListComponent .
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

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
ERPaymentInformation >> paymentTypeIsBankTransfer [
	^ 'Bank transfer' = paymentType
]

{ #category : #'as yet unclassified' }
ERPaymentInformation >> paymentTypeIsCreditCard [
	^  'Credit Card' = paymentType
]

{ #category : #'as yet unclassified' }
ERPaymentInformation >> swapPaymentType [
	self paymentTypeIsBankTransfer ifTrue: [ ^ paymentType := 'Credit Card' ].
	self paymentTypeIsCreditCard ifTrue: [ ^ paymentType := 'Bank transfer' ]
]
