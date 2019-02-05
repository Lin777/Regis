Class {
	#name : #ERBankTransferPage,
	#superclass : #ERFinishRegisterPage,
	#instVars : [
		'fee',
		'bankAccountInformation',
		'bankInformation'
	],
	#category : #'ESUGApp-View-Page'
}

{ #category : #'as yet unclassified' }
ERBankTransferPage class >> on: anAttendee withContent: content withController: aController [
	^ self new
		attendee: anAttendee;
		content: content;
		pageController: aController;
		initializeFee
]

{ #category : #'as yet unclassified' }
ERBankTransferPage >> actionsBody: html [
]

{ #category : #accessing }
ERBankTransferPage >> headers [
	^ #('Bank Code' 'Counter Code' 'Account Number' 'RIB Key' 'Bank Address')
]

{ #category : #initialization }
ERBankTransferPage >> initialize [
	super initialize.
	title := 'Finish'.
]

{ #category : #initialization }
ERBankTransferPage >> initializeFee [
	fee := pageController feePerTypeCurrencyOf: pageController attendee.
	bankAccountInformation := fee bankAccountInformation.
	bankInformation := bankAccountInformation bankInformation
]

{ #category : #rendering }
ERBankTransferPage >> okAction [
	| user |
	user := pageController saveAttendee.
	self redirectLoggedPage:user
	
]

{ #category : #rendering }
ERBankTransferPage >> renderActions: html [
	html mdlCardActions
		class: 'mdl-card--border';
		with: [ 
			html mdlAnchorButton
		colored;
		id: 'okButton';
		callback: [ self okAction ];
		with: 'Ok']
]

{ #category : #rendering }
ERBankTransferPage >> renderBody: html [
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
ERBankTransferPage >> renderBody: html with: aBlock [
	html div
		style:
			'background-image: url(''/files/CssForLoginMDL/profile_city.jpg''); background-repeat: repeat-y; background-size: cover; height: 100vh; ';
		with: [ html break.
			html break.
			aBlock value ]
]

{ #category : #rendering }
ERBankTransferPage >> renderHeaders: html [
	html
		tableHead: [ html
				tableRow: [ self headers do: [ :each | html mdlTableHeading: each ] ] ]
]

{ #category : #rendering }
ERBankTransferPage >> renderInfoBank: html [
	html break.
	self
		createTextStrongWithoutParagraph: 'Bank name:  '
		withText: bankInformation name1
		on: html.
	self
		createTextStrongWithoutParagraph: 'International Bank Account Numer (IBAN):  '
		withText: bankAccountInformation iban
		on: html.
	self
		createTextStrongWithoutParagraph: 'BIC(Bank Identifier Code):  '
		withText: bankInformation bic
		on: html.
	self
		createTextStrongWithoutParagraph: 'Account owner:  '
		withText: bankAccountInformation owner
		on: html.
	html break
]

{ #category : #rendering }
ERBankTransferPage >> renderInfoBankTransfer: html [
	html break.
	html
		text:
			'BANK TRANSFER to "' , bankAccountInformation owner , '" (in '
				, fee currency,
					'). the tranfer should be "whitout cost to the beneficiary" (i.e
        your organization shoul pay all bank transfer fees) Now make they bank transfer from your account, either right awaty or within the next few days.
        (In the text field transfer, please put your email. to speed payment reconcilliation.) To record this data, either save/print this page now or click "OK" the "My Registration" then "Generate Invoice",
        and save/print that. (you can login again and generate another copy of the invoice at any time.).'.
	html break.
	html break
]

{ #category : #rendering }
ERBankTransferPage >> renderPageOn: html [
	self renderInfoBankTransfer: html.
	self renderTableInfoBank: html.
	self renderInfoBank: html.
	self renderActions: html.
]

{ #category : #rendering }
ERBankTransferPage >> renderTableInfoBank: html [
	html div style: 'overflow-x: auto;'; with: [
	html mdlTable
				class: 'mdl-shadow--2dp';
				style: 'width:100%;';
				with: [ self renderHeaders: html.
						  self renderBody: html] ]
]
