Class {
	#name : #ERGroupRegistrationSummaryTab,
	#superclass : #ERGroupRegistrationTab,
	#category : #'ESUGApp-View-Tab'
}

{ #category : #rendering }
ERGroupRegistrationSummaryTab >> attendeeFrom: aGroupManager [
	^ ERAttendee new 
		userAccount: aGroupManager userAccount; 
		affiliationInformation: aGroupManager affiliationInformation 
]

{ #category : #rendering }
ERGroupRegistrationSummaryTab >> exportInvoice [
	self exportInvoiceOf: self group.
]

{ #category : #rendering }
ERGroupRegistrationSummaryTab >> initializeModifyAffiliationForm [
	formMofidyAffiliation := (ERTittledFormView on: controller groupManager affiliationInformation 
								withContent: content) title: 'Affiliation Information';
								callback: [:aff | self updateAffiliation: aff on: self group];
								cancelCallback: [self cancel]; initializeForm. 
	content state: formMofidyAffiliation.
	self updateStateTab: self tabName.
]

{ #category : #rendering }
ERGroupRegistrationSummaryTab >> initializePaymentForm [
	^ ( ERPaymentGroupManagerView on: self group
		withContent: content) 
	updatePayment: [ :aGroup | self payForGroup: aGroup ];
	cancel: [ self returnToThePreviousState .
		self updateStateTab: self tabName. ];
	blockForUpdate: [ :aGroup | aGroup save.
	controller updateGroup: aGroup ]
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
	group paymentInformation  paymentTypeIsBankTransfer
		ifTrue: [ ^ self redirectViewForBankTransfer ].
	group paymentInformation paymentTypeIsCreditCard
		ifTrue: [ ^ self redirectionPayPAL ]
]

{ #category : #rendering }
ERGroupRegistrationSummaryTab >> payForGroup: aGroup [
	aGroup save.
	controller updateGroup: aGroup.
	aGroup paymentInformation  paymentTypeIsBankTransfer
		ifTrue: [ ^ self redirectViewForBankTransfer ].
	aGroup paymentInformation paymentTypeIsCreditCard
		ifTrue: [ ^ self redirectionPayPAL: aGroup ]
]

{ #category : #rendering }
ERGroupRegistrationSummaryTab >> paymentStatus [
	| listAttends |
	listAttends := self attends.
	listAttends isEmpty
		ifTrue: [ ^ 'No status available. The group has no members ' ]
		ifFalse: [ 
	( self group paymentInformation hasPaid )
	ifTrue: [ ^ 'Payment successfully received.' ]
	ifFalse: [ ^ 'Payment no registered yet. Amount due: '
			, (self group totalAmount) asString , ' ', 
			'(s) (NOTE: you could have paid but we could have not registered it yet)' ]].
		
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
	url := controller payPalUrlForGroup: self group.
	self requestContext redirectTo: url
]

{ #category : #rendering }
ERGroupRegistrationSummaryTab >> redirectionPayPAL: aGroup [
	| url |
	url := controller payPalUrlForGroup: aGroup.
	self requestContext redirectTo: url
]

{ #category : #rendering }
ERGroupRegistrationSummaryTab >> renderContainerOn: html [
	html horizontalRule.
	self renderOrganizationNameOn: html.
	self renderPaymentStatus: html.
	self renderFormButtonsOn: html
]

{ #category : #rendering }
ERGroupRegistrationSummaryTab >> renderDownloadInvoiceButtonOn: html [
	html mdlAnchorButton
		raised; rippleEffect;
		id: 'exportInvoice';
		callback: [ self exportInvoice ];
		with: 'Download Invoice'
]

{ #category : #rendering }
ERGroupRegistrationSummaryTab >> renderFormButtonsOn: html [
	self renderModifyAffiliationButtonOn: html.
	self renderPayButtonOn: html.
	self renderDownloadInvoiceButtonOn: html.
	self renderRegisterAttendeeButtonOn: html.
	self renderRegisterMyselfButtonOn: html
]

{ #category : #rendering }
ERGroupRegistrationSummaryTab >> renderModifyAffiliationButtonOn: html [
	html mdlAnchorButton 
		raised;
		rippleEffect;
		id: 'modifyAffiliation';
		callback: [ self modifyAffiliation ];
		with: 'Modify Affiliation'
]

{ #category : #rendering }
ERGroupRegistrationSummaryTab >> renderOrganizationNameOn: html [
	html
		paragraph: [ html strong: 'Organization Name: '.
			html text: (self groupManager affiliationInformation organizationName) ]
]

{ #category : #rendering }
ERGroupRegistrationSummaryTab >> renderPayButtonOn: html [
	html mdlAnchorButton 
		raised;
		rippleEffect;
		id: 'pay';
		disabled: (self group isAbleToPay ifTrue: 'disabled');
		callback: [ self pay ];
		with: 'Pay'
]

{ #category : #rendering }
ERGroupRegistrationSummaryTab >> renderPaymentStatus: html [
	html
		paragraph: [ html strong: 'Payment Status: '.
			html text: self paymentStatus ]
]

{ #category : #rendering }
ERGroupRegistrationSummaryTab >> renderRegisterAttendeeButtonOn: html [
	html mdlAnchorButton 
		raised;
		rippleEffect;
		id: 'registerAttendee';
		disabled: (self group isAbleToPay ifTrue: 'disabled');
		callback: [ self registerAttendee ];
		with: 'Register Attendee'
]

{ #category : #rendering }
ERGroupRegistrationSummaryTab >> renderRegisterMyselfButtonOn: html [
	html mdlAnchorButton 
		raised;
		rippleEffect;
		id: 'registerMyselfAsAttendee';
		disabled: (self group isAbleToPay ifTrue: 'disabled');
		callback: [ self registerMyselfAsAttendee ];
		with: 'Register Myself as Attendee'
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
	^ 'Group Registration'
]

{ #category : #rendering }
ERGroupRegistrationSummaryTab >> updateAffiliation: aff [
	controller updateAffiliation: aff.
	self cancel.
]
