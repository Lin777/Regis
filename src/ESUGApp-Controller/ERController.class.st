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
	ERException new
		messageText: 'The ticket does not have a limit strategy allowed.';
		signal
]

{ #category : #'as yet unclassified' }
ERController >> amountForCurrentDateFor: aFee [
	| currentDate |
	currentDate := Date today.
	conference configuration earlyRegistrationDeadline < Date today
		ifTrue: [ ^ aFee lrfAllDaysFee ]
		ifFalse: [ ^ aFee erfAllDaysFee ].
	^ ERException new
		messageText: 'An error occurred when calculating the payment amount.'; raised
]

{ #category : #'as yet unclassified' }
ERController >> amountOfPayToGroup: list [
	| generalAmount |
	generalAmount := 0.
	list
		do: [ :each | 
			| fee amount |
			fee := self feePerTypeCurrencyOf: each.
			amount := self amountForCurrentDateFor: fee.
			amount := self decreaseCouponAmountFor: amount to: each.
			generalAmount := generalAmount + amount ].
	^ generalAmount
]

{ #category : #'as yet unclassified' }
ERController >> applyReductionTicketTo: anAttendee [
	| reductionTicket |
	reductionTicket := self reductionTicketWithName: anAttendee coupon.
	self add: anAttendee ToTicket: reductionTicket.
	anAttendee save.
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
			coupon := self reductionTicketWithName: anAttendee coupon.
		^ coupon obtainNewAmountAfterDiscountFor: amount ].
	^ amount
]

{ #category : #'as yet unclassified' }
ERController >> feeForCurrencyType: paymentCurrency [
	conference fees do: [ :fee | fee currency = paymentCurrency ifTrue: [ ^ fee ] ].
	ERException new messageText: 'The payment currency is not available now.'; signal
]

{ #category : #'as yet unclassified' }
ERController >> feePerTypeCurrencyOf: anAttendee [
	^ self feeForCurrencyType: anAttendee paymentCurrency
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
			(anAttendeeOrGroupManager
				invoiceNumberIfNone: [ conference incrementInvoiceNumber ])
				printString.
	^ url
]

{ #category : #action }
ERController >> reductionTicketWithName: aString [
	conference reductionTickets
		do: [ :each | 
			each ticketId = aString
				ifTrue: [ ^ each ] ].
	ERException new messageText: 'There is no ticket with the ticket id provided.'; signal
]

{ #category : #'as yet unclassified' }
ERController >> updateUser: anUser [
	self validatePatternForRequired: anUser email withName: 'Email'.
	self
		validatePatternForRequired: anUser firstName
		withName: 'First name'.
	self
		validatePatternForRequired: anUser lastName
		withName: 'Last name'.
	self validatePatternEmail: anUser email withName: 'Email'.
	self validateIfEmailIsAlreadyRegistered: anUser.
	
	^ anUser save
]

{ #category : #'as yet unclassified' }
ERController >> updateUser: anUser to: anAttendee [
	anAttendee
		userAccount: (self updateUser: anUser).
	anAttendee save
]

{ #category : #'as yet unclassified' }
ERController >> validateCountry: aString withName: aString2 [
	self validatePatternForRequired: aString withName: aString2.
	aString = 'Select Country'
		ifTrue: [ ERException new
				messageText: 'Please select a ',aString2 ;
				signal ]
]

{ #category : #action }
ERController >> validateIfEmailIsAlreadyRegistered: anUser [
	conference users
		do: [ :each | 
			each email = anUser email
				ifTrue: [ 
					each = anUser ifFalse:[
					ERException new
						messageText: 'This email is already registered';
						signal ] ]]
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
