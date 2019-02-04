Class {
	#name : #ERConferenceConfigurationModel1,
	#superclass : #Object,
	#instVars : [
		'name',
		'description',
		'homePageUrl',
		'earlyRegistrationDeadline',
		'dateSubmissionDeadline',
		'emailConfiguration',
		'organizer',
		'dateFrom',
		'dateTo',
		'openRegistration'
	],
	#category : #'ESUGApp-Model-Magritte'
}

{ #category : #accessing }
ERConferenceConfigurationModel1 >> dateFrom [
	^ dateFrom
]

{ #category : #accessing }
ERConferenceConfigurationModel1 >> dateFrom: anObject [
	dateFrom := anObject
]

{ #category : #accessing }
ERConferenceConfigurationModel1 >> dateSubmissionDeadline [
	^ dateSubmissionDeadline
]

{ #category : #accessing }
ERConferenceConfigurationModel1 >> dateSubmissionDeadline: anObject [
	dateSubmissionDeadline := anObject
]

{ #category : #accessing }
ERConferenceConfigurationModel1 >> dateTo [
	^ dateTo
]

{ #category : #accessing }
ERConferenceConfigurationModel1 >> dateTo: anObject [
	dateTo := anObject
]

{ #category : #accessing }
ERConferenceConfigurationModel1 >> description [
	^ description
]

{ #category : #accessing }
ERConferenceConfigurationModel1 >> description: anObject [
	description := anObject
]

{ #category : #'as yet unclassified' }
ERConferenceConfigurationModel1 >> descriptionDateFrom [
	<magritteDescription>
	| tmp2 |
	tmp2 := MAStringDescription new.
	tmp2
		accessor: #dateFrom; 
		priority: 40;
		required: true;
		cssClass: 'half';
		group: 'Dates:';
		label: 'From';
		withoutLabel: true;
		addCondition: [ :value | value matchesRegex: '^([0]?[0-9]|[12][0-9]|[3][01])[./-]([0]?[1-9]|[1][0-2])[./-]([0-9]{4}|[0-9]{2})$' ] 
		labelled: 'This field only supports dates with the following format "DD/MM/YYYY"';
		componentClass: MDLMATextInputComponent.
	^ tmp2 yourself
]

{ #category : #'as yet unclassified' }
ERConferenceConfigurationModel1 >> descriptionDateSubmissionDeadline [
	<magritteDescription>
	| tmp2 |
	tmp2 := MAStringDescription new.
	tmp2
		accessor: #dateSubmissionDeadline; 
		priority: 60;
		required: true;
		label: 'Submission Deadline';
		withoutLabel: true;
		cssClass: 'half';
		addCondition: [ :value | value matchesRegex: '^([0]?[0-9]|[12][0-9]|[3][01])[./-]([0]?[1-9]|[1][0-2])[./-]([0-9]{4}|[0-9]{2})$' ] 
		labelled: 'This field only supports dates with the following format "DD/MM/YYYY"';
		componentClass: MDLMATextInputComponent.
	^ tmp2 yourself
]

{ #category : #'as yet unclassified' }
ERConferenceConfigurationModel1 >> descriptionDateTo [
	<magritteDescription>
	| tmp2 |
	tmp2 := MAStringDescription new.
	tmp2
		accessor: #dateTo; 
		priority: 50;
		required: true;
		label: 'To';
		cssClass: 'half';
		withoutLabel: true;
		addCondition: [ :value | value matchesRegex: '^([0]?[0-9]|[12][0-9]|[3][01])[./-]([0]?[1-9]|[1][0-2])[./-]([0-9]{4}|[0-9]{2})$' ] 
		labelled: 'This field only supports dates with the following format "DD/MM/YYYY"';
		componentClass: MDLMATextInputComponent .
	^ tmp2 yourself
]

{ #category : #'as yet unclassified' }
ERConferenceConfigurationModel1 >> descriptionDescription [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #description; 
		priority: 20;
		required: false;
		withoutLabel: true;
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'as yet unclassified' }
ERConferenceConfigurationModel1 >> descriptionEarlyRegistrationDeadline [
	<magritteDescription>
	| tmp2 |
	tmp2 := MAStringDescription new.
	tmp2
		accessor: #earlyRegistrationDeadline; 
		priority: 70;
		required: true;
		label: 'Early Registration Deadline';
		withoutLabel: true;
		cssClass: 'half';
		addCondition: [ :value | value matchesRegex: '^([0]?[0-9]|[12][0-9]|[3][01])[./-]([0]?[1-9]|[1][0-2])[./-]([0-9]{4}|[0-9]{2})$' ] 
		labelled: 'This field only supports dates with the following format "DD/MM/YYYY"';
		componentClass: MDLMATextInputComponent.
	^ tmp2 yourself
]

{ #category : #'as yet unclassified' }
ERConferenceConfigurationModel1 >> descriptionHomePageUrl [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #homePageUrl; 
		priority: 30;
		required: false;
		withoutLabel: true;
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'as yet unclassified' }
ERConferenceConfigurationModel1 >> descriptionName [
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
ERConferenceConfigurationModel1 >> earlyRegistrationDeadline [
	^ earlyRegistrationDeadline
]

{ #category : #accessing }
ERConferenceConfigurationModel1 >> earlyRegistrationDeadline: anObject [
	earlyRegistrationDeadline := anObject
]

{ #category : #accessing }
ERConferenceConfigurationModel1 >> emailConfiguration [
	^ emailConfiguration
]

{ #category : #accessing }
ERConferenceConfigurationModel1 >> emailConfiguration: anObject [
	emailConfiguration := anObject
]

{ #category : #accessing }
ERConferenceConfigurationModel1 >> homePageUrl [
	^ homePageUrl
]

{ #category : #accessing }
ERConferenceConfigurationModel1 >> homePageUrl: anObject [
	homePageUrl := anObject
]

{ #category : #accessing }
ERConferenceConfigurationModel1 >> name [
	^ name
]

{ #category : #accessing }
ERConferenceConfigurationModel1 >> name: anObject [
	name := anObject
]

{ #category : #accessing }
ERConferenceConfigurationModel1 >> openRegistration [
	^ openRegistration
]

{ #category : #accessing }
ERConferenceConfigurationModel1 >> openRegistration: anObject [
	openRegistration := anObject
]

{ #category : #accessing }
ERConferenceConfigurationModel1 >> organizer [
	^ organizer
]

{ #category : #accessing }
ERConferenceConfigurationModel1 >> organizer: anObject [
	organizer := anObject
]
