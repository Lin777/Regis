Class {
	#name : #ERContainerAddFee,
	#superclass : #ERContainerView,
	#instVars : [
		'conference',
		'fee',
		'controller'
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
	fee bankAccountInformation bankInformation save.
	fee bankAccountInformation save.
	aFee := fee save.
	conference addFee: aFee .
	conference save.
]

{ #category : #accessing }
ERContainerAddFee >> content: anObject [
	content := anObject
]

{ #category : #accessing }
ERContainerAddFee >> controller: anObject [
	controller := anObject
]

{ #category : #rendering }
ERContainerAddFee >> initialize [
	super initialize.
	controller := ERConfigurationViewController new.
	fee := ERFee new
]

{ #category : #rendering }
ERContainerAddFee >> renderAcceptButton: html [
	self createColoredAnchorButton: 'Accept' with: [ self addFee ] id: 'acceptAddFee' on: html
	
]

{ #category : #rendering }
ERContainerAddFee >> renderAddressString: html [
	self
		createTextAreaField: 'Address String'
		for: #addressString:
		with: #addressString
		withRows: 5
		to: fee bankAccountInformation bankInformation
		on: html
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
	self
		createHeadingStrong: 'Bank Account Information:'
		level: 5
		on: html.
	html horizontalRule.
	self
		createDivGridWith: [ self
				createDivCell6ColWith: [ self
						createTextField: 'Owner:'
						for: #owner:
						with: #owner
						percent: 49
						to: fee bankAccountInformation
						on: html.
					self
						createTextField: 'Number:'
						for: #number:
						with: #number
						percent: 49
						to: fee bankAccountInformation
						on: html ]
				on: html.
			self
				createDivCell6ColWith: [ self
						createTextField: 'IBAN:'
						for: #iban:
						with: #iban
						percent: 49
						to: fee bankAccountInformation
						on: html.
					self
						createTextField: 'Rib Key:'
						for: #ribKey:
						with: #ribKey
						percent: 49
						to: fee bankAccountInformation
						on: html ]
				on: html ]
		on: html
]

{ #category : #rendering }
ERContainerAddFee >> renderFormBankInformation: html [
	self
		createHeadingStrong: 'Bank Information:'
		level: 5
		on: html.
	html horizontalRule.
	self
		createDivGridWith: [ self
				createDivCell6ColWith: [ self
						createTextField: 'Name:'
						for: #name:
						with: #name1
						percent: 49
						to: fee bankAccountInformation bankInformation
						on: html.
					self
						createTextField: 'Code:'
						for: #code:
						with: #code
						percent: 49
						to: fee bankAccountInformation bankInformation
						on: html ]
				on: html.
			self
				createDivCell6ColWith: [ self
						createTextField: 'Counter Code:'
						for: #counterCode:
						with: #counterCode
						percent: 49
						to: fee bankAccountInformation bankInformation
						on: html.
					self
						createTextField: 'BIC:'
						for: #bic:
						with: #bic
						percent: 49
						to: fee bankAccountInformation bankInformation
						on: html ]
				on: html ]
		on: html
]

{ #category : #rendering }
ERContainerAddFee >> renderFormConferenceFee: html [
	self createHeadingStrong: 'Conference Fee:' level: 5 on: html.
	html horizontalRule.
	self
		createSelectField: 'Currency:'
		for: #currency:
		with: #currency
		list: ERAttendee currencyTypes
		percent: 49
		to: fee
		on: html.
	self
		createTextField: 'Price for add a person to the Social Dinner:'
		for: #extraPersonSD:
		with: #extraPersonSD
		percent: 49
		to: fee
		on: html.
	self
		createDivGridWith: [ self
				createDivCell6ColWith: [ html strong: 'Early Registration Fee:'.
					html break.
					self
						createTextField: 'All days Fee:'
						for: #erfAllDaysFee:
						with: #erfAllDaysFee
						percent: 49
						to: fee
						on: html.
					self
						createTextField: 'One day Fee:'
						for: #erfOneDayFee:
						with: #erfOneDayFee
						percent: 49
						to: fee
						on: html ]
				on: html.
			self
				createDivCell6ColWith: [ html strong: 'Late Registration Fee:'.
					html break.
					self
						createTextField: 'All days Fee:'
						for: #lrfAllDaysFee:
						with: #lrfAllDaysFee
						percent: 49
						to: fee
						on: html.
					self
						createTextField: 'One day Fee:'
						for: #lrfOneDayFee:
						with: #lrfOneDayFee
						percent: 49
						to: fee
						on: html ]
				on: html ]
		on: html
]

{ #category : #rendering }
ERContainerAddFee >> renderPayPALUrl: html [
	self createTextField: 'Pay Pal URL:' for: #bankPayPalUrl: with: #bankPayPalUrl to: fee on: html
]
