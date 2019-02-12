Class {
	#name : #ERController,
	#superclass : #Object,
	#instVars : [
		'conference'
	],
	#category : #'ESUGApp-Controller'
}

{ #category : #'as yet unclassified' }
ERController class >> currencyAvailable [
	| list |
	list := OrderedCollection new.
	self new conference fees do: [ :fee | list add: fee currency ].
	^ list
]

{ #category : #adding }
ERController >> addAward: anAward [
	|award|
	
	anAward submittionDate: Date today.
	award := anAward save.
	conference addSubmittedAward: award.
	conference save
]

{ #category : #adding }
ERController >> addTalk: aTalk [
	|talk|
	aTalk submittionDate: Date today.
	talk := aTalk save.
	conference addSubmittedTalk: talk.
	conference save
]

{ #category : #adding }
ERController >> addUser: anUser [
	|userSaved|
	userSaved := (anUser as: ERUserAccount ).
	userSaved := userSaved save.
	conference addUser: userSaved.
	^ userSaved
]

{ #category : #rendering }
ERController >> allAttendeesHasPaid: aGroup [
	^ aGroup listAttends ifEmpty: [ false ] 
	ifNotEmpty: [ aGroup listAttends allSatisfy: [:attend | attend paymentInformation hasPaid ] ]
]

{ #category : #'as yet unclassified' }
ERController >> amountForCurrentDateFor: aFee [
	conference configuration earlyRegistrationDeadline asDate < Date today
		ifTrue: [ ^ aFee lrfAllDaysFee ]
		ifFalse: [ ^ aFee erfAllDaysFee ].
	^ ERException errorWhenCalculatingPaymentAmount raised
]

{ #category : #'as yet unclassified' }
ERController >> amountOfPayToGroup: list [
	| generalAmount |
	generalAmount := 0.
	list
		do: [ :each | 
			| amount |
			amount := self conferenceFeeFor: each.
			generalAmount := generalAmount + amount ].
	^ generalAmount.
	
]

{ #category : #'as yet unclassified' }
ERController >> applyReductionTicket: aTicket To: anAttendee [
	|ticket|
	aTicket = 'No reduction ticket'
	ifTrue: [ anAttendee paymentInformation coupon: '' ]
	ifFalse: [ ticket := self reductionTicketWithName: aTicket.
		(self verifyIfTicketCanApply: ticket) 
		ifTrue: [anAttendee paymentInformation coupon: aTicket].
		 ].
	anAttendee save.
]

{ #category : #'as yet unclassified' }
ERController >> attendeesForATicket: ticketId [
	^ conference attends select: [ :each | each paymentInformation coupon = ticketId ]
]

{ #category : #accessing }
ERController >> conference [
	^ conference
]

{ #category : #accessing }
ERController >> conference: anObject [
	conference := anObject
]

{ #category : #'as yet unclassified' }
ERController >> conferenceFeeFor: anAttendee [
	| fee amount |
	fee := self feePerTypeCurrencyOf: anAttendee.
	amount := self amountForCurrentDateFor: fee.
	amount := amount + (self costPerExtraPerson: anAttendee on: fee).
	^ self decreaseCouponAmountFor: amount to: anAttendee
]

{ #category : #accessing }
ERController >> conferenceIsOpenRegistration [
	^ self conference configuration openRegistration
]

{ #category : #'as yet unclassified' }
ERController >> costPerExtraPerson: anAttendee on: fee [
	anAttendee conferenceInformation addPersonToSocialDinner ifFalse: [ ^ 0 ]
	ifTrue: [ ^ fee extraPersonSD asNumber]
]

{ #category : #'as yet unclassified' }
ERController >> decreaseCouponAmountFor: amount to: anAttendee [
	anAttendee hasCoupon
		ifTrue: [ | coupon |
			coupon := self reductionTicketWithName: anAttendee paymentInformation coupon.
		^ coupon obtainNewAmountAfterDiscountFor: amount ].
	^ amount
]

{ #category : #rendering }
ERController >> deleteAttendee: anAttendee [
]

{ #category : #rendering }
ERController >> deleteGroupManager: aGroupManager [
]

{ #category : #rendering }
ERController >> deleteUser: anUser [
]

{ #category : #action }
ERController >> existReductionTicketWithName: aString [
	^ conference reductionTickets
		anySatisfy: [ :each | each ticketId = aString  ]
]

{ #category : #'as yet unclassified' }
ERController >> feeForCurrencyType: paymentCurrency [
	[ ^ conference fees detect: [ :fee | fee currency = paymentCurrency]]
	on: NotFound 
	do: [ ERException paymentCurrencyNotAvailable signal ]
]

{ #category : #'as yet unclassified' }
ERController >> feePerTypeCurrencyOf: anAttendee [
	^ self feeForCurrencyType: anAttendee paymentInformation paymentCurrency 
]

{ #category : #actions }
ERController >> findUserByEmail: aString [
	^ conference users 
		detect: [ :each | each email = aString ] 
    ifNone: nil.
]

{ #category : #'as yet unclassified' }
ERController >> getGroupOfAttendee: aAttendee [
	| groupOfAttendee |
	self conference groups detect: [ :aGroup | 
		aGroup listAttends detect: [ :aAtt | 
			aAtt userAccount = aAttendee userAccount ] 
		ifFound: [ :aAtt | groupOfAttendee := aGroup. true ]
		ifNone: [ false ]
	] ifNone: [ ].
	^ groupOfAttendee 
]

{ #category : #'as yet unclassified' }
ERController >> groupManagerAmountOfPay: aGroupManager [
	| fee amount |
	fee := self feePerTypeCurrencyOf: aGroupManager.
	amount := self amountForCurrentDateFor: fee.
	^ self decreaseCouponAmountFor: amount to: aGroupManager
]

{ #category : #accessing }
ERController >> initialize [
	super initialize.
	conference := ERConference find: [ :each | each active ]
]

{ #category : #'as yet unclassified' }
ERController >> payPalAmountToken [
	^ '[AMOUNT]'
]

{ #category : #'as yet unclassified' }
ERController >> payPalInvoiceNumberToken [
	^ '[INVOICENUMBER]'
]

{ #category : #'as yet unclassified' }
ERController >> payPalUrlFor: anAttendeeOrGroupManager [
	| conferenceFee url fee |
	conferenceFee := self conferenceFeeFor: anAttendeeOrGroupManager.
	fee := self feePerTypeCurrencyOf: anAttendeeOrGroupManager.
	url := fee bankPayPalUrl.
	url := url
		copyReplaceAll: fee payPalAmountToken
		with: (conferenceFee printShowingDecimalPlaces: 2).
	url := url
		copyReplaceAll: fee payPalInvoiceNumberToken
		with:
			(anAttendeeOrGroupManager paymentInformation
				invoiceNumberIfNone: [ conference incrementInvoiceNumber ])
				printString.
	^ url
]

{ #category : #'as yet unclassified' }
ERController >> payPalUrlForGroup: aGroup [
	| conferenceFee url fee |
	conferenceFee := self amountOfPayToGroup: aGroup listAttends .
	fee := self feePerTypeCurrencyOf: aGroup.
	url := fee bankPayPalUrl.
	url := url
		copyReplaceAll: fee payPalAmountToken
		with: (conferenceFee printShowingDecimalPlaces: 2).
	url := url
		copyReplaceAll: fee payPalInvoiceNumberToken
		with:
			(aGroup paymentInformation 
				invoiceNumberIfNone: [ conference incrementInvoiceNumber ])
				printString.
	^ url
]

{ #category : #action }
ERController >> reductionTicketWithName: aString [
	[ ^ conference reductionTickets detect: [ :each | 
			each ticketId = aString] ]
	on: NotFound 
	do: [ ERException invalidTicketId
		signal ]
]

{ #category : #'as yet unclassified' }
ERController >> stateUpdateNotPaidAttendees: aGroup [
	aGroup listAttends do: [ :attend | 
		self stateUpdatePaidAttendee: attend with: false
	].
	aGroup encodedInvoice: nil.
	aGroup paymentAmount: nil.
	aGroup save.
]

{ #category : #'as yet unclassified' }
ERController >> stateUpdatePaidAttendee: anAttendee with: aBoolean [
	anAttendee paymentInformation hasPaid: aBoolean.
	aBoolean ifFalse: [ 
		anAttendee encodedInvoice: nil.
		anAttendee paymentAmount: nil.	
	] ifTrue: [ 
		anAttendee paymentAmount: (self conferenceFeeFor: anAttendee).
	].
	anAttendee save.
]

{ #category : #'as yet unclassified' }
ERController >> stateUpdatePaidAttendees: aGroup [
	| generalAmount amount |
	generalAmount := 0.
	aGroup listAttends do: [ :attend | 
		attend paymentInformation hasPaid: true.
		amount := self conferenceFeeFor: attend.
		attend paymentAmount: amount.
		generalAmount := generalAmount + amount.
		attend save.
	].
	aGroup paymentAmount: generalAmount.
	aGroup save.
]

{ #category : #'as yet unclassified' }
ERController >> submittedAwardsFor: anAttendee [
	^ self conference submittedAwards 
  select: [ :each | each submitter = anAttendee ]
]

{ #category : #'as yet unclassified' }
ERController >> submittedTalksFor: anAttendee [
	^ self conference submittedTalks 
		select: [ :each | each submitter = anAttendee ]
]

{ #category : #'as yet unclassified' }
ERController >> updateAttendee: anAteendee [
	anAteendee save
]

{ #category : #'as yet unclassified' }
ERController >> updateUser: anUser [
	[self validateIfEmailIsAlreadyRegistered: anUser.
	^ anUser save]
	on: ERException 
	do: [ :exp | ^ exp ]
]

{ #category : #action }
ERController >> validateIfEmailIsAlreadyRegistered: anUser [
	conference users
		do: [ :each | 
			each email = anUser email
				ifTrue: [ Transcript show: 'True'.
					each = anUser ifFalse:[
						Transcript show: 'Exist'.
					ERException emailAlreadyRegistered signal ] ]]
]

{ #category : #rendering }
ERController >> validateLoginFor: aString1 password: aString2 [
	^  conference users 
			detect: [:each | each email = aString1 and: [each password = aString2]] 
			ifNone: nil
	
]

{ #category : #'as yet unclassified' }
ERController >> validateNewPassword: aString1 with: aString2 [
	(aString1 = aString2) ifFalse: [ ERException passwordDoesNotMatchWithConfirmPass signal ].
]

{ #category : #'as yet unclassified' }
ERController >> validateRegister: anAttendee [
	self validateIfEmailIsAlreadyRegistered: anAttendee  userAccount.
	self validateNewPassword: anAttendee userAccount password 
	with: anAttendee userAccount confirmPassword
]

{ #category : #action }
ERController >> verifyIfTheTicketIsStillAvailable: aString [
	ERController new conference reductionTickets 
	detect: [ :each | each ticketId = aString ] 
	ifFound: [ :ticket | self verifyIfTicketCanApply: ticket ] 
	ifNone: [ ERException ticketDoesNotExist signal ]
]

{ #category : #'as yet unclassified' }
ERController >> verifyIfTicketCanApply: ticket [
	ticket limitStrategyIsUnlimited ifTrue: [ ^ true ].
	ticket limitStrategyIsLimited ifTrue: 
	[ ((self attendeesForATicket: ticket ticketId) size 
	< ticket limitStrategy limit) ifTrue: [ ^ true ]
	ifFalse: [ 
		ERException ticketWasExceeded signal ] ]
]
