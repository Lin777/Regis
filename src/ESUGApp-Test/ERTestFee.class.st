Class {
	#name : #ERTestFee,
	#superclass : #ERTestModel,
	#category : #'ESUGApp-Test'
}

{ #category : #tests }
ERTestFee >> testEmptyBankPayPalUrlField [
	| errors fee |
	fee := (self class testFee) bankPayPalUrl: nil; yourself .
	errors := fee asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: messageInputRequired equals: (errors at:1) messageText
]

{ #category : #tests }
ERTestFee >> testEmptyErfAllDaysFeeField [
	| errors fee |
	fee := (self class testFee) erfAllDaysFee: nil; yourself .
	errors := fee asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: messageInputRequired equals: (errors at:1) messageText
]

{ #category : #tests }
ERTestFee >> testEmptyErfOneDayFeeField [
	| errors fee |
	fee := (self class testFee) erfOneDayFee: nil; yourself .
	errors := fee asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: messageInputRequired equals: (errors at:1) messageText
]

{ #category : #tests }
ERTestFee >> testEmptyExtraPersonSDField [
	| errors fee |
	fee := (self class testFee) extraPersonSD: nil; yourself .
	errors := fee asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: messageInputRequired equals: (errors at:1) messageText
]

{ #category : #tests }
ERTestFee >> testEmptyLrfAllDaysFeeField [
	| errors fee |
	fee := (self class testFee) lrfAllDaysFee: nil; yourself .
	errors := fee asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: messageInputRequired equals: (errors at:1) messageText
]

{ #category : #tests }
ERTestFee >> testEmptyLrfOneDayFeeField [
	| errors fee |
	fee := (self class testFee) lrfOneDayFee: nil; yourself .
	errors := fee asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: messageInputRequired equals: (errors at:1) messageText
]

{ #category : #tests }
ERTestFee >> testEmptyPaymentCurrencyField [
	| errors fee |
	fee := (self class testFee) currency: nil; yourself .
	errors := fee asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: messageInputRequired equals: (errors at:1) messageText
]

{ #category : #tests }
ERTestFee >> testNonNumericErfAllDaysFeeField [
	| errors fee |
	fee := (self class testFee) erfAllDaysFee: 'NonNumeric'; yourself .
	errors := fee asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: self messageInvalidInput equals: (errors at:1) messageText
]

{ #category : #tests }
ERTestFee >> testNonNumericErfOneDayFeeField [
	| errors fee |
	fee := (self class testFee) erfOneDayFee: 'NonNumeric'; yourself .
	errors := fee asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: self messageInvalidInput equals: (errors at:1) messageText
]

{ #category : #tests }
ERTestFee >> testNonNumericLrfAllDaysFee [
	| errors fee |
	fee := (self class testFee) lrfAllDaysFee: 'NonNumeric'; yourself .
	errors := fee asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: self messageInvalidInput equals: (errors at:1) messageText
]

{ #category : #tests }
ERTestFee >> testNonNumericLrfOneDayFee [
	| errors fee |
	fee := (self class testFee) lrfOneDayFee: 'NonNumeric'; yourself .
	errors := fee asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: self messageInvalidInput equals: (errors at:1) messageText
]
