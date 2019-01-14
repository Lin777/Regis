Class {
	#name : #ERGroupRegistrationSummaryTab,
	#superclass : #ERGroupRegistrationTab,
	#instVars : [
		'formMofidyAffiliation'
	],
	#category : #'ESUGApp-View-Tab'
}

{ #category : #'as yet unclassified' }
ERGroupRegistrationSummaryTab class >> on: anAttendee withContent: aContent [
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
ERGroupRegistrationSummaryTab >> generateInvoice [
	Transcript show: 'invoice...'
]

{ #category : #rendering }
ERGroupRegistrationSummaryTab >> initialize [
	super initialize
]

{ #category : #rendering }
ERGroupRegistrationSummaryTab >> initializeModifyAffiliationForm [
	formMofidyAffiliation := (ERModifyAffiliationForm
		on: attendee
		withContent: content)
		cancelCallback: [ self cancel ];
		yourself
]

{ #category : #rendering }
ERGroupRegistrationSummaryTab >> modifyAffiliation [
	self initializeModifyAffiliationForm .
	content state: formMofidyAffiliation
]

{ #category : #rendering }
ERGroupRegistrationSummaryTab >> pay [
	Transcript show: 'pay.....'
]

{ #category : #rendering }
ERGroupRegistrationSummaryTab >> renderButtons: html [
	self renderModifyAffiliationButtonOn: html.
	self renderRegisterAttendeeButtonOn: html.
	self renderPayButtonOn: html.
	self renderGenerateInvoiceButtonOn: html.
]

{ #category : #rendering }
ERGroupRegistrationSummaryTab >> renderContainer: html [
	html horizontalRule.
	self renderOrganizationName: html.
	self renderPaymentStatus: html.
	self renderFormButtons: html
]

{ #category : #rendering }
ERGroupRegistrationSummaryTab >> renderFormButtons: html [
	self renderButtons: html
]

{ #category : #rendering }
ERGroupRegistrationSummaryTab >> renderGenerateInvoiceButtonOn: html [
	html mdlAnchorButton
		raised;
		colored;
		rippleEffect;
		id: 'generateInvoice';
		callback: [ self generateInvoice ];
		with: 'GENERATE INVOICE'
]

{ #category : #rendering }
ERGroupRegistrationSummaryTab >> renderModifyAffiliationButtonOn: html [
	self
		createRaisedRippleEffectAnchorButton: 'Modify Affiliation'
		with: [ self modifyAffiliation ]
		id: 'modifyAffiliation'
		on: html
]

{ #category : #rendering }
ERGroupRegistrationSummaryTab >> renderOrganizationName: html [
	self createTextStrong: 'Organization Name: ' with: #orgName on: html
]

{ #category : #rendering }
ERGroupRegistrationSummaryTab >> renderPayButtonOn: html [
	self
		createRaisedRippleEffectAnchorButton: 'Pay'
		with: [ self pay ]
		id: 'pay'
		on: html
]

{ #category : #rendering }
ERGroupRegistrationSummaryTab >> renderPaymentStatus: html [
	self createTextStrong: 'Payment Status: ' withText: 'No status avaliable. The group has no mmebers ' on: html 
]

{ #category : #rendering }
ERGroupRegistrationSummaryTab >> renderRegisterAttendeeButtonOn: html [
	self
		createRaisedRippleEffectAnchorButton: 'Register Attendee'
		with: [ self registerAttendee ]
		id: 'registerAttendee'
		on: html
]

{ #category : #accessing }
ERGroupRegistrationSummaryTab >> tabId [
	^ 'summary'
]

{ #category : #accessing }
ERGroupRegistrationSummaryTab >> tabName [
	^ 'Summary'
]

{ #category : #accessing }
ERGroupRegistrationSummaryTab >> title [
	^ 'Group Manager Short Description'
]

{ #category : #rendering }
ERGroupRegistrationSummaryTab >> updateAffiliation [
	attendee := formMofidyAffiliation attendee.
	attendee save.
	self returnToThePreviousState
]
