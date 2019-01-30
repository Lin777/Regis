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
	ERException new
		messageText: 'The ticket does not have a limit strategy allowed.';
		signal
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
	attendee := ERAttendee1 new.
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
ERRegistrationController >> saveAsGroupManager [
	self convertToGroupManager.
	^ self save
]

{ #category : #action }
ERRegistrationController >> saveAttendee [
	|attendeeSaved|
	self attendee userAccount: self save.
	self attendee paymentInformation invoiceNumberIfNone: [ conference incrementInvoiceNumber ].
	attendeeSaved := self attendee save.
	conference addAttendee: attendeeSaved .
	conference save.
	^ attendeeSaved userAccount 
]

{ #category : #action }
ERRegistrationController >> saveGroupManager [
	|groupSaved|
	self attendee userAccount: self save.
	groupSaved := (ERGroup1 groupManager: self attendee) paymentInformation invoiceNumberIfNone: [ conference incrementInvoiceNumber ]; save.
	conference addGroup: groupSaved .
	conference save.
	^ self attendee userAccount 
]

{ #category : #'as yet unclassified' }
ERRegistrationController >> validateAdditionalForm [
	
]

{ #category : #'as yet unclassified' }
ERRegistrationController >> validateAffiliationForm [
	self
		validatePatternForRequired: attendee orgName
		withName: 'ORGANIZATION NAME'.
	self
		validatePatternForRequired: attendee orgAddrees1
		withName: 'ORGANIZATION ADDRESS 1'.
	self
		validatePatternForRequired: attendee orgCity
		withName: 'ORGANIZATION CITY'.
	self
		validateCountry: attendee orgCountry
		withName: 'ORGANIZATION COUNTRY'.
	self
		validatePatternForRequired: attendee orgProvince
		withName: 'ORGANIZATION PROVINCE'.
	self
		validatePatternForRequired: attendee orgPostal
		withName: 'ORGANIZATION POSTAL'.
	self
		validateSelectValue: attendee membershipType
		on: ERAttendee membershipTypes
		withMessage: 'MEMBERSHIP TYPE'
]

{ #category : #'as yet unclassified' }
ERRegistrationController >> validateConferenceForm [
	self
		validateSelectValue: attendee gender
		on: ERAttendee genders
		withMessage: 'GENDER'.
	self
		validateSelectValue: attendee tshirtSize
		on: ERAttendee tShirtSizes
		withMessage: 'T-SHIRT SIZE'.
	self
		validateSelectValue: attendee foodPreference
		on: ERAttendee foodPreferences
		withMessage: 'FOOD PREFERENCE'
]

{ #category : #'as yet unclassified' }
ERRegistrationController >> validateContactForm [
	self validatePatternForRequired: attendee address withName: 'ADDRESS'.
	self validatePatternForRequired: attendee city withName: 'CITY'.
	self validatePatternForRequired: attendee province withName: 'PROVINCE'.
	self validatePatternForRequired: attendee postal withName: 'POSTAL'.
	self validateCountry: attendee country withName: 'COUNTRY'.
	attendee facebookURL isEmpty
		ifFalse: [ self validatePatternUrl: #facebookURL ].
	attendee twitterURL isEmpty
		ifFalse: [ self validatePatternUrl: #twitterURL ].
	attendee homePage isEmpty
		ifFalse: [ self validatePatternUrl: #homePage ]
]

{ #category : #'as yet unclassified' }
ERRegistrationController >> validateCountry: aSymbol [
	self validatePatternForRequired: aSymbol.
	(attendee perform: aSymbol) = 'Select Country'
		ifTrue: [ ERException new
				messageText: 'Please select a country';
				signal ]
]

{ #category : #action }
ERRegistrationController >> validateEmail [
	self validatePatternForRequired: attendee email withName: 'EMAIL'.
	self validatePatternEmail: attendee email withName: 'EMAIL'
]

{ #category : #action }
ERRegistrationController >> validateFirstName [
	self
		validatePatternForRequired: attendee firstName
		withName: 'FIRST NAME'.
	self
		validatePatternForText: attendee firstName
		withName: 'FIRST NAME'.
]

{ #category : #'as yet unclassified' }
ERRegistrationController >> validateIfTicketExist [
	attendee hasCoupon
		ifTrue: [ (self reductionTicketWithName: attendee coupon) isNil
				ifTrue: [ 
					ERException new
						messageText: 'The ticket does not exist for this conference';
						signal ] ]
]

{ #category : #action }
ERRegistrationController >> validateLastName [
	self
		validatePatternForRequired: attendee lastName
		withName: 'LAST NAME'.
	self validatePatternForText: attendee lastName withName: 'LAST NAME'.
	
]

{ #category : #action }
ERRegistrationController >> validatePassword [
	self
		validatePatternForRequired: attendee password
		withName: 'PASSWORD'.
]

{ #category : #'as yet unclassified' }
ERRegistrationController >> validatePatternEmail: aSymbol [
	((attendee perform: aSymbol)
		matchesRegex:
			'\S+@\S+\.\S+')
		ifFalse: [ ERException new
				messageText:
					'The field ' , aSymbol asString , ' does not match with email format.';
				signal ]
]

{ #category : #'as yet unclassified' }
ERRegistrationController >> validatePatternForRequired: aSymbol [
	((attendee perform: aSymbol) matchesRegex: '\S+[\S*\s*]*')
		ifFalse: [ ERException new
				messageText:
					'The field ' , aSymbol asString
						, ' is required please add content to it.';
				signal ]
]

{ #category : #'as yet unclassified' }
ERRegistrationController >> validatePatternForText: aSymbol [
	((attendee perform: aSymbol) matchesRegex: '[(a-zA-Z)+\s*]{3,}')
		ifFalse: [ ERException new
				messageText: 'The field ' , aSymbol asString , ' only accept a text.';
				signal ]
]

{ #category : #'as yet unclassified' }
ERRegistrationController >> validatePatternPassword: aSymbol [
	(((attendee perform: aSymbol)
		matchesRegex: '[A-Za-z0-9._]{8,}')
		and: [ (attendee perform: aSymbol) size >= 8 ])
		ifFalse: [ ERException new
				messageText:
					'The password must have at least 8 characters, and only accepts letters, numbers, slash and dots.';signal ]
]

{ #category : #'as yet unclassified' }
ERRegistrationController >> validatePatternUrl: aSymbol [
	"((attendee perform: aSymbol)
		matchesRegex:
			'https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,4}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)')"
		((attendee perform: aSymbol)
		matchesRegex:
			'\S+')
		ifFalse: [ ERException new
				messageText: 'The field ' , aSymbol text , ' does not match with url format.';
				signal ]
]

{ #category : #'as yet unclassified' }
ERRegistrationController >> validatePaymentForm [
	self
		validateSelectValue: attendee paymentType
		on: ERAttendee paymentTypes
		withMessage: 'payment type'.
	self
		validateSelectValue: attendee paymentCurrency
		on: ERController currencyAvailable
		withMessage: 'payment currency'.
	self validateIfTicketExist
]

{ #category : #'as yet unclassified' }
ERRegistrationController >> validateRegister [
	self validateIfEmailIsAlreadyRegistered: attendee userAccount.
	self validateNewPassword: attendee userAccount password 
	with: attendee userAccount confirmPassword
]

{ #category : #'as yet unclassified' }
ERRegistrationController >> validateRegisterForGroupManager [
	self validateUserForm.
	self validateAffiliationForm
]

{ #category : #action }
ERRegistrationController >> validateUserForm [
	self validateFirstName.
	self validateLastName.
	self validateEmail.
	self validatePassword.
	self validateIfEmailIsAlreadyRegistered: attendee userAccount
	"self validatePatternForRequired: #password"
	"self validatePatternPassword: #password"
]

{ #category : #action }
ERRegistrationController >> verifyTicket [
	attendee hasCoupon ifTrue: [  ^ self addAttendeeToTicketIfExist ].
	^ nil
]
