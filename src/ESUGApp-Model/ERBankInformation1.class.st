Class {
	#name : #ERBankInformation1,
	#superclass : #Object,
	#instVars : [
		'name',
		'code',
		'counterCode',
		'bic',
		'addressString'
	],
	#category : #'ESUGApp-Model-Magritte'
}

{ #category : #accessing }
ERBankInformation1 >> addressString [
	^ addressString
]

{ #category : #accessing }
ERBankInformation1 >> addressString: anObject [
	addressString := anObject
]

{ #category : #accessing }
ERBankInformation1 >> bic [
	^ bic
]

{ #category : #accessing }
ERBankInformation1 >> bic: anObject [
	bic := anObject
]

{ #category : #accessing }
ERBankInformation1 >> code [
	^ code
]

{ #category : #accessing }
ERBankInformation1 >> code: anObject [
	code := anObject
]

{ #category : #accessing }
ERBankInformation1 >> counterCode [
	^ counterCode
]

{ #category : #accessing }
ERBankInformation1 >> counterCode: anObject [
	counterCode := anObject
]

{ #category : #'as yet unclassified' }
ERBankInformation1 >> descriptionAddressString [
	<magritteDescription>
	| tmp |
	tmp := MAMemoDescription new.
	tmp 
		accessor: #addressString; 
		priority: 40;
		required: false;
		lineCount: 5;
		withoutLabel: true;
		componentClass: MDLMATextAreaComponent.
	^ tmp yourself
]

{ #category : #'as yet unclassified' }
ERBankInformation1 >> descriptionBic [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #bic; 
		priority: 30;
		required: false;
		label: 'BIC';
		withoutLabel: true;
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'as yet unclassified' }
ERBankInformation1 >> descriptionCode [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #code; 
		priority: 20;
		required: false;
		withoutLabel: true;
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'as yet unclassified' }
ERBankInformation1 >> descriptionCounterCode [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #counterCode; 
		priority: 30;
		required: false;
		withoutLabel: true;
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'as yet unclassified' }
ERBankInformation1 >> descriptionName [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #name; 
		priority: 10;
		required: false;
		withoutLabel: true;
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #accessing }
ERBankInformation1 >> name [
	^ name
]

{ #category : #accessing }
ERBankInformation1 >> name: anObject [
	name := anObject
]
