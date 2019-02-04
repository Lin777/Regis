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
		'formMofidyAffiliation'
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

{ #category : #initialization }
ERContainerTab >> initializeModifyAffiliationForm [
	formMofidyAffiliation := (ERTittledFormView on: controller groupManager affiliationInformation 
								withContent: content) title: 'Affiliation Information';
								callback: [:aff | self updateAffiliation: aff];
								cancelCallback: [self cancel]; initializeForm. 
	content state: formMofidyAffiliation.
	self updateStateTab: self tabName.
]

{ #category : #initialization }
ERContainerTab >> initializeModifyAffiliationForm: aGroup [
	formMofidyAffiliation := (ERTittledFormView on: aGroup groupManager affiliationInformation 
								withContent: content) title: 'Affiliation Information';
								callback: [:aff | self updateAffiliation: aff on: aGroup];
								cancelCallback: [self cancel]; initializeForm. 
	content state: formMofidyAffiliation.
	self updateStateTab: self tabName.
]

{ #category : #rendering }
ERContainerTab >> modifyAffiliation: aGroup [
	self initializeModifyAffiliationForm: aGroup .
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
								cancelCallback: [self cancel]; initializeForm. 
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

{ #category : #rendering }
ERContainerTab >> updateAffiliation: aff on: aGroup [
	aGroup groupManager affiliationInformation: aff.
	aGroup save.
	self cancel.
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
	|result|
	result := controller updateUser: user.
	(result isMemberOf: ERException) ifTrue: [ result signal ]
	ifFalse: [ self cancel ]
	
]
