Class {
	#name : #ERMyRegistrationSummaryTab,
	#superclass : #ERMyRegistrationTab,
	#category : #'ESUGApp-View-Tab'
}

{ #category : #actions }
ERMyRegistrationSummaryTab >> encodedInvoice [
	attendee idGroup isNotNil
	ifTrue: [ |group|
		group := controller conference getGroupOfAttendee: attendee.
		^ group encodedInvoice ]
	ifFalse: [ ^ attendee encodedInvoice] 
]

{ #category : #actions }
ERMyRegistrationSummaryTab >> exportInvoice [
	|invoice|
	invoice :=self managerOfInvoice.
	self exportInvoiceOf: invoice.
]

{ #category : #initialization }
ERMyRegistrationSummaryTab >> initialize [ 
	super initialize .
	messageComponent id: 'alertMyRegistration'
]

{ #category : #accessing }
ERMyRegistrationSummaryTab >> managerOfInvoice [
	attendee idGroup isNotNil
	ifTrue: [ |group|
		group := controller conference getGroupOfAttendee: attendee.
		^ group ]
	ifFalse: [ ^ attendee ] 
]

{ #category : #actions }
ERMyRegistrationSummaryTab >> pay [
	attendee paymentInformation paymentTypeIsBankTransfer
		ifTrue: [ ^ self redirectViewForBankTransfer ].
	attendee paymentInformation paymentTypeIsCreditCard
		ifTrue: [ ^ self redirectionPayPAL ]
]

{ #category : #rendering }
ERMyRegistrationSummaryTab >> paymentStatus [
   attendee paymentInformation hasPaid
		ifTrue: [ ^ 'Payment successfully received.' ]
		ifFalse: [ 
			^ 'Payment no registered yet. Amount due: '
				, attendee paymentInformation paymentAmount asString , ' '
				, attendee paymentInformation paymentCurrency , '(s) '
				, ' (NOTE: you could have paid but we could have not registered it yet)']
]

{ #category : #rendering }
ERMyRegistrationSummaryTab >> redirectViewForBankTransfer [
	| bankTransferView |
	bankTransferView := ERBankTransferPaymentInfoView
		on: attendee
		withContent: content.
	content state: bankTransferView 
]

{ #category : #actions }
ERMyRegistrationSummaryTab >> redirectionPayPAL [
	| url |
	url := controller payPalUrlForGroup: attendee.
	self requestContext redirectTo: url
]

{ #category : #rendering }
ERMyRegistrationSummaryTab >> renderButtonsOn: html [
	self renderModifyRegistrationOn: html.
	self renderPayButtonOn: html.
	self renderDownloadInvoiceOn: html
]

{ #category : #rendering }
ERMyRegistrationSummaryTab >> renderContainerOn: html [ 	
	html horizontalRule .
	html render: messageComponent .
	self renderLabelsSummaryOn: html.
	self renderButtonsOn: html.
]

{ #category : #rendering }
ERMyRegistrationSummaryTab >> renderDownloadInvoiceOn: html [
	html mdlAnchorButton
		raised; rippleEffect;
		id: 'exportInvoice';
		callback: [ self exportInvoice ];
		with: 'Download Invoice'
]

{ #category : #rendering }
ERMyRegistrationSummaryTab >> renderLabelsSummaryOn: html [
	html
		paragraph: [ html strong: 'Attendace Day(s): '.
			html text: attendee conferenceInformation daysOfAssistance ].
	html
		paragraph: [ html strong: 'Payment Status: '.
			html text: self paymentStatus ]
]

{ #category : #rendering }
ERMyRegistrationSummaryTab >> renderModifyRegistrationOn: html. [
	html mdlAnchorButton 
		raised;
		rippleEffect;
		id: 'modifyRegistration';
		disabled: (attendee isAbleToModifyRegister ifTrue: 'disabled');
		callback: [ self modifyRegistrationOf: attendee ];
		with: 'Modify Registration Information'.
]

{ #category : #rendering }
ERMyRegistrationSummaryTab >> renderPayButtonOn: html [
	html mdlAnchorButton 
		raised;
		rippleEffect;
		id: 'pay';
		disabled: (attendee isAbleToPay ifTrue: 'disabled');
		callback: [ self pay ];
		with: 'Pay'.
]

{ #category : #accessing }
ERMyRegistrationSummaryTab >> tabId [
	^ 'summary'
]

{ #category : #accessing }
ERMyRegistrationSummaryTab >> tabName [
	^ 'Summary'
]

{ #category : #accessing }
ERMyRegistrationSummaryTab >> title [
	^ 'Registration Summary'
]

{ #category : #updating }
ERMyRegistrationSummaryTab >> updateMyRegistration [
	self modifyRegistrationInformation: attendee.
]
