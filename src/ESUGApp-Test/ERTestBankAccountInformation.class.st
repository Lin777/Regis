Class {
	#name : #ERTestBankAccountInformation,
	#superclass : #ERTestModel,
	#category : #'ESUGApp-Test'
}

{ #category : #tests }
ERTestBankAccountInformation >> testEmptyIbanField [
	| errors org |
	org := (self class testBankAccountInfo) iban: nil; yourself .
	errors := org asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: messageInputRequired equals: (errors at:1) messageText
]

{ #category : #tests }
ERTestBankAccountInformation >> testEmptyNumberField [
	| errors org |
	org := (self class testBankAccountInfo) number: nil; yourself .
	errors := org asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: messageInputRequired equals: (errors at:1) messageText
]

{ #category : #tests }
ERTestBankAccountInformation >> testEmptyOwnerField [
	| errors org |
	org := (self class testBankAccountInfo) owner: nil; yourself .
	errors := org asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: messageInputRequired equals: (errors at:1) messageText
]
