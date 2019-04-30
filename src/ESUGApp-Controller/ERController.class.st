"
Description
--------------------

I am a controller for page.

Instance Variables
--------------------
	conference:  is a ERConference object (with active state)
"
Class {
	#name : #ERController,
	#superclass : #ERSubject,
	#instVars : [
		'conference'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'ESUGApp-Controller'
}

{ #category : #adding }
ERController >> addAttendee: anAttendee [
	| anAttendeeSaved |
	anAttendee userAccount encryptMyPassword.
	anAttendeeSaved := conference addAttendee: anAttendee.
	self notifyAllObservers.
	^ anAttendeeSaved
]

{ #category : #adding }
ERController >> addAward: anAward [
	conference addSubmittedAward: anAward.
	self notifyAllObservers .
]

{ #category : #adding }
ERController >> addTalk: aTalk [
	conference addSubmittedTalk: aTalk.
	self notifyAllObservers .
]

{ #category : #updating }
ERController >> applyReductionTicket: aTicket To: anAttendee [
	|ticket|
	aTicket = 'No reduction ticket'
	ifTrue: [ anAttendee paymentInformation coupon: '' ]
	ifFalse: [ ticket := conference reductionTicketWithName: aTicket.
		(conference verifyIfTicket: ticket canApplyTo: anAttendee) 
		ifTrue: [anAttendee paymentInformation coupon: aTicket]].
	self updateAttendee: anAttendee.
]

{ #category : #cleaning }
ERController >> cleanSubDirectory: aSubDir [
	aSubDir ensureDeleteAll 
]

{ #category : #cleaning }
ERController >> cleanZip: zip with: zipFile subDir: subDir [
	[ zip close ]
		ensure: [ 
			subDir ensureDeleteAll.
			zipFile ensureDelete.	
		]
]

{ #category : #encoding }
ERController >> codingZipFile: aString with: nameSubDirectory [
	| zip subDir zipFile codingZipFile |
	zip := ZipArchive new.
	subDir := aString asFileReference.
	subDir ensureCreateDirectory.
	zip addDirectory: subDir.
	zipFile := aString asFileReference, 'zip'.
	self cleanZip: zip with: zipFile subDir: subDir.
	nameSubDirectory asFileReference files do: [ :aFile | zip addFile: aFile path asFileReference as: aString, '/', (aFile path at: 2) ].
	zip writeToFileNamed: zipFile fullName.
	codingZipFile := self encodeFiletoBase64: zipFile.
	self cleanZip: zip with: zipFile subDir: subDir.
	self cleanSubDirectory: nameSubDirectory asFileReference.
	^ codingZipFile 
]

{ #category : #accessing }
ERController >> conference [
	^ conference
]

{ #category : #accessing }
ERController >> conference: anObject [
	conference := anObject
]

{ #category : #deleting }
ERController >> deleteAward: anAward [
	conference deleteAward: anAward.
	self notifyAllObservers 
]

{ #category : #deleting }
ERController >> deleteTalk: aTalk [
	conference deleteTalk: aTalk.
	self notifyAllObservers 
]

{ #category : #encoding }
ERController >> encodeFileToUTF8: aFile [
	^ aFile exists 
		ifTrue: [ (ZnUTF8Encoder new encodeString: aFile binaryReadStream upToEnd asString) asString ] 
		ifFalse: [ nil ]. 
]

{ #category : #encoding }
ERController >> encodeFiletoBase64: aFile [
	^ aFile exists 
		ifTrue: [ ZnBase64Encoder new encode: aFile binaryReadStream upToEnd ] 
		ifFalse: [ nil ]. 
]

{ #category : #initialization }
ERController >> initialize [
	super initialize.
	ERBackupObserver of: self.
	conference := ERConference find: [ :each | each active ]
]

{ #category : #action }
ERController >> payPalUrlForGroup: aGroup [
	^ conference fee urlWithAmount: aGroup paymentInformation paymentAmount asString
	 invoiceNumber: (aGroup paymentInformation 
				invoiceNumberIfNone: [ conference incrementInvoiceNumber ])
				printString
]

{ #category : #action }
ERController >> sendInvoiceTo: user [
	|stream |
	stream := NeoJSONWriter toString: (ERInvoiceMailSender on: user) value.
	PMInterface new 
		apiKey: self conference configuration emailConfiguration apiKey; 
		send: stream.
]

{ #category : #action }
ERController >> sendResetPasswordTo: aString [
	| user stream |
	user := conference findUserByEmail: aString.
	user ifNil: [ ERException emailDoesNotExistToResetPassword signal ].
	stream := NeoJSONWriter toString: (ERResetPasswordMailSender on: user) value.
	[PMInterface new 
		apiKey: conference configuration emailConfiguration apiKey; 
		send: stream.
	user save.
	self notifyAllObservers ]
	on: ERException 
	do: [ :exc | user abortChanges ]
	
]

{ #category : #updating }
ERController >> stateUpdatePaidAttendee: anAttendee with: aBoolean [
	anAttendee stateUpdatePaidWith: aBoolean actions: { [ :att | self updateGroup: att ] . [ :att | self updateAttendee: att ] }
]

{ #category : #updating }
ERController >> updateAffiliation: aff on: aGroup [
	aGroup groupManager affiliationInformation: aff.
	aGroup save.
	self notifyAllObservers 
]

{ #category : #updating }
ERController >> updateAttendee: anAttendee [
	self verifyIfTheTicketIsStillAvailable: anAttendee.
	self updatePaymentRate: anAttendee.
	anAttendee save.
	anAttendee idGroup isNotNil ifTrue: [ self updateGroup: (conference getGroupOfAttendee: anAttendee) ].
	self notifyAllObservers .
	^ anAttendee 
]

{ #category : #updating }
ERController >> updateAward: anAward [
	anAward save.
	conference save.
	self notifyAllObservers 
]

{ #category : #updating }
ERController >> updateGroup: aGroup [
	self updatePaymentRateForGroup: aGroup.
	aGroup updateHasPaidOfAll.
	self notifyAllObservers .
	^ aGroup save.
]

{ #category : #updating }
ERController >> updatePaymentRate: anAttendee [
	|  amount |
	amount := conference paymentAmountFor: anAttendee .
	anAttendee paymentInformation paymentAmount: amount.
	anAttendee addPayPalComissionifApply: (conference addPayPalComissionOn: amount)
]

{ #category : #updating }
ERController >> updatePaymentRateForGroup: aGroup [ 
	aGroup updatePaymentRateWith: [:amount | conference addPayPalComissionOn: amount]
]

{ #category : #updating }
ERController >> updateTalk: aTalk [
	aTalk save.
	conference save.
	self notifyAllObservers 
]

{ #category : #updating }
ERController >> updateUser: anUser [
	[conference validateIfEmailIsAlreadyRegistered: anUser.
	anUser save.
	self notifyAllObservers .
	^ anUser]
	on: ERException 
	do: [ :exp | ^ exp signal ]
]

{ #category : #validations }
ERController >> validateNewPassword: aString1 with: aString2 [
	(aString1 = aString2) ifFalse: [ ERException passwordDoesNotMatchWithConfirmPass signal ].
]

{ #category : #validations }
ERController >> validateRegister: anAttendee [
	conference validateIfEmailIsAlreadyRegistered: anAttendee userAccount.
	self validateNewPassword: anAttendee userAccount password 
	with: anAttendee userAccount confirmPassword.
	anAttendee userAccount isAttendee ifFalse: [ ^ self ].
	self verifyIfTheTicketIsStillAvailable: anAttendee.
	self updatePaymentRate: anAttendee
]

{ #category : #action }
ERController >> verifyIfTheTicketIsStillAvailable: anAttendee [
	|coupon|
	coupon := anAttendee paymentInformation coupon.
	(coupon isNil or: [ coupon isEmpty ]) ifFalse: [
		self conference reductionTickets 
		detect: [ :each | each ticketId = coupon ] 
		ifFound: [ :ticket | conference verifyIfTicket: ticket canApplyTo: anAttendee ] 
		ifNone: [ ERException ticketDoesNotExist signal ]
	]
]
