"
Description
--------------------

A ERTestFee is a test class for testing the behavior of ERFee model
"
Class {
	#name : #ERFeeTest,
	#superclass : #ERModelTest,
	#category : #'ESUGApp-Tests-UnitTest'
}

{ #category : #tests }
ERFeeTest >> testEmptyBankPayPalUrlField [

	| fee |
	fee := (self class testFee) bankPayPalUrl: nil; yourself.
	self assertEmptyField: fee
]

{ #category : #tests }
ERFeeTest >> testEmptyErfAllDaysFeeField [

	| fee |
	fee := (self class testFee) erfAllDaysFee: nil; yourself.
	self assertEmptyField: fee
]

{ #category : #tests }
ERFeeTest >> testEmptyErfOneDayFeeField [

	| fee |
	fee := (self class testFee) erfOneDayFee: nil; yourself.
	self assertEmptyField: fee
]

{ #category : #tests }
ERFeeTest >> testEmptyExtraPersonSDField [

	| fee |
	fee := (self class testFee) extraPersonSD: nil; yourself.
	self assertEmptyField: fee
]

{ #category : #tests }
ERFeeTest >> testEmptyLrfAllDaysFeeField [

	| fee |
	fee := (self class testFee) lrfAllDaysFee: nil; yourself.
	self assertEmptyField: fee
]

{ #category : #tests }
ERFeeTest >> testEmptyLrfOneDayFeeField [

	| fee |
	fee := (self class testFee) lrfOneDayFee: nil; yourself.
	self assertEmptyField: fee
]

{ #category : #tests }
ERFeeTest >> testEmptyPaymentCurrencyField [

	| fee |
	fee := (self class testFee) currency: nil; yourself.
	self assertEmptyField: fee
]

{ #category : #tests }
ERFeeTest >> testNonNumericErfAllDaysFeeField [

	| fee |
	fee := (self class testFee) erfAllDaysFee: 'NonNumeric'; yourself.
	self assertNonValidField: fee 
]

{ #category : #tests }
ERFeeTest >> testNonNumericErfOneDayFeeField [

	| fee |
	fee := (self class testFee) erfOneDayFee: 'NonNumeric'; yourself.
	self assertNonValidField: fee
]

{ #category : #tests }
ERFeeTest >> testNonNumericLrfAllDaysFee [

	| fee |
	fee := (self class testFee) lrfAllDaysFee: 'NonNumeric'; yourself.
	self assertNonValidField: fee
]

{ #category : #tests }
ERFeeTest >> testNonNumericLrfOneDayFee [

	| fee |
	fee := (self class testFee) lrfOneDayFee: 'NonNumeric'; yourself.
	self assertNonValidField: fee
]
