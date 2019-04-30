"
Description
--------------------

I am a model of Conference

Instance Variables
--------------------

attends:                <OrderedCollection> list of ERAttendees registered in conference
fee: 						  <ERFee> a fee of conference
reductionTickets:       <OrderedCollection> list of tickets to conference
submittedTalks:         <OrderedCollection> list of submitted talks to conference
submittedAwards:        <OrderedCollection> list of submitted awards to conference
groups:                 <OrderedCollection> list of groups to conference
users:                  <OrderedCollection> list of users to conference
configuration:
active:                 <Boolean> is the state of conference (active for register in conference)
invoiceNumber:          <Number> is an incremental number of invoices of conference
configurationOfHomePage: <ERConfigurationOfHomePage> object to update with html the principal page of page (principal page of logged user)
"
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
		'invoiceNumber',
		'configurationOfHomePage'
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

{ #category : #adding }
ERConference >> addAttendee: anAttendee [
	| anAttendeeSaved userSaved |
	self validateIfEmailIsAlreadyRegistered: anAttendee userAccount.
	userSaved := anAttendee userAccount save.
	self addUser: userSaved.
	anAttendeeSaved := (anAttendee userAccount: userSaved) save.
	attends add: anAttendeeSaved.
	self save.
	^ anAttendeeSaved
]

{ #category : #adding }
ERConference >> addGroup: aGroup [
	groups add: aGroup 
]

{ #category : #adding }
ERConference >> addPayPalComissionOn: amount [
	^ ((fee payPalCommissionPercentage)/100) * amount + (fee staticCommissionPaypal)
]

{ #category : #adding }
ERConference >> addReductionTicket: aReductionTicket [
	self reductionTicketAlreadyExist: aReductionTicket.
	aReductionTicket save.
	reductionTickets add: aReductionTicket .
	self save.
]

{ #category : #adding }
ERConference >> addSubmittedAward: aSubmittedAward [
	aSubmittedAward submittionDate: Date today.
	submittedAwards add: aSubmittedAward save.
	self save.
]

{ #category : #adding }
ERConference >> addSubmittedTalk: aSubmittedTalk [
	aSubmittedTalk submittionDate: Date today.
	submittedTalks add: aSubmittedTalk save.
	self save.
]

{ #category : #adding }
ERConference >> addUser: anUser [
	users add: anUser 
]

{ #category : #search }
ERConference >> attendeeFromUser: anUser [
	^ attends detect: [ :each | 
					each userAccount = anUser ]
				 ifNone: [ ERException notFoundAttendeeFromUser signal ]
]

{ #category : #search }
ERConference >> attendeesForATicket: ticketId [
	^ self attends select: [ :each | each paymentInformation coupon = ticketId ]
]

{ #category : #search }
ERConference >> attendeesForATicket: ticket except: anAttendee [
	^ self attends select: [ :each |  
		each paymentInformation coupon = ticket ticketId and: [ each ~= anAttendee ] ]
]

{ #category : #accessing }
ERConference >> attendeesWhoDidNotPaid [
	^ attends reject: [ :each | each paymentInformation hasPaid ] 
]

{ #category : #accessing }
ERConference >> attendeesWhoPaid [
	^ attends select: [ :each | each paymentInformation hasPaid ]
]

{ #category : #accessing }
ERConference >> attends [
	^ attends
]

{ #category : #accessing }
ERConference >> attends: anObject [
	attends := anObject
]

{ #category : #action }
ERConference >> closeRegistration [
	self configuration openRegistration: false.
	self save.
]

{ #category : #action }
ERConference >> conferenceIsOpenRegistration [
	^ self configuration openRegistration
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
ERConference >> configurationOfHomePage [
	^ configurationOfHomePage
]

{ #category : #accessing }
ERConference >> configurationOfHomePage: anObject [
	configurationOfHomePage := anObject
]

{ #category : #action }
ERConference >> costPerExtraPerson: anAttendee [
	anAttendee conferenceInformation addPersonToSocialDinner ifFalse: [ ^ 0 ]
	ifTrue: [ ^ fee extraPersonSD asNumber]
]

{ #category : #action }
ERConference >> decreaseCouponAmountFor: amount to: anAttendee [
	anAttendee hasCoupon
		ifTrue: [ | coupon |
			coupon := self reductionTicketWithName: anAttendee paymentInformation coupon.
		^ coupon obtainNewAmountAfterDiscountFor: amount ].
	^ amount
]

{ #category : #deleting }
ERConference >> deleteAttendee: anAttendee [
	self attends removeAllSuchThat: [ :each | anAttendee id = each id ].
]

{ #category : #deleting }
ERConference >> deleteAttendeeFromGroupAndConference: anAttendee [
	anAttendee idGroup isNotNil ifTrue: [ 
		|group|
		group := self getGroupOfAttendee: anAttendee.
		group deleteAttendee: anAttendee; save].
	self deleteAttendee: anAttendee.
	anAttendee delete.
	self save
]

{ #category : #deleting }
ERConference >> deleteAward: anAward [
	self submittedAwards removeAllSuchThat: [ :each | anAward id = each id ].
	self save.
]

{ #category : #deleting }
ERConference >> deleteTalk: aTalk [
	self submittedTalks removeAllSuchThat: [ :each | aTalk id = each id ].
	self save.
]

{ #category : #deleting }
ERConference >> deleteUser: anUser [
	self users removeAllSuchThat: [ :each | anUser id = each id ].
	self save.
	anUser delete
]

{ #category : #configurationStatistics }
ERConference >> dictionaryForLunch [
	|dic|
	dic := OrderedDictionary new.
	#(#monday #tuesday #wednesday #thursday #friday) do: [ :each |
		dic at: each put: self dictionaryOfFoodPreference ].
	^ dic
]

{ #category : #configurationStatistics }
ERConference >> dictionaryOfFoodPreference [
	^ Dictionary new 	
		at: 'Vegan' put: 0;
		at: 'Normal' put: 0;
		at: 'Vegetarian' put: 0;
		yourself 
]

{ #category : #configurationStatistics }
ERConference >> dictionaryOfShirts [
	|dict|
	dict := OrderedDictionary new.
	ERRegisterConferenceInformation tShirtSizes do: [ :each | dict at: each put: 
		(Dictionary new at: 'Male' put: 0; 
		at: 'Female' put: 0; yourself) ].
	^ dict
]

{ #category : #validations }
ERConference >> existReductionTicketWithName: aString [
	^ reductionTickets anySatisfy: [ :each | each ticketId = aString  ]
]

{ #category : #exporting }
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

{ #category : #exporting }
ERConference >> exportAttends: list in: fileName [
	| cvs |
	cvs := String
		streamContents: [ :out | 
			| neoWriter |
			neoWriter := NeoCSVWriter on: out.
			neoWriter writeHeader: self headerAttendee.
			list do: [ :each | 
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

{ #category : #exporting }
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

{ #category : #exporting }
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

{ #category : #exporting }
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

{ #category : #exporting }
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

{ #category : #filtering }
ERConference >> filterAttendsBy: aSymbol beginsWith: aString [
	^ self attends select: 
		[ :att | (att userAccount perform: aSymbol) asLowercase 
		beginsWith: aString asLowercase ]

]

{ #category : #filtering }
ERConference >> filterAttendsByEmailWith: aString [
	^ self filterAttendsBy: #email beginsWith: aString
]

{ #category : #filtering }
ERConference >> filterAttendsByFirstNameWith: aString [
	^ self filterAttendsBy: #firstName beginsWith: aString
]

{ #category : #filtering }
ERConference >> filterAttendsByLastNameWith: aString [
	^ self filterAttendsBy: #lastName beginsWith: aString
]

{ #category : #search }
ERConference >> findUserByEmail: aString [
	^ users detect: [ :each | each email = aString ] ifNone: nil.
]

{ #category : #configurationStatistics }
ERConference >> flat: dictionary with: aString [
	|list|
	list := OrderedCollection new.
	dictionary keysDo: [:key ||value|
		value := dictionary at: key.
		value at: aString put: key asString capitalized.
		list add: value].
	^ list
]

{ #category : #search }
ERConference >> getGroupOfAttendee: aAttendee [
	^ aAttendee idGroup 
	ifNotNil: [ self groups 
		detect: [ :aGroup | aGroup id = aAttendee idGroup ] 
		ifNone: [ nil ] ].
]

{ #category : #search }
ERConference >> groupOfUser: aGroupManager [
	^ self groups
		detect: [ :each | each groupManager userAccount = aGroupManager ].
]

{ #category : #accessing }
ERConference >> groups [
	^ groups
]

{ #category : #accessing }
ERConference >> groups: anObject [
	groups := anObject
]

{ #category : #header }
ERConference >> headerAttendee [
	^ #('InvoiceNumber' 'FirstName' 'LastName' 'Email' 'Country' 'Org. Name')
]

{ #category : #header }
ERConference >> headerGroups [
	^ #('Invoice Number' 'First Name' 'Last Name' 'Email' 'Org. Name' 'Org. Address1' 
	'Org. City' 'Org. Country' 'Org. Postal' 'Org. Membership')
]

{ #category : #header }
ERConference >> headerTalks [
	^ #('Name' 'Submitted By' 'Uploaded File')
]

{ #category : #header }
ERConference >> headerUser [
	^ #('id' 'firstName' 'lastName' 'email' 'password' 'role')
]

{ #category : #header }
ERConference >> headersParticipantsToLunches [
	^ #('Day' 'Normal' 'Vegetarian' 'Vegan' 'Total')	
]

{ #category : #header }
ERConference >> headersParticipantsToSocialDinner [ 
	^ #( 'Normal' 'Vegetarian' 'Vegan' 'Total')	
]

{ #category : #header }
ERConference >> headersShirtsStatistics [
	^ #('Size of the shirt' 'Female' 'Male' 'Total')
]

{ #category : #header }
ERConference >> hearderAwards [
	^ #('Name' 'Submitted by')
]

{ #category : #action }
ERConference >> incrementInvoiceNumber [
	^ invoiceNumber := self invoiceNumber +1
]

{ #category : #initialization }
ERConference >> initialize [
	super initialize.
	attends := OrderedCollection new.
	groups := OrderedCollection new.
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

{ #category : #accessing }
ERConference >> invoices [
	^ (self groups), 
	(self attends 
		select: [ :each | each idGroup isNil ])
]

{ #category : #action }
ERConference >> isEarlyRegistrationOf: anAttendee [
	^ self configuration earlyRegistrationDeadline 
		asDate > anAttendee createdOn asDate
]

{ #category : #action }
ERConference >> openRegistration [
	self configuration openRegistration: true.
	self save.
]

{ #category : #action }
ERConference >> payPalUrlFor: anAttendeeOrGroupManager [
	| conferenceFee url |
	conferenceFee := self paymentAmountFor: anAttendeeOrGroupManager.
	url := fee bankPayPalUrl.
	url := url
		copyReplaceAll: fee payPalAmountToken
		with: (conferenceFee printShowingDecimalPlaces: 2).
	url := url
		copyReplaceAll: fee payPalInvoiceNumberToken
		with:
			(anAttendeeOrGroupManager paymentInformation
				invoiceNumberIfNone: [ self incrementInvoiceNumber ])
				printString.
	^ url
]

{ #category : #action }
ERConference >> paymentAmountFor: anAttendee [
	|  amount |
	amount := (self priceAccordingToAttendanceDaysOf: anAttendee).
	amount := amount + (self costPerExtraPerson: anAttendee).
	amount := self decreaseCouponAmountFor: amount to: anAttendee.
	^ amount
]

{ #category : #action }
ERConference >> priceAccordingToAttendanceDaysOf: anAttendee [
	|daysOfAssistance |
	daysOfAssistance := anAttendee daysOfAssistance.
	(daysOfAssistance < 5) ifTrue: 
		[ ^ self priceForNDays: daysOfAssistance of: anAttendee ].
	^ self priceForAllDaysOf: anAttendee
	
]

{ #category : #action }
ERConference >> priceForAllDaysOf: anAttendee [
	(self isEarlyRegistrationOf: anAttendee)
		ifTrue: [ ^ fee erfAllDaysFee ].
		^ fee lrfAllDaysFee
]

{ #category : #action }
ERConference >> priceForNDays: aNumber of: anAttendee [
	(self isEarlyRegistrationOf: anAttendee) 
		ifTrue: [ ^ fee erfOneDayFee * aNumber ].
		^ fee lrfOneDayFee * aNumber 
]

{ #category : #search }
ERConference >> reductionTicketAlreadyExist: aReductionTicket [
	self reductionTickets
		do: [ :each | 
			aReductionTicket ticketId = each ticketId
				ifTrue: [ each = aReductionTicket ifFalse: [
						ERException ticketWithIdAlreadyExist signal ] ] ]
]

{ #category : #search }
ERConference >> reductionTicketWithName: aString [
	[ ^ self reductionTickets detect: [ :each | 
			each ticketId = aString] ]
	on: NotFound 
	do: [ ERException invalidTicketId
		signal ]
]

{ #category : #accessing }
ERConference >> reductionTickets [
	^ reductionTickets
]

{ #category : #accessing }
ERConference >> reductionTickets: anObject [
	reductionTickets := anObject
]

{ #category : #action }
ERConference >> senderEmailAddress [
	^ self configuration emailConfiguration senderEmailAddress
]

{ #category : #configurationStatistics }
ERConference >> statisticsOfLuch [
	|dict|
	dict := self dictionaryForLunch.
	self attends do: [ :att |
		dict := att conferenceInformation addMyPreferenceForLuchTo: dict ].
	dict := self flat: dict with: 'Day'. 
	dict := self sumEachRowOf: dict.
	dict := self sumEachColumnOf: dict withHeader: self headersParticipantsToLunches .
	^ dict 
]

{ #category : #configurationStatistics }
ERConference >> statisticsOfSocialDinner [
	|dict|
	dict := self dictionaryOfFoodPreference.
	self attends do: [ :att |
		dict := att conferenceInformation addMyPreferenceForSocialDinnerTo: dict ].
	dict := OrderedCollection with: dict.
	dict := self sumEachRowOf: dict.
	^ dict
]

{ #category : #configurationStatistics }
ERConference >> statisticsOfTShirts [
	|dict|
	dict := self dictionaryOfShirts.
	self attends do: [ :att |
		dict := att conferenceInformation addMytShirtTo: dict ].
	dict := self flat: dict with: 'Size of the shirt'.
	dict := self sumEachRowOf: dict.
	dict := self sumEachColumnOf: dict withHeader: self headersShirtsStatistics.
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

{ #category : #search }
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

{ #category : #search }
ERConference >> submittedTalksFor: anAttendee [
	^ self submittedTalks select: [ :each | each submitter = anAttendee ]
]

{ #category : #configurationStatistics }
ERConference >> sumEachColumnOf: aList withHeader: header [
	|dict|
	dict := Dictionary new.
	dict at: header first put: 'Total'.
	header do: [ :aString | aString = header first 
		ifFalse: [ dict at: aString put: (aList collect: [ :each | each at: aString ])sum ] ].
	aList add: dict.
	^ aList
]

{ #category : #configurationStatistics }
ERConference >> sumEachRowOf: aList [
	aList do: [ :li | li at: 'Total' put: 
		(li select: [ :each | each isString not ]) sum  ].
	^ aList
]

{ #category : #accessing }
ERConference >> users [
	^ users
]

{ #category : #accessing }
ERConference >> users: anObject [
	users := anObject
]

{ #category : #validations }
ERConference >> validateIfEmailIsAlreadyRegistered: anUser [
	self users
		do: [ :each | 
			each email = anUser email
				ifTrue: [each = anUser ifFalse:[
					ERException emailAlreadyRegistered signal ] ]].
]

{ #category : #validations }
ERConference >> validateIfTicketIDIsAlreadyRegistered: aTicket [
	reductionTickets 
		do: [ :each | 
			each ticketId = aTicket ticketId
				ifTrue: [ each = aTicket ifFalse: [
					ERException ticketIdAlreadyRegistered signal ]]]
]

{ #category : #validations }
ERConference >> validateLoginFor: aString1 password: aString2 [
	^ users detect: [:each | each email = aString1 and: [each password = aString2]] 
			ifNone: [ nil ]
	
]

{ #category : #validations }
ERConference >> verifyIfTicket: ticket canApplyTo: anAttendee [
	ticket limitStrategyIsUnlimited ifTrue: [ ^ true ].
	ticket limitStrategyIsLimited ifTrue: 
	[ ((self attendeesForATicket: ticket except: anAttendee) size < ticket limitStrategy limit) ifTrue: [ ^ true ]
	ifFalse: [ ERException ticketWasExceeded signal ] ]
]
