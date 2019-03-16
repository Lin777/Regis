Class {
	#name : #ERConferenceConfigurationModel,
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
ERConferenceConfigurationModel >> dateFrom [
	^ dateFrom
]

{ #category : #accessing }
ERConferenceConfigurationModel >> dateFrom: anObject [
	dateFrom := anObject
]

{ #category : #accessing }
ERConferenceConfigurationModel >> dateSubmissionDeadline [
	^ dateSubmissionDeadline
]

{ #category : #accessing }
ERConferenceConfigurationModel >> dateSubmissionDeadline: anObject [
	dateSubmissionDeadline := anObject
]

{ #category : #accessing }
ERConferenceConfigurationModel >> dateTo [
	^ dateTo
]

{ #category : #accessing }
ERConferenceConfigurationModel >> dateTo: anObject [
	dateTo := anObject
]

{ #category : #accessing }
ERConferenceConfigurationModel >> description [
	^ description
]

{ #category : #accessing }
ERConferenceConfigurationModel >> description: anObject [
	description := anObject
]

{ #category : #'as yet unclassified' }
ERConferenceConfigurationModel >> descriptionDateFrom [
	<magritteDescription>
	| tmp2 |
	tmp2 := MAStringDescription new.
	tmp2
		accessor: #dateFrom; 
		priority: 40;
		beRequired;
		cssClass: 'half';
		group: 'Dates:';
		label: 'From (Required)';
		withoutLabel: true;
		addCondition: [ :value | value matchesRegex: self patternDate ] 
		labelled: self messageInvalidDate;
		id: 'dateFrom';
		componentClass: MDLMATextInputComponent.
	^ tmp2 yourself
]

{ #category : #'as yet unclassified' }
ERConferenceConfigurationModel >> descriptionDateSubmissionDeadline [
	<magritteDescription>
	| tmp2 |
	tmp2 := MAStringDescription new.
	tmp2
		accessor: #dateSubmissionDeadline; 
		priority: 60;
		beRequired;
		label: 'Submission Deadline (Required)';
		withoutLabel: true;
		cssClass: 'half';
		addCondition: [ :value | value matchesRegex: self patternDate ] 
		labelled: self messageInvalidDate;
		id: 'dateSubmissionDeadline';
		componentClass: MDLMATextInputComponent.
	^ tmp2 yourself
]

{ #category : #'as yet unclassified' }
ERConferenceConfigurationModel >> descriptionDateTo [
	<magritteDescription>
	| tmp2 |
	tmp2 := MAStringDescription new.
	tmp2
		accessor: #dateTo; 
		priority: 50;
		beRequired;
		label: 'To (Required)';
		cssClass: 'half';
		withoutLabel: true;
		addCondition: [ :value | value matchesRegex: self patternDate ] 
		labelled: self messageInvalidDate;
		id: 'dateTo';
		componentClass: MDLMATextInputComponent .
	^ tmp2 yourself
]

{ #category : #'as yet unclassified' }
ERConferenceConfigurationModel >> descriptionDescription [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #description; 
		priority: 20;
		required: false;
		withoutLabel: true;
		id: 'description';
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'as yet unclassified' }
ERConferenceConfigurationModel >> descriptionEarlyRegistrationDeadline [
	<magritteDescription>
	| tmp2 |
	tmp2 := MAStringDescription new.
	tmp2
		accessor: #earlyRegistrationDeadline; 
		priority: 70;
		beRequired;
		label: 'Early Registration Deadline (Required)';
		withoutLabel: true;
		cssClass: 'half';
		addCondition: [ :value | value matchesRegex: self patternDate ] 
		labelled: self messageInvalidDate;
		id: 'earlyRegistrationDeadline';
		componentClass: MDLMATextInputComponent.
	^ tmp2 yourself
]

{ #category : #'as yet unclassified' }
ERConferenceConfigurationModel >> descriptionHomePageUrl [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #homePageUrl; 
		priority: 30;
		required: false;
		withoutLabel: true;
		id: 'homePageUrl';
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'as yet unclassified' }
ERConferenceConfigurationModel >> descriptionName [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #name; 
		priority: 10;
		beRequired;
		withoutLabel: true;
		label: 'Name (Required)';
		id: 'name';
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #accessing }
ERConferenceConfigurationModel >> earlyRegistrationDeadline [
	^ earlyRegistrationDeadline
]

{ #category : #accessing }
ERConferenceConfigurationModel >> earlyRegistrationDeadline: anObject [
	earlyRegistrationDeadline := anObject
]

{ #category : #accessing }
ERConferenceConfigurationModel >> emailConfiguration [
	^ emailConfiguration
]

{ #category : #accessing }
ERConferenceConfigurationModel >> emailConfiguration: anObject [
	emailConfiguration := anObject
]

{ #category : #accessing }
ERConferenceConfigurationModel >> homePageUrl [
	^ homePageUrl
]

{ #category : #accessing }
ERConferenceConfigurationModel >> homePageUrl: anObject [
	homePageUrl := anObject
]

{ #category : #initialization }
ERConferenceConfigurationModel >> initialize [
	super initialize.
	self openRegistration: true
]

{ #category : #'as yet unclassified' }
ERConferenceConfigurationModel >> messageInvalidDate [
	^ 'This field only supports dates with the following format "MM/DD/YYYY"'
]

{ #category : #accessing }
ERConferenceConfigurationModel >> name [
	^ name
]

{ #category : #accessing }
ERConferenceConfigurationModel >> name: anObject [
	name := anObject
]

{ #category : #accessing }
ERConferenceConfigurationModel >> openRegistration [
	^ openRegistration
]

{ #category : #accessing }
ERConferenceConfigurationModel >> openRegistration: anObject [
	openRegistration := anObject
]

{ #category : #accessing }
ERConferenceConfigurationModel >> organizer [
	^ organizer
]

{ #category : #accessing }
ERConferenceConfigurationModel >> organizer: anObject [
	organizer := anObject
]

{ #category : #'as yet unclassified' }
ERConferenceConfigurationModel >> patternDate [ 
	^ '^([0]?[1-9]|[1][0-2])[./-]([0]?[0-9]|[12][0-9]|[3][01])[./-]([0-9]{4}|[0-9]{2})$'
]
