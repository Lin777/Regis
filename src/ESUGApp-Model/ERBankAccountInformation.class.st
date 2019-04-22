"
Description
--------------------

I am a model of Bank Account information
"
Class {
	#name : #ERBankAccountInformation,
	#superclass : #Object,
	#instVars : [
		'owner',
		'iban',
		'ribKey',
		'bankInformation',
		'number'
	],
	#category : #'ESUGApp-Model'
}

{ #category : #accessing }
ERBankAccountInformation >> bankInformation [
	^ bankInformation
]

{ #category : #accessing }
ERBankAccountInformation >> bankInformation: anObject [
	bankInformation := anObject
]

{ #category : #'magrittes-descriptions' }
ERBankAccountInformation >> descriptionIban [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #iban; 
		priority: 30;
		beRequired;
		label: 'Iban (Required)';
		withoutLabel: true;
		cssClass: 'half';
		id: 'iban';
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'magrittes-descriptions' }
ERBankAccountInformation >> descriptionNumber [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #number; 
		priority: 20;
		beRequired ;
		label: 'Number (Required)';
		withoutLabel: true;
		cssClass: 'half';
		id: 'number';
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'magrittes-descriptions' }
ERBankAccountInformation >> descriptionOwner [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #owner; 
		priority: 10;
		beRequired;
		label: 'Owner (Required)';
		withoutLabel: true;
		cssClass: 'half';
		id: 'owner';
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'magrittes-descriptions' }
ERBankAccountInformation >> descriptionRibKey [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #ribKey; 
		priority: 40;
		beRequired;
		label: 'Rib Key (Required)';
		withoutLabel: true;
		cssClass: 'half';
		id: 'ribKey';
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #accessing }
ERBankAccountInformation >> iban [
	^ iban
]

{ #category : #accessing }
ERBankAccountInformation >> iban: anObject [
	iban := anObject
]

{ #category : #initialization }
ERBankAccountInformation >> initialize [
	super initialize.
	bankInformation := ERBankInformation new.
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
