"
Description
--------------------

I am a model of Billing Information
"
Class {
	#name : #ERBillingInformation,
	#superclass : #Object,
	#instVars : [
		'organizationName',
		'organizationAddrees1',
		'organizationAddrees2',
		'organizationCity',
		'organizationCountry',
		'organizationProvince',
		'organizationPostal',
		'membershipType',
		'readOnly',
		'extraInformation'
	],
	#category : #'ESUGApp-Model-Magritte'
}

{ #category : #'as yet unclassified' }
ERBillingInformation class >> membershipTypes [
	^ #('Industrial' 'Other' 'Academic')
]

{ #category : #accessing }
ERBillingInformation >> descriptionExtraInformation [
	<magritteDescription>
	| tmp |
	tmp := MAMemoDescription new.
	tmp 
		accessor: #extraInformation;
		priority: 80;
		lineCount: 5;
		label: 'Extra Information';
		withoutLabel: true;
		id: 'extraInformation';
		componentClass: MDLMATextAreaComponent.
	^ tmp yourself
]

{ #category : #'magrittes-descriptions' }
ERBillingInformation >> descriptionMembershipType [
	<magritteDescription>
	| tmp1 |
	tmp1 := MASingleOptionDescription new.
	tmp1
		accessor: #membershipType;
		priority: 90;
		required: false;
		options: self class membershipTypes;
		withoutLabel: true;
		id: 'membershipType';
		componentClass: MDLMASelectListComponent .
	self readOnly ifTrue: [ tmp1 beDisabled ].
	^ tmp1 yourself
]

{ #category : #'magrittes-descriptions' }
ERBillingInformation >> descriptionOrganizationAddrees1 [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #organizationAddrees1; 
		priority: 20;
		beRequired;
		group: 'Address: ';
		label: 'Address 1 (Required)';
		withoutLabel: true;
		cssClass: 'half';
		id: 'organizationAddrees1';
		componentClass: MDLMATextInputComponent.
	self readOnly ifTrue: [ tmp beDisabled ].
	^ tmp yourself
]

{ #category : #'magrittes-descriptions' }
ERBillingInformation >> descriptionOrganizationAddrees2 [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #organizationAddrees2; 
		priority: 30;
		required: false;
		label: 'Address 2';
		withoutLabel: true;
		cssClass: 'half';
		id: 'organizationAddrees2';
		componentClass: MDLMATextInputComponent.
	self readOnly ifTrue:[ tmp beDisabled ].
	^ tmp yourself
]

{ #category : #'magrittes-descriptions' }
ERBillingInformation >> descriptionOrganizationCity [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #organizationCity; 
		priority: 40;
		beRequired;
		label: 'City (Required)';
		withoutLabel: true;
		cssClass: 'half';
		id: 'organizationCity';
		componentClass: MDLMATextInputComponent.
	self readOnly ifTrue: [ tmp beDisabled ].
	^ tmp yourself
]

{ #category : #'magrittes-descriptions' }
ERBillingInformation >> descriptionOrganizationCountry [
	<magritteDescription>
	| tmp |
	tmp := ERAward new descriptionCountry copy
         accessor: #organizationCountry;
		   beRequired;
			priority: 50;
			cssClass: 'half';
			label: 'Country (Required)';
		   id: 'organizationCountry'.
	self readOnly ifTrue: [ tmp beDisabled ].
   ^ tmp yourself
]

{ #category : #'magrittes-descriptions' }
ERBillingInformation >> descriptionOrganizationName [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #organizationName; 
		priority: 10;
		beRequired;
		withoutLabel: true;
		label: 'Name (Required)';
		id: 'organizationName';
		componentClass: MDLMATextInputComponent.
	self readOnly ifTrue: [ tmp beDisabled ].
	^ tmp yourself
]

{ #category : #'magrittes-descriptions' }
ERBillingInformation >> descriptionOrganizationPostal [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #organizationPostal; 
		priority: 70;
		beRequired;
		label: 'Postal/Zipcode (Required)';
		withoutLabel: true;
		cssClass: 'half';
		id: 'organizationPostal';
		componentClass: MDLMATextInputComponent.
	self readOnly ifTrue: [ tmp beDisabled ].
	^ tmp yourself
]

{ #category : #'magrittes-descriptions' }
ERBillingInformation >> descriptionOrganizationProvince [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #organizationProvince; 
		priority: 60;
		required: false;
		label: 'Province/State ';
		withoutLabel: true;
		cssClass: 'half';
		id: 'organizationProvince';
		componentClass: MDLMATextInputComponent.
	self readOnly ifTrue: [ tmp beDisabled ].
	^ tmp yourself
]

{ #category : #accessing }
ERBillingInformation >> extraInformation [
	^ extraInformation
]

{ #category : #accessing }
ERBillingInformation >> extraInformation: anObject [
	extraInformation := anObject
]

{ #category : #accessing }
ERBillingInformation >> membershipType [
	^ membershipType
]

{ #category : #accessing }
ERBillingInformation >> membershipType: anObject [
	membershipType := anObject
]

{ #category : #accessing }
ERBillingInformation >> organizationAddrees1 [
	^ organizationAddrees1
]

{ #category : #accessing }
ERBillingInformation >> organizationAddrees1: anObject [
	organizationAddrees1 := anObject
]

{ #category : #accessing }
ERBillingInformation >> organizationAddrees2 [
	^ organizationAddrees2
]

{ #category : #accessing }
ERBillingInformation >> organizationAddrees2: anObject [
	organizationAddrees2 := anObject
]

{ #category : #accessing }
ERBillingInformation >> organizationCity [
	^ organizationCity
]

{ #category : #accessing }
ERBillingInformation >> organizationCity: anObject [
	organizationCity := anObject
]

{ #category : #accessing }
ERBillingInformation >> organizationCountry [
	^ organizationCountry
]

{ #category : #accessing }
ERBillingInformation >> organizationCountry: anObject [
	organizationCountry := anObject
]

{ #category : #accessing }
ERBillingInformation >> organizationName [
	^ organizationName
]

{ #category : #accessing }
ERBillingInformation >> organizationName: anObject [
	organizationName := anObject
]

{ #category : #accessing }
ERBillingInformation >> organizationPostal [
	^ organizationPostal
]

{ #category : #accessing }
ERBillingInformation >> organizationPostal: anObject [
	organizationPostal := anObject
]

{ #category : #accessing }
ERBillingInformation >> organizationProvince [
	^ organizationProvince
]

{ #category : #accessing }
ERBillingInformation >> organizationProvince: anObject [
	organizationProvince := anObject
]

{ #category : #accessing }
ERBillingInformation >> readOnly [ 
	^ readOnly ifNil: [ false ]
]

{ #category : #accessing }
ERBillingInformation >> readOnly: aBoolean [
	readOnly := aBoolean
]
