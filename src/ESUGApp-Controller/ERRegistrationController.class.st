Class {
	#name : #ERRegistrationController,
	#superclass : #ERController,
	#instVars : [
		'attendee'
	],
	#category : #'ESUGApp-Controller'
}

{ #category : #accessing }
ERRegistrationController class >> attendee: anAtteendee [
	|controller|
	controller := self new.
	controller attendee: anAtteendee .
	^ controller 
]

{ #category : #action }
ERRegistrationController >> addAttendeeToTicket: coupon [
	coupon limitStrategyIsLimited
		ifTrue: [ ^ coupon addAttendeeOfTicketLimited: attendee ].
	coupon limitStrategyIsUnlimited
		ifTrue: [ ^ coupon addAttendeeOfTicket: attendee ].
	ERException limitStrategyNotAllowedd	signal
]

{ #category : #action }
ERRegistrationController >> addAttendeeToTicketIfExist [
	[ | coupon |
	coupon := self reductionTicketWithName: attendee coupon.
	self addAttendeeToTicket: coupon ]
		on: ERException
		do: [ attendee coupon: '' ]
]

{ #category : #action }
ERRegistrationController >> addAttendeeToTicketIfExist: anAttendee [
	[| coupon |
	coupon := self reductionTicketWithName: anAttendee paymentInformation coupon.
	self addAttendeeToTicket: coupon.] on: ERException do:[
	anAttendee paymentInformation coupon: ''].

]

{ #category : #accessing }
ERRegistrationController >> attendee [
	^ attendee
]

{ #category : #accessing }
ERRegistrationController >> attendee: anObject [
	attendee := anObject 
]

{ #category : #action }
ERRegistrationController >> convertToGroupManager [
	self attendee userAccount role: (Heap new add: 'groupManager'; yourself )
]

{ #category : #initialize }
ERRegistrationController >> initialize [
	super initialize.
	attendee := ERAttendee new.
]

{ #category : #action }
ERRegistrationController >> save [
	| user|
	self validateIfEmailIsAlreadyRegistered: attendee userAccount.
	self attendee userAccount password: (ERUserAccount hashPassword: self attendee userAccount password)asString.
	user := self attendee userAccount save.
	conference addUser: user.
	^ user
]

{ #category : #action }
ERRegistrationController >> saveAttendee [
	|attendeeSaved|
	self attendee userAccount: self save.
	self attendee paymentInformation invoiceNumberIfNone: [ conference incrementInvoiceNumber ].
	self attendee conferenceInformation addPersonToSocialDinner ifFalse:
	 [ self attendee conferenceInformation personAddedFoodPreference: ''].
	attendeeSaved := self attendee save.
	conference addAttendee: attendeeSaved .
	conference save.
	^ attendeeSaved userAccount 
]

{ #category : #action }
ERRegistrationController >> saveGroupManager [
	|groupSaved|
	self attendee userAccount: self save.
	groupSaved := ERGroup groupManager: self attendee.
	groupSaved paymentInformation invoiceNumberIfNone: [ conference incrementInvoiceNumber ]. 		
	groupSaved := groupSaved save.
	conference addGroup: groupSaved .
	conference save.
	^ self attendee userAccount 
]

{ #category : #'as yet unclassified' }
ERRegistrationController >> validateIfTicketExist [
	attendee hasCoupon
		ifTrue: [ (self reductionTicketWithName: attendee coupon) isNil
				ifTrue: [ 
					ERException ticketDoesNotExist signal ] ]
]

{ #category : #'as yet unclassified' }
ERRegistrationController >> validatePatternPassword: aSymbol [
	(((attendee perform: aSymbol)
		matchesRegex: '[A-Za-z0-9._]{8,}')
		and: [ (attendee perform: aSymbol) size >= 8 ])
		ifFalse: [ ERException passwordFormatException signal ]
]

{ #category : #'as yet unclassified' }
ERRegistrationController >> validateRegister [
	self validateRegister: attendee
]
