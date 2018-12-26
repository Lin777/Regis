Class {
	#name : #ERConferenceConfigurationModel,
	#superclass : #SDActiveRecord,
	#instVars : [
		'name',
		'description',
		'homePageUrl',
		'earlyRegistrationDeadline',
		'dhateSubmissionDeadline',
		'emailConfiguration',
		'organizer',
		'dateFrom',
		'dateTo'
	],
	#category : #'ESUGApp-Models'
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

{ #category : #accessing }
ERConferenceConfigurationModel >> dhateSubmissionDeadline [
	^ dhateSubmissionDeadline
]

{ #category : #accessing }
ERConferenceConfigurationModel >> dhateSubmissionDeadline: anObject [
	dhateSubmissionDeadline := anObject
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

{ #category : #accessing }
ERConferenceConfigurationModel >> name1 [
	^ name
]

{ #category : #accessing }
ERConferenceConfigurationModel >> name: anObject [
	name := anObject
]

{ #category : #accessing }
ERConferenceConfigurationModel >> organizer [
	^ organizer
]

{ #category : #accessing }
ERConferenceConfigurationModel >> organizer: anObject [
	organizer := anObject
]
