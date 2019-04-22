"
Description
--------------------

A ERTestFee is a test class for testing the behavior of ERFee model
"
Class {
	#name : #ERTestFee,
	#superclass : #ERTestModel,
	#category : #'ESUGApp-Test-UnitTest'
}

{ #category : #tests }
ERTestFee >> testEmptyBankPayPalUrlField [
	| fee |
	fee := (self class testFee) bankPayPalUrl: nil; yourself .
	self assertEmptyField: fee
]

{ #category : #tests }
ERTestFee >> testEmptyErfAllDaysFeeField [
	| fee |
	fee := (self class testFee) erfAllDaysFee: nil; yourself .
	self assertEmptyField: fee
]

{ #category : #tests }
ERTestFee >> testEmptyErfOneDayFeeField [
	| fee |
	fee := (self class testFee) erfOneDayFee: nil; yourself .
	self assertEmptyField: fee
]

{ #category : #tests }
ERTestFee >> testEmptyExtraPersonSDField [
	| fee |
	fee := (self class testFee) extraPersonSD: nil; yourself .
	self assertEmptyField: fee
]

{ #category : #tests }
ERTestFee >> testEmptyLrfAllDaysFeeField [
	| fee |
	fee := (self class testFee) lrfAllDaysFee: nil; yourself .
	self assertEmptyField: fee
]

{ #category : #tests }
ERTestFee >> testEmptyLrfOneDayFeeField [
	| fee |
	fee := (self class testFee) lrfOneDayFee: nil; yourself .
	self assertEmptyField: fee
]

{ #category : #tests }
ERTestFee >> testEmptyPaymentCurrencyField [
	| fee |
	fee := (self class testFee) currency: nil; yourself .
	self assertEmptyField: fee
]

{ #category : #tests }
ERTestFee >> testNonNumericErfAllDaysFeeField [
	| fee |
	fee := (self class testFee) erfAllDaysFee: 'NonNumeric'; yourself .
	self assertNonValidField: fee 
]

{ #category : #tests }
ERTestFee >> testNonNumericErfOneDayFeeField [
	| fee |
	fee := (self class testFee) erfOneDayFee: 'NonNumeric'; yourself .
	self assertNonValidField: fee
]

{ #category : #tests }
ERTestFee >> testNonNumericLrfAllDaysFee [
	| fee |
	fee := (self class testFee) lrfAllDaysFee: 'NonNumeric'; yourself .
	self assertNonValidField: fee
]

{ #category : #tests }
ERTestFee >> testNonNumericLrfOneDayFee [
	| fee |
	fee := (self class testFee) lrfOneDayFee: 'NonNumeric'; yourself .
	self assertNonValidField: fee
]
