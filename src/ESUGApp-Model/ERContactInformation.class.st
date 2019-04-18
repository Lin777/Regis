Class {
	#name : #ERContactInformation,
	#superclass : #Object,
	#instVars : [
		'address',
		'address2',
		'city',
		'country',
		'province',
		'postal',
		'facebookURL',
		'twitterURL',
		'homePageURL'
	],
	#category : #'ESUGApp-Model-Magritte'
}

{ #category : #accessing }
ERContactInformation >> address [
	^ address
]

{ #category : #accessing }
ERContactInformation >> address2 [
	^ address2
]

{ #category : #accessing }
ERContactInformation >> address2: anObject [
	address2 := anObject
]

{ #category : #accessing }
ERContactInformation >> address: anObject [
	address := anObject
]

{ #category : #accessing }
ERContactInformation >> city [
	^ city
]

{ #category : #accessing }
ERContactInformation >> city: anObject [
	city := anObject
]

{ #category : #accessing }
ERContactInformation >> country [
	^ country
]

{ #category : #accessing }
ERContactInformation >> country: anObject [
	country := anObject
]

{ #category : #'magrittes-descriptions' }
ERContactInformation >> descriptionAddress [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #address; 
		priority: 10;
		required: false;
		withoutLabel: true;
		group: 'Address: ';
		cssClass: 'half';
		id: 'address';
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'magrittes-descriptions' }
ERContactInformation >> descriptionAddress2 [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #address2; 
		priority: 20;
		required: false;
		withoutLabel: true;
		cssClass: 'half';
		id: 'address2';
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'magrittes-descriptions' }
ERContactInformation >> descriptionCity [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #city; 
		priority: 30;
		required: false;
		withoutLabel: true;
		cssClass: 'half';
		id: 'city';
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'magrittes-descriptions' }
ERContactInformation >> descriptionCountry [
	<magritteDescription>
	^  ERAward new descriptionCountry copy
              priority: 40;
				  cssClass: 'half';
				id: 'contactCountry';
              yourself.
]

{ #category : #'magrittes-descriptions' }
ERContactInformation >> descriptionFacebookURL [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #facebookURL; 
		priority: 70;
		required: false;
		withoutLabel: true;
		addCondition: [ :value | value asUrl isAbsolute ]
		labelled: 'Please enter a valid URL';
		cssClass: 'half';
		id: 'facebookURL';
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'magrittes-descriptions' }
ERContactInformation >> descriptionHomePageURL [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #homePageURL; 
		priority: 90;
		required: false;
		withoutLabel: true;
		addCondition: [ :value | value asUrl isAbsolute ]
		labelled: 'Please enter a valid URL';
		id: 'homePageURL';
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'magrittes-descriptions' }
ERContactInformation >> descriptionPostal [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #postal; 
		priority: 60;
		required: false;
		label: 'Postal/Zipcode ';
		withoutLabel: true;
		cssClass: 'half';
		id: 'postal';
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'magrittes-descriptions' }
ERContactInformation >> descriptionProvince [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #province; 
		priority: 50;
		required: false;
		label: 'Province/State :';
		withoutLabel: true;
		cssClass: 'half';
		id: 'province';
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'magrittes-descriptions' }
ERContactInformation >> descriptionTwitterURL [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #twitterURL; 
		priority: 80;
		required: false;
		withoutLabel: true;
		cssClass: 'half';
		addCondition: [ :value | value asUrl isAbsolute ]
		labelled: 'Please enter a valid URL';
		id: 'twitterURL';
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #accessing }
ERContactInformation >> facebookURL [
	^ facebookURL
]

{ #category : #accessing }
ERContactInformation >> facebookURL: anObject [
	facebookURL := anObject
]

{ #category : #accessing }
ERContactInformation >> homePageURL [
	^ homePageURL
]

{ #category : #accessing }
ERContactInformation >> homePageURL: anObject [
	homePageURL := anObject
]

{ #category : #accessing }
ERContactInformation >> postal [
	^ postal
]

{ #category : #accessing }
ERContactInformation >> postal: anObject [
	postal := anObject
]

{ #category : #accessing }
ERContactInformation >> province [
	^ province
]

{ #category : #accessing }
ERContactInformation >> province: anObject [
	province := anObject
]

{ #category : #accessing }
ERContactInformation >> twitterURL [
	^ twitterURL
]

{ #category : #accessing }
ERContactInformation >> twitterURL: anObject [
	twitterURL := anObject
]
