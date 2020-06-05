"
Description
-------------

I am the view to show the bank transfer information
"
Class {
	#name : #ERBankTransferPaymentInfoView,
	#superclass : #ERTittledView,
	#instVars : [
		'fee',
		'bankAccountInformation',
		'bankInformation',
		'dialog'
	],
	#category : #'ESUGApp-View-View'
}

{ #category : #'as yet unclassified' }
ERBankTransferPaymentInfoView class >> on: anAttendee withContent: aContent [
	| form |
	form := self new.
	form attendee: anAttendee.
	form content: aContent.
	form initializeFee.
	^ form
]

{ #category : #rendering }
ERBankTransferPaymentInfoView >> content: anObject [
	content := anObject
]

{ #category : #accessing }
ERBankTransferPaymentInfoView >> headers [
	^ #('Bank Code' 'Counter Code' 'Account Number' 'RIB Key' 'Bank Address')
]

{ #category : #initialization }
ERBankTransferPaymentInfoView >> initializeDialog [
	dialog := ERDialog cancelDialog
		idOpen: 'back-state';
		okCallback: [ self returnToThePreviousState ]
]

{ #category : #initialization }
ERBankTransferPaymentInfoView >> initializeFee [
	fee := controller conference fee.
	bankAccountInformation := fee bankAccountInformation.
	bankInformation := bankAccountInformation bankInformation
]

{ #category : #rendering }
ERBankTransferPaymentInfoView >> renderBody: html [
	html
		tableBody: [ html
				tableRow: [ html mdlTableCell: [ html text: bankInformation code ].
					html
						mdlTableCell: [ html text: bankInformation counterCode ].
					html
						mdlTableCell: [ html text: bankAccountInformation ribKey ].
					html
						mdlTableCell: [ html text: bankAccountInformation number ].
					html
						mdlTableCell: [ html text: bankInformation addressString ] ] ]
]

{ #category : #rendering }
ERBankTransferPaymentInfoView >> renderHeaders: html [
	html
		tableHead: [ html
				tableRow: [ self headers do: [ :each | html mdlTableHeading: each ] ] ]
]

{ #category : #rendering }
ERBankTransferPaymentInfoView >> renderInfoBank: html [
	html break.
	(OrderedCollection new
			add: ('Bank name:  '-> bankInformation name); 
			add: ('International Bank Account Numer (IBAN):  '-> bankAccountInformation iban); 
			add: ('BIC(Bank Identifier Code):  '->bankInformation bic); 
			add: ('Account owner:  '->bankAccountInformation owner);
			yourself) do: [ :each | 
				html strong: each key.
				html text: each value.
				html break ].
	html break
]

{ #category : #rendering }
ERBankTransferPaymentInfoView >> renderInfoBankTransfer: html [
	html break.
	html
		text:
			'BANK TRANSFER to "' , bankAccountInformation owner
				, '" (in ' , fee currency
				,
					'). the tranfer should be "whitout cost to the beneficiary" (i.e
        your organization shoul pay all bank transfer fees) Now make they bank transfer from your account, either right awaty or within the next few days.
        (In the text field transfer, please put your email. to speed payment reconcilliation.) To record this data, either save/print this page now or click "OK" the "My Registration" then "Generate Invoice",
        and save/print that. (you can login again and generate another copy of the invoice at any time.).'.
	html break.
	html break
]

{ #category : #rendering }
ERBankTransferPaymentInfoView >> renderPageOn: html [
	self renderInfoBankTransfer: html.
	self renderTableInfoBank: html.
	self renderInfoBank: html.
	html horizontalRule.
	self initializeDialog.
	html mdlAnchorButton
		colored;
		id: 'back-state';
		callback: [ content state: content lastState ];
		with: 'Back'.
]

{ #category : #rendering }
ERBankTransferPaymentInfoView >> renderTableInfoBank: html [
	html mdlTable
		class: 'mdl-shadow--2dp';
		style: 'width:100%;';
		with: [ self renderHeaders: html.
			self renderBody: html ]
]

{ #category : #accessing }
ERBankTransferPaymentInfoView >> title [
	^ 'Bank Transfer'
]
