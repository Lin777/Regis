Class {
	#name : #ERConference,
	#superclass : #SDActiveRecord,
	#instVars : [
		'attendees',
		'fees',
		'reductionTickets',
		'submittedTalks',
		'submittedAwards',
		'payments',
		'groups',
		'users',
		'configuration',
		'active'
	],
	#category : #'ESUGApp-Models'
}

{ #category : #accessing }
ERConference >> active [
	^ active
]

{ #category : #accessing }
ERConference >> active: anObject [
	active := anObject
]

{ #category : #accessing }
ERConference >> addAttendee: anAttendee [
	attendees add: anAttendee 
]

{ #category : #accessing }
ERConference >> addFee: aFee [
	fees add: aFee
]

{ #category : #accessing }
ERConference >> addGroup: aGroup [
	groups add: aGroup
]

{ #category : #accessing }
ERConference >> addReductionTickets: aTicket [
	reductionTickets add: aTicket 
]

{ #category : #accessing }
ERConference >> addUser: anUser [
	users add: anUser  
]

{ #category : #accessing }
ERConference >> addressString [
	^ addressString
]

{ #category : #accessing }
ERConference >> addressString: anObject [
	addressString := anObject
]

{ #category : #accessing }
ERConference >> attendees: anObject [
	attendees := anObject
]

{ #category : #accessing }
ERConference >> attends [
	^ attendees
]

{ #category : #accessing }
ERConference >> configuration [
	^ configuration
]

{ #category : #accessing }
ERConference >> configuration: anObject [
	configuration := anObject
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
ERConference >> fees [
	^ fees
]

{ #category : #accessing }
ERConference >> fees: anObject [
	fees := anObject
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
ERConference >> groups [
	^ groups
]

{ #category : #accessing }
ERConference >> groups: anObject [
	groups := anObject
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
ERConference >> initialize [
	super initialize .
	attendees := OrderedCollection new.
	groups := OrderedCollection new.
	fees := OrderedCollection new.
	reductionTickets := OrderedCollection new.
	submittedTalks := OrderedCollection new.
	submittedAwards := OrderedCollection new.
	payments := OrderedCollection new.
	users := OrderedCollection new.
	active := false.
	
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
ERConference >> payments [
	^ payments
]

{ #category : #accessing }
ERConference >> payments: anObject [
	payments := anObject
]

{ #category : #accessing }
ERConference >> reductionTickets [
	^ reductionTickets
]

{ #category : #accessing }
ERConference >> reductionTickets: anObject [
	reductionTickets := anObject
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
ERConference >> submittedAwards [
	^ submittedAwards
]

{ #category : #accessing }
ERConference >> submittedAwards: anObject [
	submittedAwards := anObject
]

{ #category : #accessing }
ERConference >> submittedTalks [
	^ submittedTalks
]

{ #category : #accessing }
ERConference >> submittedTalks: anObject [
	submittedTalks := anObject
]

{ #category : #accessing }
ERConference >> users [
	^ users
]

{ #category : #accessing }
ERConference >> users: anObject [
	users := anObject
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
