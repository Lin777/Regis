"
Description
--------------------

A ERTestBankAccountInformation is a test class for testing the behavior of ERBankAccountInformation model
"
Class {
	#name : #ERBankAccountInformationTest,
	#superclass : #ERModelTest,
	#category : #'ESUGApp-Tests-UnitTest'
}

{ #category : #tests }
ERBankAccountInformationTest >> testEmptyIbanField [
	| org |
	org := (self class testBankAccountInfo)
		iban: nil;
		yourself.
	self assertEmptyField: org
]

{ #category : #tests }
ERBankAccountInformationTest >> testEmptyNumberField [

	| org |
	org := (self class testBankAccountInfo)
		number: nil;
		yourself.
	self assertEmptyField: org
]

{ #category : #tests }
ERBankAccountInformationTest >> testEmptyOwnerField [

	| org |
	org := (self class testBankAccountInfo)
		owner: nil;
		yourself.
	self assertEmptyField: org
]
