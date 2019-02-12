Class {
	#name : #ERTestBankInformation,
	#superclass : #ERTestModel,
	#category : #'ESUGApp-Test'
}

{ #category : #tests }
ERTestBankInformation >> testEmptyAddressStringField [
	| bankInfo |
	bankInfo := (self class testBankinfo) addressString: nil; yourself .
	self assertEmptyField: bankInfo
]

{ #category : #tests }
ERTestBankInformation >> testEmptyBicField [
	| bankInfo |
	bankInfo := (self class testBankinfo) bic: nil; yourself .
	self assertEmptyField: bankInfo
]

{ #category : #tests }
ERTestBankInformation >> testEmptyCodeField [
	| bankInfo |
	bankInfo := (self class testBankinfo) code: nil; yourself .
	self assertEmptyField: bankInfo
]

{ #category : #tests }
ERTestBankInformation >> testEmptyCounterCodeField [
	| bankInfo |
	bankInfo := (self class testBankinfo) counterCode: nil; yourself .
	self assertEmptyField: bankInfo
]

{ #category : #tests }
ERTestBankInformation >> testEmptyNameField [
	| bankInfo |
	bankInfo := (self class testBankinfo) name: nil; yourself .
	self assertEmptyField: bankInfo
]
