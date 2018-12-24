Class {
	#name : #ERConference,
	#superclass : #SDActiveRecord,
	#instVars : [
		'name',
		'description',
		'homePage',
		'dateFrom',
		'dateTo',
		'dateSubmissionDeadline',
		'earlygistrationDeadline',
		'senderEmailAddress',
		'smptServerAddress',
		'smptClient',
		'welcomeText',
		'nameOrganizer',
		'fisicalSituation',
		'webPageUrl',
		'addressString'
	],
	#category : #'ESUGApp-Models'
}

{ #category : #accessing }
ERConference >> addressString [
	^ addressString
]

{ #category : #accessing }
ERConference >> addressString: anObject [
	addressString := anObject
]

{ #category : #accessing }
ERConference >> dateFrom [
	^ dateFrom
]

{ #category : #accessing }
ERConference >> dateFrom: anObject [
	dateFrom := anObject
]

{ #category : #accessing }
ERConference >> dateSubmissionDeadline [
	^ dateSubmissionDeadline
]

{ #category : #accessing }
ERConference >> dateSubmissionDeadline: anObject [
	dateSubmissionDeadline := anObject
]

{ #category : #accessing }
ERConference >> dateTo [
	^ dateTo
]

{ #category : #accessing }
ERConference >> dateTo: anObject [
	dateTo := anObject
]

{ #category : #accessing }
ERConference >> description [
	^ description
]

{ #category : #accessing }
ERConference >> description: anObject [
	description := anObject
]

{ #category : #accessing }
ERConference >> earlygistrationDeadline [
	^ earlygistrationDeadline
]

{ #category : #accessing }
ERConference >> earlygistrationDeadline: anObject [
	earlygistrationDeadline := anObject
]

{ #category : #accessing }
ERConference >> fisicalSituation [
	^ fisicalSituation
]

{ #category : #accessing }
ERConference >> fisicalSituation: anObject [
	fisicalSituation := anObject
]

{ #category : #accessing }
ERConference >> homePage [
	^ homePage
]

{ #category : #accessing }
ERConference >> homePage: anObject [
	homePage := anObject
]

{ #category : #accessing }
ERConference >> name1 [
	^ name
]

{ #category : #accessing }
ERConference >> name: anObject [
	name := anObject
]

{ #category : #accessing }
ERConference >> nameOrganizer [
	^ nameOrganizer
]

{ #category : #accessing }
ERConference >> nameOrganizer: anObject [
	nameOrganizer := anObject
]

{ #category : #accessing }
ERConference >> resenderEmailAddress [
	^ senderEmailAddress
]

{ #category : #accessing }
ERConference >> resenderEmailAddress: anObject [
	senderEmailAddress := anObject
]

{ #category : #accessing }
ERConference >> senderEmailAddress [
	^ senderEmailAddress
]

{ #category : #accessing }
ERConference >> senderEmailAddress: anObject [
	senderEmailAddress := anObject
]

{ #category : #accessing }
ERConference >> smptClient [
	^ smptClient
]

{ #category : #accessing }
ERConference >> smptClient: anObject [
	smptClient := anObject
]

{ #category : #accessing }
ERConference >> smptServerAddress [
	^ smptServerAddress
]

{ #category : #accessing }
ERConference >> smptServerAddress: anObject [
	smptServerAddress := anObject
]

{ #category : #accessing }
ERConference >> webPageUrl [
	^ webPageUrl
]

{ #category : #accessing }
ERConference >> webPageUrl: anObject [
	webPageUrl := anObject
]

{ #category : #accessing }
ERConference >> welcomeText [
	^ welcomeText
]

{ #category : #accessing }
ERConference >> welcomeText: anObject [
	welcomeText := anObject
]
