Class {
	#name : #ERAward1,
	#superclass : #SDActiveRecord,
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
ERAward1 class >> submitter: anAttendee [
	^ self new 
		submitter: anAttendee; 
		yourself 
]

{ #category : #accessing }
ERAward1 >> affiliation [
	^ affiliation
]

{ #category : #accessing }
ERAward1 >> affiliation: anObject [
	affiliation := anObject
]

{ #category : #accessing }
ERAward1 >> country [
	^ country
]

{ #category : #accessing }
ERAward1 >> country: anObject [
	country := anObject
]

{ #category : #accessing }
ERAward1 >> demoUrl [
	^ demoUrl
]

{ #category : #accessing }
ERAward1 >> demoUrl: anObject [
	demoUrl := anObject
]

{ #category : #'as yet unclassified' }
ERAward1 >> descriptionAffilitation [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #affiliation; 
		priority: 50;
		beRequired;
		label: 'Affiliation (Required)';
		withoutLabel: true;
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'as yet unclassified' }
ERAward1 >> descriptionCountry [
	<magritteDescription>
	| tmp1 |
	tmp1 := MASingleOptionDescription new.
	tmp1
		accessor: #country;
		priority: 60;
		required: false;
		options: ERAttendee1 countries;
		withoutLabel: true;
		componentClass: MDLMASelectListComponent .
	^ tmp1 yourself
]

{ #category : #'as yet unclassified' }
ERAward1 >> descriptionDemoUrl [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #demoUrl; 
		priority: 80;
		required: false;
		withoutLabel: true;
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'as yet unclassified' }
ERAward1 >> descriptionDownloadUrl [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #downloadUrl; 
		priority: 70;
		beRequired;
		label: 'Download Url (Required)';
		withoutLabel: true;
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'as yet unclassified' }
ERAward1 >> descriptionKeywords [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #keywords; 
		priority: 90;
		required: false;
		withoutLabel: true;
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'as yet unclassified' }
ERAward1 >> descriptionLicence [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #licence; 
		priority: 100;
		required: false;
		withoutLabel: true;
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'as yet unclassified' }
ERAward1 >> descriptionNameAward [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #nameAward; 
		priority: 10;
		beRequired;
		label: 'Name (Required)';
		withoutLabel: true;
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'as yet unclassified' }
ERAward1 >> descriptionOtherDevelopers [
	<magritteDescription>
	| tmp |
	tmp := MAMemoDescription new.
	tmp 
		accessor: #otherDevelopers; 
		priority: 30;
		required: false;
		lineCount: 5;
		withoutLabel: true;
		componentClass: MDLMATextAreaComponent.
	^ tmp yourself
]

{ #category : #'as yet unclassified' }
ERAward1 >> descriptionSmalltalkDialect [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #smalltalkDialect; 
		priority: 40;
		required: false;
		withoutLabel: true;
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #accessing }
ERAward1 >> downloadUrl [
	^ downloadUrl
]

{ #category : #accessing }
ERAward1 >> downloadUrl: anObject [
	downloadUrl := anObject
]

{ #category : #accessing }
ERAward1 >> keywords [
	^ keywords
]

{ #category : #accessing }
ERAward1 >> keywords: anObject [
	keywords := anObject
]

{ #category : #accessing }
ERAward1 >> licence [
	^ licence
]

{ #category : #accessing }
ERAward1 >> licence: anObject [
	licence := anObject
]

{ #category : #accessing }
ERAward1 >> nameAward [
	^ nameAward
]

{ #category : #accessing }
ERAward1 >> nameAward: anObject [
	nameAward := anObject
]

{ #category : #accessing }
ERAward1 >> otherDevelopers [
	^ otherDevelopers
]

{ #category : #accessing }
ERAward1 >> otherDevelopers: anObject [
	otherDevelopers := anObject
]

{ #category : #accessing }
ERAward1 >> smalltalkDialect [
	^ smalltalkDialect
]

{ #category : #accessing }
ERAward1 >> smalltalkDialect: anObject [
	smalltalkDialect := anObject
]

{ #category : #accessing }
ERAward1 >> submitter [
	^ submitter
]

{ #category : #accessing }
ERAward1 >> submitter: anObject [
	submitter := anObject
]

{ #category : #accessing }
ERAward1 >> submittionDate [
	^ submittionDate
]

{ #category : #accessing }
ERAward1 >> submittionDate: anObject [
	submittionDate := anObject
]
