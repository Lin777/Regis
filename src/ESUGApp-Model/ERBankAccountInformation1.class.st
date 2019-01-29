Class {
	#name : #ERBankAccountInformation1,
	#superclass : #Object,
	#instVars : [
		'owner',
		'number',
		'iban',
		'ribKey',
		'bankInformation'
	],
	#category : #'ESUGApp-Model-Magritte'
}

{ #category : #accessing }
ERBankAccountInformation1 >> bankInformation [
	^ bankInformation
]

{ #category : #accessing }
ERBankAccountInformation1 >> bankInformation: anObject [
	bankInformation := anObject
]

{ #category : #'as yet unclassified' }
ERBankAccountInformation1 >> descriptionIban [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #iban; 
		priority: 30;
		required: false;
		label: 'IBAN';
		withoutLabel: true;
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'as yet unclassified' }
ERBankAccountInformation1 >> descriptionNumber [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #number; 
		priority: 20;
		required: false;
		withoutLabel: true;
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'as yet unclassified' }
ERBankAccountInformation1 >> descriptionOwner [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #owner; 
		priority: 10;
		required: false;
		withoutLabel: true;
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'as yet unclassified' }
ERBankAccountInformation1 >> descriptionRibKey [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #ribKey; 
		priority: 40;
		required: false;
		withoutLabel: true;
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #accessing }
ERBankAccountInformation1 >> iban [
	^ iban
]

{ #category : #accessing }
ERBankAccountInformation1 >> iban: anObject [
	iban := anObject
]

{ #category : #accessing }
ERBankAccountInformation1 >> number [
	^ number
]

{ #category : #accessing }
ERBankAccountInformation1 >> number: anObject [
	number := anObject
]

{ #category : #accessing }
ERBankAccountInformation1 >> owner [
	^ owner
]

{ #category : #accessing }
ERBankAccountInformation1 >> owner: anObject [
	owner := anObject
]

{ #category : #accessing }
ERBankAccountInformation1 >> ribKey [
	^ ribKey
]

{ #category : #accessing }
ERBankAccountInformation1 >> ribKey: anObject [
	ribKey := anObject
]
