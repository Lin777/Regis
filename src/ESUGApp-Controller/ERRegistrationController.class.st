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
