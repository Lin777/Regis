Class {
	#name : #ERPaymentInformation,
	#superclass : #Object,
	#instVars : [
		'paymentType',
		'paymentCurrency',
		'coupon'
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
		label: 'Reduction Ticket Code';
		withoutLabel: true;
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
		default:'Euro';
		withoutLabel: true;
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
		default:'Bank transfer';
		withoutLabel: true;
		componentClass: MDLMASelectListComponent .
	^ tmp1 yourself
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
