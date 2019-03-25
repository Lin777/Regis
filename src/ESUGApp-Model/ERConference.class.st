Class {
	#name : #ERConference,
	#superclass : #SDActiveRecord,
	#instVars : [
		'attends',
		'fee',
		'reductionTickets',
		'submittedTalks',
		'submittedAwards',
		'payments',
		'groups',
		'users',
		'configuration',
		'active',
		'invoiceNumber'
	],
	#category : #'ESUGApp-Model'
}

{ #category : #accessing }
ERConference >> active [
	^ active
]

{ #category : #accessing }
ERConference >> active: anObject [
	active := anObject
]

{ #category : #initialization }
ERConference >> addAttendee: anAttendee [
	| anAttendeeSaved userSaved |
	self validateIfEmailIsAlreadyRegistered: anAttendee userAccount.
	userSaved := anAttendee userAccount save.
	self addUser: userSaved.
	anAttendeeSaved := (anAttendee userAccount: userSaved) save.
	attends add: anAttendeeSaved.
	self save.
	^ anAttendeeSaved
	"attends add: anAttendee "
]

{ #category : #initialization }
ERConference >> addGroup: aGroup [
	groups add: aGroup 
]

{ #category : #initialization }
ERConference >> addPayment: aPayment [
	payments add: aPayment 
]

{ #category : #accessing }
ERConference >> addReductionTicket: aReductionTicket [
	self reductionTicketAlreadyExist: aReductionTicket.
	aReductionTicket save.
	reductionTickets add: aReductionTicket .
	self save.
]

{ #category : #accessing }
ERConference >> addSubmittedAward: aSubmittedAward [
	submittedAwards add: aSubmittedAward 
]

{ #category : #accessing }
ERConference >> addSubmittedTalk: aSubmittedTalk [
	submittedTalks add: aSubmittedTalk 
]

{ #category : #accessing }
ERConference >> addUser: anUser [
	users add: anUser 
]

{ #category : #accessing }
ERConference >> attends [
	^ attends
]

{ #category : #accessing }
ERConference >> attends: anObject [
	attends := anObject
]

{ #category : #initialization }
ERConference >> closeRegistration [
	self configuration openRegistration: false.
	self save.
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
ERConference >> fee [
	^ fee
]

{ #category : #accessing }
ERConference >> fee: anObject [
	fee := anObject
]

{ #category : #accessing }
ERConference >> groups [
	^ groups
]

{ #category : #accessing }
ERConference >> groups: anObject [
	groups := anObject
]

{ #category : #initialization }
ERConference >> incrementInvoiceNumber [
	^ invoiceNumber := self invoiceNumber +1
]

{ #category : #initialization }
ERConference >> initialize [
	super initialize.
	attends := OrderedCollection new.
	groups := OrderedCollection new.
	payments := OrderedCollection new.
	reductionTickets := OrderedCollection new.
	submittedAwards := OrderedCollection new.
	submittedTalks := OrderedCollection new.
	users := OrderedCollection new.
	active := false.
	invoiceNumber := 0
]

{ #category : #accessing }
ERConference >> invoiceNumber [
	invoiceNumber ifNil: [ invoiceNumber := 0 ].
	 ^ invoiceNumber
]

{ #category : #initialization }
ERConference >> openRegistration [
	self configuration openRegistration: true.
	self save.
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
ERConference >> reductionTicketAlreadyExist: aReductionTicket [
	self reductionTickets
		do: [ :each | 
			aReductionTicket ticketId = each ticketId
				ifTrue: [ ERException ticketWithIdAlreadyExist signal ] ]
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

{ #category : #accessing }
ERConference >> validateIfEmailIsAlreadyRegistered: anUser [
	self users
		do: [ :each | 
			each email = anUser email
				ifTrue: [each = anUser ifFalse:[
					ERException emailAlreadyRegistered signal ] ]].
]
