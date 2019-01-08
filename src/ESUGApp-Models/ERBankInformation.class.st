Class {
	#name : #ERBankInformation,
	#superclass : #SDActiveRecord,
	#instVars : [
		'name',
		'code',
		'counterCode',
		'bic',
		'addressString'
	],
	#category : #'ESUGApp-Models'
}

{ #category : #accessing }
ERBankInformation >> addressString [
	^ addressString
]

{ #category : #accessing }
ERBankInformation >> addressString: anObject [
	addressString := anObject
]

{ #category : #accessing }
ERBankInformation >> bic [
	^ bic
]

{ #category : #accessing }
ERBankInformation >> bic: anObject [
	bic := anObject
]

{ #category : #accessing }
ERBankInformation >> code [
	^ code
]

{ #category : #accessing }
ERBankInformation >> code: anObject [
	code := anObject
]

{ #category : #accessing }
ERBankInformation >> counterCode [
	^ counterCode
]

{ #category : #accessing }
ERBankInformation >> counterCode: anObject [
	counterCode := anObject
]

{ #category : #accessing }
ERBankInformation >> name1 [
	^ name
]

{ #category : #accessing }
ERBankInformation >> name: anObject [
	name := anObject
]
