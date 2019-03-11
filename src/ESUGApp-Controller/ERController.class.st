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

{ #category : #accessing }
ERController class >> uniqueInstance [ 
     uniqueInstance ifNil: [uniqueInstance := self new]. 
     ^ uniqueInstance
 
]

{ #category : #adding }
ERController >> addAward: anAward [
	|award|
	anAward submittionDate: Date today.
	award := anAward save.
	conference addSubmittedAward: award.
	conference save.
	self notifyAllObservers .
]

{ #category : #'as yet unclassified' }
ERController >> addPayPalComissionIfApplyOn: amount of: anAttendee [
	((self applyToAddComission: anAttendee )
		and: [ anAttendee paymentInformation paymentType = 'Credit Card' ])
		ifTrue: [ ^ (amount + (self addPayPalComissionOn: amount))].
	^ amount
]

{ #category : #'as yet unclassified' }
ERController >> addPayPalComissionOn: amount [

	^ ((conference fee payPalCommissionPercentage)/100) * amount + 
	(conference fee staticCommissionPaypal)
]

{ #category : #adding }
ERController >> addTalk: aTalk [
	|talk|
	aTalk submittionDate: Date today.
	talk := aTalk save.
	conference addSubmittedTalk: talk.
	conference save.
	self notifyAllObservers .
]

{ #category : #adding }
ERController >> addUser: anUser [
	|userSaved|
	userSaved := (anUser as: ERUserAccount ).
	userSaved := userSaved save.
	conference addUser: userSaved.
	self notifyAllObservers .
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
	self updateAttendee: anAttendee.
]

{ #category : #'as yet unclassified' }
ERController >> applyToAddComission: anObject [
	anObject userAccount isGroupManager ifTrue: [ ^ true ].
	^ anObject idGroup isNil
]

{ #category : #'as yet unclassified' }
ERController >> attendAllDays: anAttendee [
 ^ (anAttendee conferenceInformation attendance 
		values count: [ :each | each ]) = 5
]

{ #category : #'as yet unclassified' }
ERController >> attendeesForATicket: ticketId [
	^ conference attends select: [ :each | each paymentInformation coupon = ticketId ]
]

{ #category : #'as yet unclassified' }
ERController >> cleanSubDirectory: aSubDir [
	aSubDir ensureDeleteAll 
]

{ #category : #'as yet unclassified' }
ERController >> cleanZip: zip with: zipFile subDir: subDir [
	[ zip close ]
		ensure: [ 
			subDir ensureDeleteAll.
			zipFile ensureDelete.	
		]
]

{ #category : #'as yet unclassified' }
ERController >> codingZipFile: nameSubDirectory [
	| zip subDir zipFile codingZipFile |
	zip := ZipArchive new.
	zipFile := nameSubDirectory asFileReference, 'zip'.
	self cleanZip: zip with: zipFile subDir: subDir.
	nameSubDirectory asFileReference files do: [ :aFile | zip addFile: aFile path pathString ].
	zip writeToFileNamed: zipFile fullName.
	codingZipFile := self encodeFiletoBase64: zipFile.
	self cleanZip: zip with: zipFile subDir: subDir.
	self cleanSubDirectory: nameSubDirectory asFileReference.
	^ codingZipFile
]

{ #category : #'as yet unclassified' }
ERController >> codingZipFile: aString with: nameSubDirectory [
	| zip subDir zipFile codingZipFile |
	zip := ZipArchive new.
	subDir := aString asFileReference.
	subDir ensureCreateDirectory.
	zip addDirectory: subDir fullName.
	zipFile := aString asFileReference, 'zip'.
	self cleanZip: zip with: zipFile subDir: subDir.
	nameSubDirectory asFileReference files do: [ :aFile | zip addFile: aFile path pathString as: aString, '/', (aFile path at: 2) ].
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

{ #category : #'as yet unclassified' }
ERController >> conferenceFeeFor: anAttendee [
	| fee amount |
	fee := self conference fee.
	amount := self amountForCurrentDateFor: fee.
	amount := amount + (self costPerExtraPerson: anAttendee on: fee).
	^ self decreaseCouponAmountFor: amount to: anAttendee
]

{ #category : #accessing }
ERController >> conferenceIsOpenRegistration [
	^ self conference configuration openRegistration
]

{ #category : #'as yet unclassified' }
ERController >> costPerExtraPerson: anAttendee [ 
	anAttendee conferenceInformation addPersonToSocialDinner ifFalse: [ ^ 0 ]
	ifTrue: [ ^ conference fee extraPersonSD asNumber]
]

{ #category : #'as yet unclassified' }
ERController >> costPerExtraPerson: anAttendee on: fee [
	anAttendee conferenceInformation addPersonToSocialDinner ifFalse: [ ^ 0 ]
	ifTrue: [ ^ fee extraPersonSD asNumber]
]

{ #category : #'as yet unclassified' }
ERController >> daysOfAssistanceOf: anAttendee [
 ^ (anAttendee conferenceInformation attendance 
		values count: [ :each | each ])
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
ERController >> deleteGroup: aGroupManager [
	self notifyAllObservers .
]

{ #category : #rendering }
ERController >> deleteUser: anUser [
	self notifyAllObservers .
]

{ #category : #'as yet unclassified' }
ERController >> encodeFileToUTF8: aFile [
	^ aFile exists 
		ifTrue: [ (ZnUTF8Encoder new encodeString: aFile binaryReadStream upToEnd asString) asString ] 
		ifFalse: [ nil ]. 
]

{ #category : #'as yet unclassified' }
ERController >> encodeFiletoBase64: aFile [
	^ aFile exists 
		ifTrue: [ ZnBase64Encoder new encode: aFile binaryReadStream upToEnd ] 
		ifFalse: [ nil ]. 
]

{ #category : #action }
ERController >> existReductionTicketWithName: aString [
	^ conference reductionTickets
		anySatisfy: [ :each | each ticketId = aString  ]
]

{ #category : #actions }
ERController >> findUserByEmail: aString [
	^ conference users 
		detect: [ :each | each email = aString ] 
    ifNone: nil.
]

{ #category : #'as yet unclassified' }
ERController >> getGroupOfAttendee: aAttendee [
	^ aAttendee idGroup 
	ifNotNil: [ self conference groups 
		detect: [ :aGroup | aGroup id = aAttendee idGroup ] 
		ifNone: [ nil ] ].
]

{ #category : #accessing }
ERController >> initialize [
	super initialize.
	ERBackupObserver of: self.
	conference := ERConference find: [ :each | each active ]
]

{ #category : #'as yet unclassified' }
ERController >> isEarlyRegistrationOf: anAttendee [
	^ conference configuration earlyRegistrationDeadline 
		asDate > anAttendee createdOn asDate
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
	fee := conference fee .
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
	fee := conference fee.
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

{ #category : #'as yet unclassified' }
ERController >> paymentRateFor: anAttendee [
	conference configuration earlyRegistrationDeadline 
		asDate < anAttendee createdOn asDate
		ifTrue: [ ^ conference fee lrfAllDaysFee ]
		ifFalse: [ ^ conference fee erfAllDaysFee ].
	^ ERException errorWhenCalculatingPaymentAmount raised
]

{ #category : #'as yet unclassified' }
ERController >> priceAccordingToAttendanceDaysOf: anAttendee [
	|daysOfAssistance |
	daysOfAssistance := self daysOfAssistanceOf: anAttendee.
	(daysOfAssistance < 5) ifTrue: 
		[ ^ self priceForNDays: daysOfAssistance Of: anAttendee ].
	^ self priceForAllDaysOf: anAttendee
	
]

{ #category : #'as yet unclassified' }
ERController >> priceForAllDaysOf: anAttendee [
	(self isEarlyRegistrationOf: anAttendee)
		ifTrue: [ ^ conference fee erfAllDaysFee ].
		^ conference fee lrfAllDaysFee
]

{ #category : #'as yet unclassified' }
ERController >> priceForNDays: aNumber Of: anAttendee [
	(self isEarlyRegistrationOf: anAttendee) 
		ifTrue: [ ^ conference fee erfOneDayFee * aNumber ].
		^ conference fee lrfOneDayFee * aNumber 
]

{ #category : #action }
ERController >> reductionTicketWithName: aString [
	[ ^ conference reductionTickets detect: [ :each | 
			each ticketId = aString] ]
	on: NotFound 
	do: [ ERException invalidTicketId
		signal ]
]

{ #category : #rendering }
ERController >> sendInvoiceTo: user [
	|stream |
	stream := NeoJSONWriter toString: (ERInvoiceMailSender on: user) value.
	PMInterface new 
		apiKey: self conference configuration emailConfiguration apiKey; 
		send: stream.
]

{ #category : #'as yet unclassified' }
ERController >> sendResetPasswordTo: aString [
	| user stream |
	user := self findUserByEmail: aString.
	user ifNil: [ ERException emailDoesNotExistToResetPassword signal ].
	stream := NeoJSONWriter toString: (ERResetPasswordMailSender on: user) value.
	PMInterface new 
		apiKey: '3d9cd16a-3d91-4a2d-a4e3-1c8644767d71'; 
		send: stream.
]

{ #category : #rendering }
ERController >> senderEmailAddress [
	^ self conference configuration emailConfiguration senderEmailAddress
]

{ #category : #'as yet unclassified' }
ERController >> stateUpdateNotPaidAttendees: aGroup [
	aGroup listAttends do: [ :attend | 
		self stateUpdatePaidAttendee: attend with: false
	].
	aGroup paymentAmount: nil.
	aGroup save.
]

{ #category : #'as yet unclassified' }
ERController >> stateUpdatePaidAttendee: anAttendee with: aBoolean [
	anAttendee paymentInformation hasPaid: aBoolean.
	anAttendee userAccount isGroupManager ifTrue: [
		 self updateGroup: anAttendee
	]
	ifFalse: [ self updateAttendee: anAttendee ]
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
ERController >> updateAllAttendeesOf: aGroup [
	aGroup listAttends do: [ :each | each paymentInformation hasPaid: 
												aGroup paymentInformation hasPaid.
											  each save. ].
	self notifyAllObservers .
]

{ #category : #'as yet unclassified' }
ERController >> updateAttendee: anAttendee [
	self updatePaymentRate: anAttendee.
	"self generateInvoiceOf: anAttendee."
	anAttendee save.
	anAttendee idGroup isNotNil ifTrue: [ self updateGroup: (self getGroupOfAttendee: anAttendee) ].
	self notifyAllObservers .
]

{ #category : #'as yet unclassified' }
ERController >> updateGroup: aGroup [
	self updatePaymentRateForGroup: aGroup .
	"self generateInvoiceOf: aGroup."
	self updateAllAttendeesOf: aGroup.
	self notifyAllObservers .
	^ aGroup save.
]

{ #category : #'as yet unclassified' }
ERController >> updatePaymentRate: anAttendee [
	|  amount |
	amount := (self priceAccordingToAttendanceDaysOf: anAttendee).
	amount := amount + (self costPerExtraPerson: anAttendee).
	amount := self decreaseCouponAmountFor: amount to: anAttendee.
	amount :=self addPayPalComissionIfApplyOn: amount of: anAttendee.
	anAttendee paymentInformation paymentAmount: amount
]

{ #category : #'as yet unclassified' }
ERController >> updatePaymentRateForGroup: aGroup [ 
	| amount |
	amount := aGroup listAttends sum: [ :each | each paymentAmount ].
	amount := self addPayPalComissionIfApplyOn: amount of: aGroup.
	aGroup paymentInformation paymentAmount: amount.
]

{ #category : #'as yet unclassified' }
ERController >> updateUser: anUser [
	[self validateIfEmailIsAlreadyRegistered: anUser.
	anUser save.
	self notifyAllObservers .
	^ anUser]
	on: ERException 
	do: [ :exp | ^ exp signal ]
]

{ #category : #action }
ERController >> validateIfEmailIsAlreadyRegistered: anUser [
	conference users
		do: [ :each | 
			each email = anUser email
				ifTrue: [each = anUser ifFalse:[
					ERException emailAlreadyRegistered signal ] ]].
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
	self validateIfEmailIsAlreadyRegistered: anAttendee userAccount.
	self validateNewPassword: anAttendee userAccount password 
	with: anAttendee userAccount confirmPassword.
	anAttendee userAccount isAttendee ifTrue: [self updatePaymentRate: anAttendee]
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
