Class {
	#name : #ERMyRegistrationSummaryTab,
	#superclass : #ERMyRegistrationTab,
	#category : #'ESUGApp-View-Tab'
}

{ #category : #rendering }
ERMyRegistrationSummaryTab >> getInvoice [
]

{ #category : #rendering }
ERMyRegistrationSummaryTab >> modifyRegistration [
	callback := [ self updateMyRegistration ].
	formWithoutBasicInfo := ERContainerTabs
		formWithoutBasicInfoOn: attendee
		withCallback: callback
		content: content.
	content state: formWithoutBasicInfo.
	
]

{ #category : #rendering }
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
				, (ERController new conferenceFeeFor: attendee) asString , ' '
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

{ #category : #rendering }
ERMyRegistrationSummaryTab >> redirectionPayPAL [
	| url |
	url := ERController new payPalUrlFor: attendee.
	self requestContext redirectTo: url
]

{ #category : #rendering }
ERMyRegistrationSummaryTab >> renderButtons: html [
	html mdlAnchorButton 
		raised;
		rippleEffect;
		id: 'modifyRegistration';
		callback: [ self modifyRegistration ];
		with: 'Modify Registration Information'.
	html mdlAnchorButton 
		raised;
		rippleEffect;
		id: 'pay';
		callback: [ self pay ];
		with: 'Pay'.
	html mdlAnchorButton
		raised;
		colored;
		rippleEffect;
		id: 'invoice';
		callback: [ self getInvoice ];
		with: 'Get my invoice'
]

{ #category : #rendering }
ERMyRegistrationSummaryTab >> renderContainer: html [ 	
	html horizontalRule .
	self renderLabelsSummary: html.
	self renderButtons: html.
]

{ #category : #rendering }
ERMyRegistrationSummaryTab >> renderLabelsSummary: html [
	html
		paragraph: [ html strong: 'Attendace Day(s): '.
			html text: attendee conferenceInformation daysOfAssistance ].
	html
		paragraph: [ html strong: 'Payment Status: '.
			html text: self paymentStatus ]
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

{ #category : #rendering }
ERMyRegistrationSummaryTab >> updateMyRegistration [
	(ERRegistrationController attendee: attendee) validateRegister.
	ERController new updateAttendee: attendee.
	self returnToThePreviousState .
	
]
