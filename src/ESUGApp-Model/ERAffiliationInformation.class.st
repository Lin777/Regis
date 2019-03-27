Class {
	#name : #ERAffiliationInformation,
	#superclass : #Object,
	#instVars : [
		'organizationName',
		'organizationAddrees1',
		'organizationAddrees2',
		'organizationCity',
		'organizationCountry',
		'organizationProvince',
		'organizationPostal',
		'membershipType'
	],
	#category : #'ESUGApp-Model-Magritte'
}

{ #category : #'as yet unclassified' }
ERAffiliationInformation class >> membershipTypes [
	^ #('Industrial' 'Other' 'Academic')
]

{ #category : #'as yet unclassified' }
ERAffiliationInformation >> descriptionMembershipType [
	<magritteDescription>
	| tmp1 |
	tmp1 := MASingleOptionDescription new.
	tmp1
		accessor: #membershipType;
		priority: 80;
		required: false;
		options: self class membershipTypes;
		withoutLabel: true;
		id: 'membershipType';
		componentClass: MDLMASelectListComponent .
	^ tmp1 yourself
]

{ #category : #'as yet unclassified' }
ERAffiliationInformation >> descriptionOrganizationAddrees1 [
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
	^ tmp yourself
]

{ #category : #'as yet unclassified' }
ERAffiliationInformation >> descriptionOrganizationAddrees2 [
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
	^ tmp yourself
]

{ #category : #'as yet unclassified' }
ERAffiliationInformation >> descriptionOrganizationCity [
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
	^ tmp yourself
]

{ #category : #'as yet unclassified' }
ERAffiliationInformation >> descriptionOrganizationCountry [
	<magritteDescription>
	^ ERAward new descriptionCountry copy
              accessor: #organizationCountry;
				  priority: 50;
				  cssClass: 'half';
				  id: 'organizationCountry';
              yourself
]

{ #category : #'as yet unclassified' }
ERAffiliationInformation >> descriptionOrganizationName [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #organizationName; 
		priority: 10;
		beRequired;
		withoutLabel: true;
		label: 'Organization Name (Required)';
		id: 'organizationName';
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'as yet unclassified' }
ERAffiliationInformation >> descriptionOrganizationPostal [
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
	^ tmp yourself
]

{ #category : #'as yet unclassified' }
ERAffiliationInformation >> descriptionOrganizationProvince [
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
	^ tmp yourself
]

{ #category : #accessing }
ERAffiliationInformation >> membershipType [
	^ membershipType
]

{ #category : #accessing }
ERAffiliationInformation >> membershipType: anObject [
	membershipType := anObject
]

{ #category : #accessing }
ERAffiliationInformation >> organizationAddrees1 [
	^ organizationAddrees1
]

{ #category : #accessing }
ERAffiliationInformation >> organizationAddrees1: anObject [
	organizationAddrees1 := anObject
]

{ #category : #accessing }
ERAffiliationInformation >> organizationAddrees2 [
	^ organizationAddrees2
]

{ #category : #accessing }
ERAffiliationInformation >> organizationAddrees2: anObject [
	organizationAddrees2 := anObject
]

{ #category : #accessing }
ERAffiliationInformation >> organizationCity [
	^ organizationCity
]

{ #category : #accessing }
ERAffiliationInformation >> organizationCity: anObject [
	organizationCity := anObject
]

{ #category : #accessing }
ERAffiliationInformation >> organizationCountry [
	^ organizationCountry
]

{ #category : #accessing }
ERAffiliationInformation >> organizationCountry: anObject [
	organizationCountry := anObject
]

{ #category : #accessing }
ERAffiliationInformation >> organizationName [
	^ organizationName
]

{ #category : #accessing }
ERAffiliationInformation >> organizationName: anObject [
	organizationName := anObject
]

{ #category : #accessing }
ERAffiliationInformation >> organizationPostal [
	^ organizationPostal
]

{ #category : #accessing }
ERAffiliationInformation >> organizationPostal: anObject [
	organizationPostal := anObject
]

{ #category : #accessing }
ERAffiliationInformation >> organizationProvince [
	^ organizationProvince
]

{ #category : #accessing }
ERAffiliationInformation >> organizationProvince: anObject [
	organizationProvince := anObject
]
