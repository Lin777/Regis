Class {
	#name : #ERContainerTab,
	#superclass : #ERContentTab,
	#instVars : [
		'messageComponent',
		'controller',
		'callback',
		'mofidyUserForm',
		'formWithoutBasicInfo',
		'formRegister',
		'attenteeRegisterForm',
		'formApplyReductionTicket',
		'newAttendee'
	],
	#category : #'ESUGApp-View-Tab'
}

{ #category : #'as yet unclassified' }
ERContainerTab class >> on: anAttendee withContent: aContent [
	| form |
	form := self new.
	form attendee: anAttendee.
	form content: aContent.
	^ form
]

{ #category : #rendering }
ERContainerTab >> alreadyRegisteredAsAttendee [
	^ attendee userAccount isAttendee
]

{ #category : #initialization }
ERContainerTab >> applyReductionTicketTo: user [
	self initializeApplyReductionTicketForm: user.
	content state: formApplyReductionTicket .
	self updateStateTab: self tabName.
]

{ #category : #accessing }
ERContainerTab >> callback [
	^ callback
]

{ #category : #accessing }
ERContainerTab >> callback: anObject [
	callback := anObject
]

{ #category : #accessing }
ERContainerTab >> content: anObject [
	content := anObject
]

{ #category : #accessing }
ERContainerTab >> controller [
	^ controller
]

{ #category : #accessing }
ERContainerTab >> controller: anObject [
	controller := anObject
]

{ #category : #'as yet unclassified' }
ERContainerTab >> encodeFileToUTF8: aFile [
	^ aFile exists 
		ifTrue: [ (ZnUTF8Encoder new encodeString: aFile binaryReadStream upToEnd asString) asString ] 
		ifFalse: [ nil ]. 
]

{ #category : #'as yet unclassified' }
ERContainerTab >> encodeFiletoBase64: aFile [
	^ aFile exists 
		ifTrue: [ ZnBase64Encoder new encode: aFile binaryReadStream upToEnd ] 
		ifFalse: [ nil ]. 
]

{ #category : #'as yet unclassified' }
ERContainerTab >> generateInvoice: aAttendee [
	controller conference groups detect: [ :aGroup | 
		aGroup listAttends detect: [ :aAtt | 
			aAtt userAccount = aAttendee userAccount ] 
		ifFound: [ :aAtt | self generateInvoiceGroup: aGroup.
			true ]
		ifNone: [ false ]
	] ifNone: [ self generateInvoiceAttendee: aAttendee ].
]

{ #category : #'as yet unclassified' }
ERContainerTab >> generateInvoiceAttendee: aAttendee [
	aAttendee hasPaid ifTrue: [ 
		| file |
		file := ERPDFInvoice templateRegistrationInvoice: aAttendee.
		aAttendee encodedInvoice: (self encodeFiletoBase64: file).
		controller updateAttendee: aAttendee.
		file ensureDelete.
	].
	self updateStateTab: self tabName.
]

{ #category : #'as yet unclassified' }
ERContainerTab >> generateInvoiceGroup: aGroup [
	(controller allAttendeesHasPaid: aGroup) ifTrue: [ 
		| file encodeFile |
		file := ERPDFInvoice templateRegistrationInvoice: aGroup groupManager.
		encodeFile := self encodeFiletoBase64: file.
		aGroup listAttends do: [ :aAttendee | 
			aAttendee encodedInvoice: encodeFile.
			aAttendee save.
		].
		aGroup encodedInvoice: encodeFile.
		file ensureDelete.
	].
	self updateStateTab: self tabName.
]

{ #category : #initialization }
ERContainerTab >> initialize [
	super initialize.
	messageComponent := ERAlert warningAlert id: 'tabAlert'.

]

{ #category : #initialization }
ERContainerTab >> initializeApplyReductionTicketForm: user [	
	| tickets |
	tickets := controller conference reductionTickets collect: #ticketId.
	tickets addFirst: 'No reduction ticket'.
	formApplyReductionTicket := (ERApplyReductionTicketView
		on: user
		withContent: content) 
		listOfTickets: tickets; 
		updateTicketAttendee: [ self updateTicketInformation: user ]; 
		cancel: [ self returnToThePreviousState. 
			self updateStateTab: self tabName.]
]

{ #category : #initialization }
ERContainerTab >> initializeFormRegister [
	newAttendee := ERAttendee new.
	formRegister := ERContainerTabs
		formRegisterOn: newAttendee
		withCallback: callback
		content: content
]

{ #category : #initialization }
ERContainerTab >> initializeFormWithoutBasicInformationFor: anAttendee [
	formWithoutBasicInfo := ERContainerTabs
		formWithoutBasicInfoOn: anAttendee
		withCallback: callback
		content: content.
	content state: formWithoutBasicInfo
]

{ #category : #accessing }
ERContainerTab >> modifyRegistrationInformation: anAttendee [
	callback := [ self updateRegistrationInformation: anAttendee ].
	
	self initializeFormWithoutBasicInformationFor: anAttendee.
	self updateStateTab: self tabName.
]

{ #category : #accessing }
ERContainerTab >> modifyUserFormGroup: anUser [
	
	mofidyUserForm := ERModifyUserView
		on: anUser
		withContent: content
		withAction: [ controller updateUser: anUser.
			self returnToThePreviousState.
			self updateStateTab: self tabName.  ].
	content state: mofidyUserForm
]

{ #category : #rendering }
ERContainerTab >> registerAttendee [
	self initializeFormRegister.
	content state: formRegister
]

{ #category : #rendering }
ERContainerTab >> renderContainer: html [
	self subclassResponsibility 
]

{ #category : #rendering }
ERContainerTab >> renderContentOn: html [
	html heading level3; with: self title .
	self renderContainer: html
]

{ #category : #accessing }
ERContainerTab >> title [
	self subclassResponsibility 
]

{ #category : #accessing }
ERContainerTab >> updateRegistrationInformation: anAttendee [
	(ERRegistrationController attendee: anAttendee ) validateRegister .
	anAttendee save.
	content state: content lastState
]

{ #category : #initialization }
ERContainerTab >> updateTicketInformation: anAttendee [
	|ticket|
	anAttendee coupon = 'No reduction ticket'
	ifTrue: [ anAttendee coupon: '' ]
	ifFalse: [ ticket := controller reductionTicketWithName: anAttendee coupon.
		controller verifyIfTicketCanApply: ticket.
		 ].
	controller applyReductionTicketTo: anAttendee .
	self returnToThePreviousState. 
			self updateStateTab: self tabName.
]
