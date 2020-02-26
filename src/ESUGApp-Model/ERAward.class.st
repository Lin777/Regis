"
Description
--------------------

I am a model of Award
"
Class {
	#name : #ERAward,
	#superclass : #ESUGActiveRecord,
	#instVars : [
		'nameAward',
		'smalltalkDialect',
		'affiliation',
		'country',
		'downloadUrl',
		'demoUrl',
		'keywords',
		'licence',
		'submitter',
		'otherDevelopers',
		'submittionDate'
	],
	#category : #'ESUGApp-Model-Magritte'
}

{ #category : #accessing }
ERAward class >> submitter: anAttendee [
	^ self new 
		submitter: anAttendee; 
		yourself 
]

{ #category : #accessing }
ERAward >> affiliation [
	^ affiliation
]

{ #category : #accessing }
ERAward >> affiliation: anObject [
	affiliation := anObject
]

{ #category : #accessing }
ERAward >> country [
	^ country
]

{ #category : #accessing }
ERAward >> country: anObject [
	country := anObject
]

{ #category : #accessing }
ERAward >> demoUrl [
	^ demoUrl
]

{ #category : #accessing }
ERAward >> demoUrl: anObject [
	demoUrl := anObject
]

{ #category : #'magrittes-descriptions' }
ERAward >> descriptionAffilitation [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #affiliation; 
		priority: 50;
		beRequired;
		label: 'Affiliation (Required)';
		withoutLabel: true;
		id: 'affiliation';
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'magrittes-descriptions' }
ERAward >> descriptionCountry [
	<magritteDescription>
	| tmp1 |
	tmp1 := MASingleOptionDescription new.
	tmp1
		accessor: #country;
		priority: 60;
		required: false;
		options: ERAttendee countries;
		withoutLabel: true;
		id: 'country';
		componentClass: MDLMASelectListComponent .
	^ tmp1 yourself
]

{ #category : #'magrittes-descriptions' }
ERAward >> descriptionDemoUrl [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #demoUrl; 
		priority: 80;
		required: false;
		withoutLabel: true;
		addCondition: [ :value | value asUrl isAbsolute ]
		labelled: 'Please enter a valid URL';
		id: 'demoUrl';
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'magrittes-descriptions' }
ERAward >> descriptionDownloadUrl [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #downloadUrl; 
		priority: 70;
		beRequired;
		label: 'Download Url (Required)';
		addCondition: [ :value | value asUrl isAbsolute ]
		labelled: 'Please enter a valid URL';
		withoutLabel: true;
		id: 'downloadUrl';
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'magrittes-descriptions' }
ERAward >> descriptionKeywords [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #keywords; 
		priority: 90;
		required: false;
		withoutLabel: true;
		id: 'keywords';
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'magrittes-descriptions' }
ERAward >> descriptionLicence [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #licence; 
		priority: 100;
		required: false;
		withoutLabel: true;
		id: 'licence';
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'magrittes-descriptions' }
ERAward >> descriptionNameAward [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #nameAward; 
		priority: 10;
		beRequired;
		label: 'Name (Required)';
		withoutLabel: true;
		id: 'nameAward';
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'magrittes-descriptions' }
ERAward >> descriptionOtherDevelopers [
	<magritteDescription>
	^ ERAdditionalInformation new descriptionAdditionalText copy
			accessor: #otherDevelopers;
			priority: 30;
			lineCount: 5;
			id: 'otherDevelopers';
			yourself 
]

{ #category : #'magrittes-descriptions' }
ERAward >> descriptionSmalltalkDialect [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #smalltalkDialect; 
		priority: 40;
		required: false;
		withoutLabel: true;
		id: 'smalltalkDialect';
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #accessing }
ERAward >> downloadUrl [
	^ downloadUrl
]

{ #category : #accessing }
ERAward >> downloadUrl: anObject [
	downloadUrl := anObject
]

{ #category : #accessing }
ERAward >> keywords [
	^ keywords
]

{ #category : #accessing }
ERAward >> keywords: anObject [
	keywords := anObject
]

{ #category : #accessing }
ERAward >> licence [
	^ licence
]

{ #category : #accessing }
ERAward >> licence: anObject [
	licence := anObject
]

{ #category : #accessing }
ERAward >> nameAward [
	^ nameAward
]

{ #category : #accessing }
ERAward >> nameAward: anObject [
	nameAward := anObject
]

{ #category : #accessing }
ERAward >> otherDevelopers [
	^ otherDevelopers
]

{ #category : #accessing }
ERAward >> otherDevelopers: anObject [
	otherDevelopers := anObject
]

{ #category : #accessing }
ERAward >> smalltalkDialect [
	^ smalltalkDialect
]

{ #category : #accessing }
ERAward >> smalltalkDialect: anObject [
	smalltalkDialect := anObject
]

{ #category : #accessing }
ERAward >> submitter [
	^ submitter
]

{ #category : #accessing }
ERAward >> submitter: anObject [
	submitter := anObject
]

{ #category : #accessing }
ERAward >> submittionDate [
	^ submittionDate
]

{ #category : #accessing }
ERAward >> submittionDate: anObject [
	submittionDate := anObject
]
