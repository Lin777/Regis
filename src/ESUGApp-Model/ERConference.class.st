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

{ #category : #rendering }
ERConference >> deleteAttendee: anAttendee [
	self attends removeAllSuchThat: [ :each | anAttendee id = each id ].
]

{ #category : #rendering }
ERConference >> deleteUser: anUser [
	self users removeAllSuchThat: [ :each | anUser id = each id ].
	self save.
	anUser delete
]

{ #category : #accessing }
ERConference >> dictionaryForLunch [
	|dic|
	dic := OrderedDictionary new.
	#(#monday #tuesday #wednesday #thursday #friday) do: [ :each |
		dic at: each put: self dictionaryOfFoodPreference ].
	^ dic
]

{ #category : #accessing }
ERConference >> dictionaryOfFoodPreference [
	^ Dictionary new 	
		at: 'Vegan' put: 0;
		at: 'Normal' put: 0;
		at: 'Vegetarian' put: 0;
		yourself 
]

{ #category : #accessing }
ERConference >> dictionaryOfShirts [
	|dict|
	dict := OrderedDictionary new.
	ERAttendee tShirtSizes do: [ :each | dict at: each put: 
		(Dictionary new at: 'Male' put: 0; 
		at: 'Female' put: 0; yourself) ].
	^ dict
]

{ #category : #rendering }
ERConference >> exportAttends: fileName [
	| cvs |
	cvs := String
		streamContents: [ :out | 
			| neoWriter |
			neoWriter := NeoCSVWriter on: out.
			neoWriter writeHeader: self headerAttendee.
			self attends 
				do: [ :each | 
					neoWriter
						nextPut:
							{ each paymentInformation invoiceNumber.
							each userAccount firstName.
							each userAccount lastName.
							each userAccount email.
							each contactInformation country.
							each affiliationInformation organizationName} ].
			neoWriter close ].
	^ cvs
]

{ #category : #rendering }
ERConference >> exportAwards: fileName [
	|  cvs |
	cvs := String
		streamContents: [ :out | 
			| neoWriter |
			neoWriter := NeoCSVWriter on: out.
			neoWriter writeHeader: self hearderAwards.
			self submittedAwards
				do: [ :each | 
					neoWriter
						nextPut:
					{each nameAward.
					each submitter userAccount email}].

			neoWriter close ].
	^ cvs
]

{ #category : #rendering }
ERConference >> exportGroupManagers: fileName [
	|  cvs |
	cvs := String
		streamContents: [ :out | 
			| neoWriter |
			neoWriter := NeoCSVWriter on: out.
			neoWriter writeHeader: self headerGroups.
			self groups
				do: [ :each | 
					neoWriter
						nextPut:
							{each paymentInformation invoiceNumber.
							each groupManager userAccount firstName.
							each groupManager userAccount lastName.
							each groupManager userAccount email.
							each groupManager affiliationInformation organizationName.
							each groupManager affiliationInformation organizationAddrees1.
							each groupManager affiliationInformation organizationCity.
							each groupManager affiliationInformation organizationCountry.
							each groupManager affiliationInformation organizationPostal.
							each groupManager affiliationInformation membershipType} ].
				neoWriter close ].
	^ cvs
]

{ #category : #rendering }
ERConference >> exportTalks: fileName [
	| cvs |
	cvs := String
		streamContents: [ :out | 
			| neoWriter |
			neoWriter := NeoCSVWriter on: out.
			neoWriter writeHeader: self headerTalks.
			self submittedTalks
				do: [ :each | neoWriter 
				nextPut:
					{each name.
					each submitter userAccount email.
					each presentation} ].
			neoWriter close ].
	^ cvs
]

{ #category : #rendering }
ERConference >> exportUsers: fileName [
	| cvs |
	cvs := String
		streamContents: [ :out | 
			| neoWriter |
			neoWriter := NeoCSVWriter on: out.
			neoWriter writeHeader: self headerUser.
			self users
				do: [ :each | 
					neoWriter
						nextPut:
							{each id.
							each firstName.
							each lastName.
							each email.
							each password.
							each rolesAsString} ].
				neoWriter close ].
	^ cvs
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
ERConference >> flat: dictionary with: aString [
	|list|
	list := OrderedCollection new.
	dictionary keysDo: [:key ||value|
		value := dictionary at: key.
		value at: aString put: key asString capitalized.
		list add: value].
	^ list
]

{ #category : #accessing }
ERConference >> groups [
	^ groups
]

{ #category : #accessing }
ERConference >> groups: anObject [
	groups := anObject
]

{ #category : #rendering }
ERConference >> headerAttendee [
	^ #('InvoiceNumber' 'FirstName' 'LastName' 'Email' 'Country' 'Org. Name')
]

{ #category : #rendering }
ERConference >> headerGroups [
	^ #('Invoice Number' 'First Name' 'Last Name' 'Email' 'Org. Name' 'Org. Address1' 
	'Org. City' 'Org. Country' 'Org. Postal' 'Org. Membership')
]

{ #category : #rendering }
ERConference >> headerTalks [
	^ #('Name' 'Submitted By' 'Uploaded File')
]

{ #category : #rendering }
ERConference >> headerUser [
	^ #('id' 'firstName' 'lastName' 'email' 'password' 'role')
]

{ #category : #rendering }
ERConference >> headersParticipantsToLunches [
	^ #('Day' 'Normal' 'Vegetarian' 'Vegan')	
]

{ #category : #rendering }
ERConference >> headersParticipantsToSocialDinner [
	^ #( 'Normal' 'Vegetarian' 'Vegan')	
]

{ #category : #rendering }
ERConference >> headersShirtsStatistics [
	^ #('Size of the shirt' 'Female' 'Male')
]

{ #category : #rendering }
ERConference >> hearderAwards [
	^ #('Name' 'Submitted by')
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

{ #category : #rendering }
ERConference >> invoices [
	^ (self groups), 
	(self attends 
		select: [ :each | each idGroup isNil ])
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
ERConference >> statisticsOfLuch [
	|dict|
	dict := self dictionaryForLunch.
	self attends do: [ :att |
		dict := att conferenceInformation addMyPreferenceForLuchTo: dict ].
	dict := self flat: dict with: 'Day'. 
	^ dict
]

{ #category : #accessing }
ERConference >> statisticsOfSocialDinner [
	|dict|
	dict := self dictionaryOfFoodPreference.
	self attends do: [ :att |
		dict := att conferenceInformation addMyPreferenceForSocialDinnerTo: dict ].
	dict := OrderedCollection with: dict.
	^ dict
]

{ #category : #accessing }
ERConference >> statisticsOfTShirts [
	|dict|
	dict := self dictionaryOfShirts.
	self attends do: [ :att |
		dict := att conferenceInformation addMytShirtTo: dict ].
	dict := self flat: dict with: 'Size of the shirt'.
	^ dict
]

{ #category : #accessing }
ERConference >> submittedAwards [
	^ submittedAwards
]

{ #category : #accessing }
ERConference >> submittedAwards: anObject [
	submittedAwards := anObject
]

{ #category : #'as yet unclassified' }
ERConference >> submittedAwardsFor: anAttendee [
	^ self submittedAwards select: [ :each | each submitter = anAttendee ]
]

{ #category : #accessing }
ERConference >> submittedTalks [
	^ submittedTalks
]

{ #category : #accessing }
ERConference >> submittedTalks: anObject [
	submittedTalks := anObject
]

{ #category : #'as yet unclassified' }
ERConference >> submittedTalksFor: anAttendee [
	^ self submittedTalks select: [ :each | each submitter = anAttendee ]
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
