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
		'configuration'
	],
	#category : #'ESUGApp-Models'
}

{ #category : #accessing }
ERConference >> attendees [
	^ attendees
]

{ #category : #accessing }
ERConference >> attendees: anObject [
	attendees := anObject
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
ERConference >> fees [
	^ fees
]

{ #category : #accessing }
ERConference >> fees: anObject [
	fees := anObject
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
