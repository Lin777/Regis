"
Description
--------------------

A ERTestPaymentInformation is a test class for testing the behavior of ERPaymentInformation model
"
Class {
	#name : #ERPaymentInformationTest,
	#superclass : #ERModelTest,
	#category : #'ESUGApp-Tests-UnitTest'
}

{ #category : #tests }
ERPaymentInformationTest >> testNonValidOptionPaymentCurrencyField [

	| paymentInfo |
	paymentInfo := (self class testPaymentInformation) paymentCurrency: 'Non.Valid.Option'; yourself.
	self assertNonValidField: paymentInfo
]

{ #category : #tests }
ERPaymentInformationTest >> testNonValidOptionPaymentTypeField [

	| paymentInfo |
	paymentInfo := (self class testPaymentInformation) paymentType: 'Non.Valid.Option'; yourself.
	self assertNonValidField: paymentInfo
]

{ #category : #tests }
ERPaymentInformationTest >> testNonValidTicketIdCouponField [

	| errors paymentInfo |
	paymentInfo := (self class testPaymentInformation) coupon: 'InvalidCoupon'; yourself.
	errors := paymentInfo asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: 'There is no ticket with the ticket id provided.'
		 equals: ((errors at:1) collection at:1) messageText
]

{ #category : #tests }
ERPaymentInformationTest >> testValidTicketIdCouponField [

	| errors paymentInfo |
	paymentInfo := (self class testPaymentInformation) 
	coupon: self validCoupon ticketId; yourself.
	errors := paymentInfo asComponent validate; errors.
	self assert: 0 equals: errors size.
]
