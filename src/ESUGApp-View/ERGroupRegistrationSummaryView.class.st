"
I render the registration page of group manager user
"
Class {
	#name : #ERGroupRegistrationSummaryView,
	#superclass : #ERGroupRegistrationTab,
	#category : #'ESUGApp-View-View'
}

{ #category : #actions }
ERGroupRegistrationSummaryView >> exportInvoice [
	self exportInvoiceOf: self group.
]

{ #category : #initialization }
ERGroupRegistrationSummaryView >> initializeModifyAffiliationForm [

	formMofidyAffiliation := (ERTittledFormView on: (controller group affiliationInformation readOnly: false)
								withContent: content) title: 'Billing Information';
								callback: [ :aff | aff readOnly: true.
									self updateAffiliation: aff on: self group ];
								cancelCallback: [ self cancel ]; initializeForm. 
	content state: formMofidyAffiliation.
	self updateStateTab: self tabName.
]

{ #category : #initialization }
ERGroupRegistrationSummaryView >> initializePaymentForm [
	^ (ERPaymentGroupManagerView on: self group
		withContent: content) 
		updatePayment: [ :aGroup | self payForGroup: aGroup ];
		cancel: [
				self returnToThePreviousState ];
		blockForUpdate: [ :aGroup | aGroup save.
			controller updateGroup: aGroup ]
]

{ #category : #rendering }
ERGroupRegistrationSummaryView >> modifyAffiliation [

	self initializeModifyAffiliationForm.
]

{ #category : #rendering }
ERGroupRegistrationSummaryView >> modifyGroupInformation [
	(controller group contactInformation copy) readOnly: false.
	(controller group affiliationInformation copy) readOnly: false.
	(controller group paymentInformation copy) readOnly: false.
	self initializeGroupInformationForm: controller group.
]

{ #category : #actions }
ERGroupRegistrationSummaryView >> pay [

	| formUpdatePayment |

	formUpdatePayment := self initializePaymentForm.
	content state: formUpdatePayment.
	"self updateStateTab: self tabName."
]

{ #category : #actions }
ERGroupRegistrationSummaryView >> payForGroup: aGroup [
	aGroup save.
	controller updateGroup: aGroup.
	aGroup paymentInformation  paymentTypeIsBankTransfer
		ifTrue: [ ^ self redirectViewForBankTransfer ].
	aGroup paymentInformation paymentTypeIsCreditCard
		ifTrue: [ ^ self redirectionPayPAL: aGroup ]
]

{ #category : #rendering }
ERGroupRegistrationSummaryView >> paymentStatus [
	| listAttends |
	listAttends := self attends.
	listAttends isEmpty
		ifTrue: [ ^ 'No status available. The group has no members ' ]
		ifFalse: [ 
	(self group paymentInformation hasPaid)
	ifTrue: [ ^ 'Payment successfully received.' ]
	ifFalse: [ ^ 'Payment no registered yet. Amount due: '
			, (self group paymentAmount) asString , ' ', 
			'(s) (NOTE: you could have paid but we could have not registered it yet)' ] ].
		
]

{ #category : #rendering }
ERGroupRegistrationSummaryView >> redirectViewForBankTransfer [
	| bankTransferView |
	bankTransferView := ERBankTransferPaymentInfoView
		on: self group
		withContent: content.
	content state: bankTransferView
]

{ #category : #rendering }
ERGroupRegistrationSummaryView >> redirectionPayPAL [
	| url |
	url := controller payPalUrlForGroup: self group.
	self requestContext redirectTo: url
]

{ #category : #rendering }
ERGroupRegistrationSummaryView >> redirectionPayPAL: aGroup [
	| url |
	url := controller payPalUrlForGroup: aGroup.
	self requestContext redirectTo: url
]

{ #category : #rendering }
ERGroupRegistrationSummaryView >> renderContainerOn: html [

	html horizontalRule.
	self renderOrganizationNameOn: html.
	self renderPaymentStatus: html.
	self renderFormButtonsOn: html
]

{ #category : #rendering }
ERGroupRegistrationSummaryView >> renderDownloadInvoiceButtonOn: html [
	html mdlAnchorButton
		raised; rippleEffect;
		id: 'exportInvoice';
		callback: [ self exportInvoice ];
		with: 'Download Invoice'
]

{ #category : #rendering }
ERGroupRegistrationSummaryView >> renderFormButtonsOn: html [
	
	html div
		style: 'display: flex;
    			justify-content: space-evenly;';
		with: [
			self renderRegisterMyselfButtonOn: html.
			self renderModifyBillingInfoButtonOn: html.
			self renderPayButtonOn: html.
			self renderDownloadInvoiceButtonOn: html ].
	
]

{ #category : #rendering }
ERGroupRegistrationSummaryView >> renderModifyBillingInfoButtonOn: html [
	html mdlAnchorButton 
		raised;
		rippleEffect;
		id: 'modifyAffiliation';
		disabled: (self group isAbleToPay ifTrue: 'disabled');
		callback: [ self modifyGroupInformation ];
		with: 'Modify Group Information'
]

{ #category : #rendering }
ERGroupRegistrationSummaryView >> renderOrganizationNameOn: html [
	html
		paragraph: [ html strong: 'Organization Name: '.
			html text: (self group affiliationInformation organizationName) ]
]

{ #category : #rendering }
ERGroupRegistrationSummaryView >> renderPayButtonOn: html [
	html mdlAnchorButton 
		raised;
		rippleEffect;
		id: 'pay';
		disabled: (self group isAbleToPay ifTrue: 'disabled');
		callback: [ self pay ];
		with: 'Payment information'
]

{ #category : #rendering }
ERGroupRegistrationSummaryView >> renderPaymentStatus: html [
	html
		paragraph: [ html strong: 'Payment Status: '.
			html text: self paymentStatus ]
]

{ #category : #rendering }
ERGroupRegistrationSummaryView >> renderRegisterMyselfButtonOn: html [
	attendee isAttendee ifFalse: [
	html mdlAnchorButton 
		raised;
		rippleEffect;
		id: 'registerMyselfAsAttendee';
		disabled: (self group isAbleToPay ifTrue: 'disabled');
		callback: [ self registerMyselfAsAttendee ];
		with: 'Register Myself as Attendee' ]
]

{ #category : #accessing }
ERGroupRegistrationSummaryView >> tabId [
	^ 'summary'
]

{ #category : #accessing }
ERGroupRegistrationSummaryView >> tabName [
	^ 'Summary'
]

{ #category : #accessing }
ERGroupRegistrationSummaryView >> title [
	^ 'Registration'
]

{ #category : #updating }
ERGroupRegistrationSummaryView >> updateBillingInfo: aff [
	controller updateBillingInfo: aff.
	self cancel.
]
