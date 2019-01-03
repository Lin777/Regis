Class {
	#name : #ERBankAccountInformation,
	#superclass : #SDActiveRecord,
	#instVars : [
		'owner',
		'iban',
		'ribKey',
		'bankInformation',
		'number'
	],
	#category : #'ESUGApp-Models'
}

{ #category : #accessing }
ERBankAccountInformation >> bankInformation [
	^ bankInformation
]

{ #category : #accessing }
ERBankAccountInformation >> bankInformation: anObject [
	bankInformation := anObject
]

{ #category : #accessing }
ERBankAccountInformation >> iban [
	^ iban
]

{ #category : #accessing }
ERBankAccountInformation >> iban: anObject [
	iban := anObject
]

{ #category : #accessing }
ERBankAccountInformation >> number [
	^ number
]

{ #category : #accessing }
ERBankAccountInformation >> number: anObject [
	number := anObject
]

{ #category : #accessing }
ERBankAccountInformation >> owner [
	^ owner
]

{ #category : #accessing }
ERBankAccountInformation >> owner: anObject [
	owner := anObject
]

{ #category : #accessing }
ERBankAccountInformation >> ribKey [
	^ ribKey
]

{ #category : #accessing }
ERBankAccountInformation >> ribKey: anObject [
	ribKey := anObject
]
