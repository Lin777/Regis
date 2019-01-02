Class {
	#name : #ERContainerAddFee,
	#superclass : #ERContainerView,
	#instVars : [
		'conference',
		'fee'
	],
	#category : #'ESUGApp-Components'
}

{ #category : #'as yet unclassified' }
ERContainerAddFee class >> on: anAttendee withContent: aContent [
	| form |
	form := self new.
	form attendee: anAttendee.
	form content: aContent.
	^ form
]

{ #category : #rendering }
ERContainerAddFee >> addFee [
	|aFee|
	aFee := fee save.
	conference addFee: aFee .
	conference save.
]

{ #category : #accessing }
ERContainerAddFee >> content: anObject [
	content := anObject
]

{ #category : #rendering }
ERContainerAddFee >> initialize [
	super initialize .
	fee := ERFee new.
]

{ #category : #rendering }
ERContainerAddFee >> renderAcceptButton: html [
	self createColoredAnchorButton: 'Accept' with: [ self addFee ] id: 'acceptAddFee' on: html
	
]

{ #category : #rendering }
ERContainerAddFee >> renderAddressString: html [
	self createTextAreaField: 'Address String' for: #bankAddressString: with: #bankAddressString withRows: 5 to: fee on: html
]

{ #category : #rendering }
ERContainerAddFee >> renderCancelButton: html [
	self createColoredAnchorButton: 'Cancel' with: [ self returnToThePreviousState ] id: 'cancelAddFee' on: html
	
]

{ #category : #rendering }
ERContainerAddFee >> renderContentPage: html [
	html div class: 'mdl-js-ripple-effect'; with: [ 
		self renderFormConferenceFee: html.
		self renderFormBankAccountInformation: html.
		self renderFormBankInformation: html.
		self renderAddressString: html.
		self renderPayPALUrl: html.
		self renderAcceptButton: html.
		self renderCancelButton: html.
		 ]
]

{ #category : #rendering }
ERContainerAddFee >> renderFormBankAccountInformation: html [
	self createHeadingStrong: 'Bank Account Information:' level: 5 on: html.
	html horizontalRule .
	self createDivGridWith: [ 
		self createDivCell6ColWith: [ 
			self createTextField: 'Owner:' for: #bankAccountOwner: with: #bankAccountOwner percent: 49 to: fee on: html.
			self createTextField: 'Number:' for: #bankAccountNumber: with: #bankAccountNumber percent: 49 to: fee on: html.
			 ] on: html.
		self createDivCell6ColWith: [
			self createTextField: 'IBAN:' for: #bankAccountIBAN: with: #bankAccountIBAN percent: 49 to: fee on: html.
			self createTextField: 'Rib Key:' for: #bankAccountRibKey: with: #bankAccountRibKey percent: 49 to: fee on: html.
			 ] on: html.
	] on: html.
]

{ #category : #rendering }
ERContainerAddFee >> renderFormBankInformation: html [
	self createHeadingStrong: 'Bank Information:' level: 5 on: html.
	html horizontalRule .
	self createDivGridWith: [ 
		self createDivCell6ColWith: [ 
			self createTextField: 'Name:' for: #bankName: with: #bankName percent: 49 to: fee on: html.
			self createTextField: 'Code:' for: #bankCode: with: #bankCode percent: 49 to: fee on: html.
			 ] on: html.
		self createDivCell6ColWith: [
			self createTextField: 'Counter Code:' for: #bankCounterCode: with: #bankCounterCode percent: 49 to: fee on: html.
			self createTextField: 'BIC:' for: #bankBIC: with: #bankBIC percent: 49 to: fee on: html.
			 ] on: html.
	] on: html.
]

{ #category : #rendering }
ERContainerAddFee >> renderFormConferenceFee: html [
	self createHeadingStrong: 'Conference Fee:' level: 5 on: html.
	html horizontalRule .
	self createSelectField: 'Currency:' for: #currency: with: #currency list: ERAttendee currencyTypes to: fee on: html.
	self createDivGridWith: [ 
		self createDivCell6ColWith: [ 
			html strong: 'Early Registration Fee:' .
			html break .
			self createTextField: 'All days Fee:' for: #erfAllDaysFee: with: #erfAllDaysFee percent: 49 to: fee on: html.
			self createTextField: 'One day Fee:' for: #erfOneDayFee: with: #erfOneDayFee percent: 49 to: fee on: html.
			 ] on: html.
		self createDivCell6ColWith: [
			html strong: 'Late Registration Fee:'.
			html break .
			self createTextField: 'All days Fee:' for: #lrfAllDaysFee: with: #lrfAllDaysFee percent: 49 to: fee on: html.
			self createTextField: 'One day Fee:' for: #lrfOneDayFee: with: #lrfOneDayFee percent: 49 to: fee on: html.
			 ] on: html.
	] on: html.
]

{ #category : #rendering }
ERContainerAddFee >> renderPayPALUrl: html [
	self createTextField: 'Pay Pal URL:' for: #bankPayPalUrl: with: #bankPayPalUrl to: fee on: html
]
