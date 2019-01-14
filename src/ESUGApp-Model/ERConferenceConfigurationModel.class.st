Class {
	#name : #ERConferenceConfigurationModel,
	#superclass : #SDActiveRecord,
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
	#category : #'ESUGApp-Model'
}

{ #category : #'as yet unclassified' }
ERConferenceConfigurationModel class >> conferenceConfiguration [
	"|email organizer conference|

email := ERConferenceEmailConfiguration new 
senderEmailAddress: 'registration@esug.org';
		smptServerAddress: 'localhost';
		smptClient: 'PatSmtpToPostMarkClientAdapter';
		welcomeText: 'Welcome to this great conference'; save.
organizer := ERConferenceOrganizer new 
		name: 'ESUG' ;
		fisicalSituation: 'Association Loi 1901 n°W751167780 (not subjected to  V.A.T.)';
		webPageUrl: 'http://www.esug.org';
		addressString: 'c/o Mr. Stéphane Ducasse - 1 rue Cesar Franck 59800 Lille - France'; save.
	conference := ERConferenceConfigurationModel new name: 'ESUG'; description: 'ESUG International Smalltalk Conference'; homePageUrl: 'http://www.esug.org/wiki/pier/Conferences/2018/'; earlyRegistrationDeadline: '01/01/2018';
	dateSubmissionDeadline: '01/01/2018';emailConfiguration: email ; organizer: organizer; save.
	"

	
]

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

{ #category : #accessing }
ERConferenceConfigurationModel >> name1 [
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
