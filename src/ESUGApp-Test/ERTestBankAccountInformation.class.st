"
Description
--------------------

A ERTestBankAccountInformation is a test class for testing the behavior of ERBankAccountInformation model
"
Class {
	#name : #ERTestBankAccountInformation,
	#superclass : #ERTestModel,
	#category : #'ESUGApp-Test-UnitTest'
}

{ #category : #tests }
ERTestBankAccountInformation >> testEmptyIbanField [
	| org |
	org := (self class testBankAccountInfo) iban: nil; yourself .
	self assertEmptyField: org
]

{ #category : #tests }
ERTestBankAccountInformation >> testEmptyNumberField [
	| org |
	org := (self class testBankAccountInfo) number: nil; yourself .
	self assertEmptyField: org
]

{ #category : #tests }
ERTestBankAccountInformation >> testEmptyOwnerField [
	| org |
	org := (self class testBankAccountInfo) owner: nil; yourself .
	self assertEmptyField: org
]
