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
	tmp2 := MADateDescription new.
	tmp2
		accessor: #dateFrom; 
		priority: 40;
		required: true;
		label: 'From';
		withoutLabel: true;
		componentClass: MDLMADateInputComponent.
	^ tmp2 yourself
]

{ #category : #'as yet unclassified' }
ERConferenceConfigurationModel1 >> descriptionDateSubmissionDeadline [
	<magritteDescription>
	| tmp2 |
	tmp2 := MADateDescription new.
	tmp2
		accessor: #dateSubmissionDeadline; 
		priority: 60;
		required: true;
		label: 'Submission Deadline';
		withoutLabel: true;
		componentClass: MDLMADateInputComponent.
	^ tmp2 yourself
]

{ #category : #'as yet unclassified' }
ERConferenceConfigurationModel1 >> descriptionDateTo [
	<magritteDescription>
	| tmp2 |
	tmp2 := MADateDescription new.
	tmp2
		accessor: #dateTo; 
		priority: 50;
		required: true;
		label: 'To';
		withoutLabel: true;
		componentClass: MDLMADateInputComponent.
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
	tmp2 := MADateDescription new.
	tmp2
		accessor: #earlyRegistrationDeadline; 
		priority: 70;
		required: true;
		label: 'Early Registration Deadline';
		withoutLabel: true;
		componentClass: MDLMADateInputComponent.
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
