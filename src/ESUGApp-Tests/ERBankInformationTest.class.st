"
Description
--------------------

A ERTestBankInformation is a test class for testing the behavior of ERBankInformation model
"
Class {
	#name : #ERBankInformationTest,
	#superclass : #ERModelTest,
	#category : #'ESUGApp-Tests-UnitTest'
}

{ #category : #tests }
ERBankInformationTest >> testEmptyAddressStringField [

	| bankInfo |
	bankInfo := (self class testBankinfo) addressString: nil; yourself .
	self assertEmptyField: bankInfo
]

{ #category : #tests }
ERBankInformationTest >> testEmptyBicField [

	| bankInfo |
	bankInfo := (self class testBankinfo) bic: nil; yourself .
	self assertEmptyField: bankInfo
]

{ #category : #tests }
ERBankInformationTest >> testEmptyCodeField [

	| bankInfo |
	bankInfo := (self class testBankinfo) code: nil; yourself .
	self assertEmptyField: bankInfo
]

{ #category : #tests }
ERBankInformationTest >> testEmptyCounterCodeField [

	| bankInfo |
	bankInfo := (self class testBankinfo) counterCode: nil; yourself .
	self assertEmptyField: bankInfo
]

{ #category : #tests }
ERBankInformationTest >> testEmptyNameField [

	| bankInfo |
	bankInfo := (self class testBankinfo) name: nil; yourself .
	self assertEmptyField: bankInfo
]
