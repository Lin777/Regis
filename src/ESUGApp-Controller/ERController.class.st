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

{ #category : #'as yet unclassified' }
ERController >> add:attendee ToTicket: coupon [
	coupon limitStrategyIsLimited
		ifTrue: [ ^ coupon addAttendeeOfTicketLimited: attendee ].
	coupon limitStrategyIsUnlimited
		ifTrue: [ ^ coupon addAttendeeOfTicket: attendee ].
	ERException limitStrategyNotAllowedd signal
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
ERController >> applyReductionTicketTo: anAttendee [
	anAttendee save
]

{ #category : #'as yet unclassified' }
ERController >> attendeesForATicket: ticketId [
	^ conference attends select: [ :each | each coupon = ticketId ]
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
	^ self decreaseCouponAmountFor: amount to: anAttendee
]

{ #category : #accessing }
ERController >> conferenceIsOpenRegistration [
	^ self conference configuration openRegistration
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
ERController >> emailIsAlreadyRegistered: aString [
	^ conference users anySatisfy: [ :each | 
			each email = aString]
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

{ #category : #'as yet unclassified' }
ERController >> validateCountry: aString withName: aString2 [
	self validatePatternForRequired: aString withName: aString2.
	aString = 'Select Country'
		ifTrue: [ ERException new
				messageText: 'Please select a ', aString2 ;
				signal ]
]

{ #category : #action }
ERController >> validateIfEmailIsAlreadyRegistered: anUser [
	conference users
		do: [ :each | 
			each email = anUser email
				ifTrue: [ 
					each = anUser ifFalse:[
					ERException emailAlreadyRegistered signal ] ]]
]

{ #category : #'as yet unclassified' }
ERController >> validateNewPassword: aString1 with: aString2 [
	(aString1 = aString2) ifFalse: [ ERException passwordDoesNotMatchWithConfirmPass signal ].
]

{ #category : #'as yet unclassified' }
ERController >> validatePatternEmail: aString withName: aString2 [
	(aString matchesRegex: '\S+@\S+\.\S+')
		ifFalse: [ ERException new
				messageText: 'The field ' , aString2 , ' does not match with email format.';
				signal ]
]

{ #category : #'as yet unclassified' }
ERController >> validatePatternForRequired: aString withName: aString2 [
	(aString matchesRegex: '\S+[\S*\s*]*')
		ifFalse: [ ERException new
				messageText:
					'The field ' , aString2
						, ' is required please add content to it.';
				signal ]
]

{ #category : #'as yet unclassified' }
ERController >> validatePatternForText: aString withName: aString2 [
	(aString matchesRegex: '[(a-zA-Z)+\s*]{3,}')
		ifFalse: [ ERException new
				messageText: 'The field ' , aString2 , ' only accept a text.';
				signal ]
]

{ #category : #'as yet unclassified' }
ERController >> validateSelectValue: aString on: list withMessage: aString2 [
	(list includes: aString)
		ifFalse: [ ERException new
				messageText: 'The ' , aString2 , ' entered is not valid.';
				signal ]
]

{ #category : #'as yet unclassified' }
ERController >> verifyIfTicketCanApply: ticket [
	ticket limitStrategyIsUnlimited ifTrue: [ ^ true ].
	ticket limitStrategyIsLimited ifTrue: 
	[ ((self attendeesForATicket: ticket ticketId) size 
	<= ticket limitStrategy limit) ifTrue: [ ^ true ]
	ifFalse: [ 
		ERException ticketWasExceeded signal ] ]
]
