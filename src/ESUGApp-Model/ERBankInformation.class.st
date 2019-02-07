Class {
	#name : #ERBankInformation,
	#superclass : #Object,
	#instVars : [
		'name',
		'code',
		'counterCode',
		'bic',
		'addressString'
	],
	#category : #'ESUGApp-Model'
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

{ #category : #'acessing-magritte' }
ERBankInformation >> descriptionAddressString [
	<magritteDescription>
	| tmp |
	tmp := MAMemoDescription new.
	tmp 
		accessor: #addressString; 
		priority: 50;
		beRequired;
		lineCount: 5;
		label: 'AddressString (Required)';
		withoutLabel: true;
		componentClass: MDLMATextAreaComponent.
	^ tmp yourself
]

{ #category : #'acessing-magritte' }
ERBankInformation >> descriptionBic [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #bic; 
		priority: 40;
		beRequired;
		label: 'BIC (Required)';
		withoutLabel: true;
		cssClass: 'half';
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'acessing-magritte' }
ERBankInformation >> descriptionCode [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #code; 
		priority: 20;
		beRequired ;
		label: 'Code (Required)';
		withoutLabel: true;
		cssClass: 'half';
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'acessing-magritte' }
ERBankInformation >> descriptionCounterCode [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #counterCode; 
		priority: 30;
		beRequired ;
		label: 'Counter code (Required)';
		withoutLabel: true;
		cssClass: 'half';
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'acessing-magritte' }
ERBankInformation >> descriptionName [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #name; 
		priority: 10;
		beRequired;
		label: 'Name (Required)';
		withoutLabel: true;
		cssClass: 'half';
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #accessing }
ERBankInformation >> name [
	^ name
]

{ #category : #accessing }
ERBankInformation >> name: anObject [
	name := anObject
]
