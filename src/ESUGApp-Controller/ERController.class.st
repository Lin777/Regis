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
ERController >> amountForCurrentDateFor: aFee [
	| currentDate |
	currentDate := Date today.
	conference configuration earlyRegistrationDeadline < Date today
		ifTrue: [ ^ aFee lrfAllDaysFee ]
		ifFalse: [ ^ aFee erfAllDaysFee ].
	^ ERException new
		messageText: 'An error occurred when calculating the payment amount.'; raised
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
	^ nil
]
