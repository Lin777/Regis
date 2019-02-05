Class {
	#name : #ERGroupRegistrationSummaryTab,
	#superclass : #ERGroupRegistrationTab,
	#instVars : [
		'formMofidyAffiliation'
	],
	#category : #'ESUGApp-View-Tab'
}

{ #category : #rendering }
ERGroupRegistrationSummaryTab >> generateInvoice [
	
]

{ #category : #rendering }
ERGroupRegistrationSummaryTab >> initializeModifyAffiliationForm [
	formMofidyAffiliation := (ERTittledFormView on: controller groupManager affiliationInformation 
								withContent: content) title: 'Affiliation Information';
								callback: [:aff | self updateAffiliation: aff];
								cancelCallback: [self cancel]; initializeForm. 
	content state: formMofidyAffiliation.
	self updateStateTab: self tabName.
]

{ #category : #rendering }
ERGroupRegistrationSummaryTab >> initializePaymentForm [
	^ ( ERPaymentGroupManagerView on: self group
		withContent: content) 
	updatePayment: [ self payForGroup ];
	cancel: [ self returnToThePreviousState .
		self updateStateTab: self tabName. ];
	amountString:
	(ERController new amountOfPayToGroup: self attends) asString.

]

{ #category : #rendering }
ERGroupRegistrationSummaryTab >> modifyAffiliation [
	self initializeModifyAffiliationForm .
]

{ #category : #rendering }
ERGroupRegistrationSummaryTab >> pay [
	|formUpdatePayment|
	formUpdatePayment := self initializePaymentForm.
	content state: formUpdatePayment.
	self updateStateTab: self tabName.
]

{ #category : #rendering }
ERGroupRegistrationSummaryTab >> payForGroup [
	|group|
	group := self group.
	controller updateGroup: group.
	group paymentTypeIsBankTransfer
		ifTrue: [ ^ self redirectViewForBankTransfer ].
	group paymentTypeIsCreditCard
		ifTrue: [ ^ self redirectionPayPAL ]
]

{ #category : #rendering }
ERGroupRegistrationSummaryTab >> paymentStatus [
	| listAttends |
	listAttends := self attends.
	listAttends isEmpty
		ifTrue: [ ^ 'No status available. The group has no members ' ]
		ifFalse: [ ^ 'Payment no registered yet. Amount due: '
			, (ERController new amountOfPayToGroup: listAttends) asString , ' ', 
			'(s) (NOTE: you could have paid but we could have not registered it yet)' ]
]

{ #category : #rendering }
ERGroupRegistrationSummaryTab >> redirectViewForBankTransfer [
	| bankTransferView |
	bankTransferView := ERBankTransferPaymentInfoView
		on: self group
		withContent: content.
	content state: bankTransferView 
]

{ #category : #rendering }
ERGroupRegistrationSummaryTab >> redirectionPayPAL [
	| url |
	url := ERController new payPalUrlForGroup: self group.
	self requestContext redirectTo: url
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
	html
		paragraph: [ html strong: 'Organization Name: '.
			html text: (self groupManager affiliationInformation organizationName) ]."
	self createTextStrong: 'Organization Name: ' with: #orgName on: html"
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
	self
		createTextStrong: 'Payment Status: '
		withText: self paymentStatus
		on: html
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
ERGroupRegistrationSummaryTab >> updateAffiliation: aff [
	controller groupManager affiliationInformation: aff.
	controller group save.
	self cancel.
]
