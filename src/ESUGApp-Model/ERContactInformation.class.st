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

{ #category : #accessing }
ERContactInformation >> descriptionAddress [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #address; 
		priority: 10;
		required: false;
		withoutLabel: true;
		cssClass: 'halfDiv';
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #accessing }
ERContactInformation >> descriptionAddress2 [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #address2; 
		priority: 20;
		required: false;
		withoutLabel: true;
		cssClass: 'halfDiv';
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #accessing }
ERContactInformation >> descriptionCity [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #city; 
		priority: 30;
		required: false;
		withoutLabel: true;
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #accessing }
ERContactInformation >> descriptionCountry [
	<magritteDescription>
	| tmp1 |
	tmp1 := MASingleOptionDescription new.
	tmp1
		accessor: #country;
		priority: 40;
		required: false;
		options: ERAttendee countries;
		withoutLabel: true;
		componentClass: MDLMASelectListComponent .
	^ tmp1 yourself
]

{ #category : #accessing }
ERContactInformation >> descriptionFacebookURL [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #facebookURL; 
		priority: 70;
		required: false;
		withoutLabel: true;
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #accessing }
ERContactInformation >> descriptionHomePageURL [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #homePageURL; 
		priority: 90;
		required: false;
		withoutLabel: true;
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #accessing }
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
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #accessing }
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
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #accessing }
ERContactInformation >> descriptionTwitterURL [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #twitterURL; 
		priority: 80;
		required: false;
		withoutLabel: true;
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
