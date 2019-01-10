Class {
	#name : #ERRegistrationController,
	#superclass : #ERController,
	#instVars : [
		'attendee'
	],
	#category : #'ESUGApp-Controllers'
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
	^ ERException new
		messageText: 'The ticket does not have a limit strategy allowed.';
		signal
]

{ #category : #action }
ERRegistrationController >> addAttendeeToTicketIfExist [
	| coupon |
	coupon := self reductionTicketWithName: attendee coupon.
	coupon isNil
		ifFalse: [ ^ self addAttendeeToTicket: coupon ].
	attendee coupon: ''.
	^ ERException new
		messageText: 'The ticket does not exist for this conference';
		signal
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
	| attendeeResult |
	attendeeResult := ERUserAccount
		findUserByEmail: attendee userAccount email.
	attendeeResult
		ifNil: [ "self verifyTicket."
			attendeeResult := self saveAttendee.
			attendeeResult userAccount isAttendee
				ifTrue: [ conference addAttendee: attendeeResult ].
			conference save.
			^ attendeeResult userAccount ].
	^ nil	"ERException new messageText: 'This email is already registered'"
]

{ #category : #action }
ERRegistrationController >> saveAsGroupManager [
	self convertToGroupManager.
	^ self save
]

{ #category : #action }
ERRegistrationController >> saveAttendee [
	| user |
	user := self attendee userAccount save.
	conference addUser: user.
	self attendee userAccount: user.
	^ self attendee save
]

{ #category : #'as yet unclassified' }
ERRegistrationController >> validateRegister [
	| attendeeResult |
	attendeeResult := ERUserAccount
		findUserByEmail: attendee userAccount email.
	attendeeResult ifNil: [ ^ self verifyTicket ].
	^ ERException new
		messageText: 'This email is already registered'; signal
]

{ #category : #'as yet unclassified' }
ERRegistrationController >> validateRegisterForGroupManager [
	| attendeeResult |
	attendeeResult := ERUserAccount
		findUserByEmail: attendee userAccount email.
	attendeeResult ifNil: [ ^ nil ].
	^ ERException new
		messageText: 'This email is already registered';
		signal
]

{ #category : #action }
ERRegistrationController >> verifyTicket [
	attendee hasCoupon ifTrue: [  ^ self addAttendeeToTicketIfExist ].
	^ nil
]
