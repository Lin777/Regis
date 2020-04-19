"
Description
--------------------

I am a controller for registration page.

Instance Variables
--------------------
	attendee: an ERAttendee will registered 
"
Class {
	#name : #ERRegistrationController,
	#superclass : #ERController,
	#instVars : [
		'attendee'
	],
	#category : #'ESUGApp-Controller'
}

{ #category : #'instance creation' }
ERRegistrationController class >> attendee: anAtteendee [
	|controller|
	controller := self new.
	controller attendee: anAtteendee .
	^ controller 
]

{ #category : #accessing }
ERRegistrationController >> attendee [
	^ attendee
]

{ #category : #accessing }
ERRegistrationController >> attendee: anObject [
	attendee := anObject 
]

{ #category : #initialize }
ERRegistrationController >> initialize [
	super initialize.
	attendee := ERAttendee new.
]

{ #category : #saving }
ERRegistrationController >> save [
	| user |
	conference validateIfEmailIsAlreadyRegistered: attendee userAccount.
	self attendee userAccount password: (ERUserAccount hashPassword: self attendee userAccount password)asString.
	self attendee userAccount confirmPassword: ''.
	user := self attendee userAccount save.
	conference addNewUser: user.
	^ user
]

{ #category : #saving }
ERRegistrationController >> saveAttendee [
	| savedAttendee |
	self attendee paymentInformation invoiceNumberIfNone: [ conference incrementInvoiceNumber ].
	self updatePaymentRate: self attendee.
	savedAttendee := self addAttendee: attendee.
	^ savedAttendee userAccount 
]

{ #category : #saving }
ERRegistrationController >> saveGroupManager [
	| groupSaved |
	self attendee userAccount: self save.
	groupSaved := self attendee.
	groupSaved paymentInformation invoiceNumberIfNone: [ conference incrementInvoiceNumber ]. 		
	groupSaved := groupSaved save.
	conference addGroup: groupSaved.
	self notifyAllObservers.
	^ self attendee userAccount
]

{ #category : #validations }
ERRegistrationController >> validatePatternPassword: aSymbol [
	(((attendee perform: aSymbol)
		matchesRegex: '[A-Za-z0-9._]{8,}')
		and: [ (attendee perform: aSymbol) size >= 8 ])
		ifFalse: [ ERException passwordFormatException signal ]
]

{ #category : #validations }
ERRegistrationController >> validateRegister [
	self validateRegister: attendee
]
