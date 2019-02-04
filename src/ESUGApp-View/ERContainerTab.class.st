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
		'formApplyReductionTicket'
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
	^ self session user isAttendee
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

{ #category : #actions }
ERContainerTab >> cancel [
	self returnToThePreviousState.
	self updateStateTab: self tabName.
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
	mofidyUserForm := (ERTittledFormView on: anUser 
								withContent: content) title: 'User';
								callback: [:user | self updateUser: user];
								cancelCallback: [:user | user cancel. self returnToThePreviousState.
			self updateStateTab: self tabName.]; initializeForm. 
								"ERModifyUserView
		on: anUser
		withContent: content
		withAction: [ controller updateUser: anUser.
			self returnToThePreviousState.
			self updateStateTab: self tabName.  ]."
	content state: mofidyUserForm.
	self updateStateTab: self tabName.
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

{ #category : #accessing }
ERContainerTab >> updateUser: user [
	user save.
	controller updateUser: user model .
			self returnToThePreviousState.
			self updateStateTab: self tabName.
]
