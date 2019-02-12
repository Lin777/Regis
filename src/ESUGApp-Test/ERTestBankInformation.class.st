Class {
	#name : #ERTestBankInformation,
	#superclass : #ERTestModel,
	#category : #'ESUGApp-Test'
}

{ #category : #tests }
ERTestBankInformation >> testEmptyAddressStringField [
	| errors org |
	org := (self class testBankinfo) addressString: nil; yourself .
	errors := org asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: messageInputRequired equals: (errors at:1) messageText
]

{ #category : #tests }
ERTestBankInformation >> testEmptyBicField [
	| errors org |
	org := (self class testBankinfo) bic: nil; yourself .
	errors := org asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: messageInputRequired equals: (errors at:1) messageText
]

{ #category : #tests }
ERTestBankInformation >> testEmptyCodeField [
	| errors org |
	org := (self class testBankinfo) code: nil; yourself .
	errors := org asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: messageInputRequired equals: (errors at:1) messageText
]

{ #category : #tests }
ERTestBankInformation >> testEmptyCounterCodeField [
	| errors org |
	org := (self class testBankinfo) counterCode: nil; yourself .
	errors := org asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: messageInputRequired equals: (errors at:1) messageText
]

{ #category : #tests }
ERTestBankInformation >> testEmptyNameField [
	| errors org |
	org := (self class testBankinfo) name: nil; yourself .
	errors := org asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: messageInputRequired equals: (errors at:1) messageText
]
