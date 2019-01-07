Class {
	#name : #ERGroupRegistrationSummary,
	#superclass : #ERGroupRegistration,
	#instVars : [
		'formMofidyAffiliation'
	],
	#category : #'ESUGApp-Components'
}

{ #category : #'as yet unclassified' }
ERGroupRegistrationSummary class >> on: anAttendee withContent: aContent [
	| form |
	form := self new.
	form attendee: anAttendee.
	form content: aContent.
	form initializeController.
	form initializeFormRegister.
	form initializeModifyAffiliationForm.
	^ form
]

{ #category : #rendering }
ERGroupRegistrationSummary >> generateInvoice [
	Transcript show: 'invoice...'
]

{ #category : #rendering }
ERGroupRegistrationSummary >> initialize [
	super initialize
]

{ #category : #rendering }
ERGroupRegistrationSummary >> initializeModifyAffiliationForm [
	formMofidyAffiliation := (ERContainerModifyAffiliationView
		on: attendee
		withContent: content)
		cancelCallback: [ self cancel ];
		yourself
]

{ #category : #rendering }
ERGroupRegistrationSummary >> modifyAffiliation [
	self initializeModifyAffiliationForm .
	content state: formMofidyAffiliation
]

{ #category : #rendering }
ERGroupRegistrationSummary >> pay [
	Transcript show: 'pay.....'
]

{ #category : #rendering }
ERGroupRegistrationSummary >> renderButtons: html [
	self renderModifyAffiliationButtonOn: html.
	self renderRegisterAttendeeButtonOn: html.
	self renderPayButtonOn: html.
	self renderGenerateInvoiceButtonOn: html.
]

{ #category : #rendering }
ERGroupRegistrationSummary >> renderContainer: html [
	html horizontalRule.
	self renderOrganizationName: html.
	self renderPaymentStatus: html.
	self renderFormButtons: html.
	html render: dialogGroupRegistration .
]

{ #category : #rendering }
ERGroupRegistrationSummary >> renderFormButtons: html [
	self renderButtons: html
]

{ #category : #rendering }
ERGroupRegistrationSummary >> renderGenerateInvoiceButtonOn: html [
	self
		createRaisedColoredRippleEffectAnchorButton: 'GENERATE INVOICE'
		with: [ self generateInvoice ]
		id: 'generateInvoice'
		on: html
]

{ #category : #rendering }
ERGroupRegistrationSummary >> renderModifyAffiliationButtonOn: html [
	self
		createRaisedRippleEffectAnchorButton: 'Modify Affiliation'
		with: [ self modifyAffiliation ]
		id: 'modifyAffiliation'
		on: html
]

{ #category : #rendering }
ERGroupRegistrationSummary >> renderOrganizationName: html [
	self createTextStrong: 'Organization Name: ' with: #orgName on: html
]

{ #category : #rendering }
ERGroupRegistrationSummary >> renderPayButtonOn: html [
	self
		createRaisedRippleEffectAnchorButton: 'Pay'
		with: [ self pay ]
		id: 'pay'
		on: html
]

{ #category : #rendering }
ERGroupRegistrationSummary >> renderPaymentStatus: html [
	self createTextStrong: 'Payment Status: ' withText: 'No status avaliable. The group has no mmebers ' on: html 
]

{ #category : #rendering }
ERGroupRegistrationSummary >> renderRegisterAttendeeButtonOn: html [
	self
		createRaisedRippleEffectAnchorButton: 'Register Attendee'
		with: [ self registerAttendee ]
		id: 'registerAttendee'
		on: html
]

{ #category : #accessing }
ERGroupRegistrationSummary >> tabId [
	^ 'summary'
]

{ #category : #accessing }
ERGroupRegistrationSummary >> tabName [
	^ 'Summary'
]

{ #category : #accessing }
ERGroupRegistrationSummary >> title [
	^ 'Group Manager Short Description'
]

{ #category : #rendering }
ERGroupRegistrationSummary >> updateAffiliation [
	attendee := formMofidyAffiliation attendee.
	attendee save.
	self returnToThePreviousState
]
