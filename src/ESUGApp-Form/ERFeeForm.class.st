Class {
	#name : #ERFeeForm,
	#superclass : #ERContainer,
	#instVars : [
		'fee',
		'callback',
		'dialog'
	],
	#category : #'ESUGApp-Form'
}

{ #category : #'as yet unclassified' }
ERFeeForm class >> on: aFee callback: aBlock withContent: aContent [
	| form |
	form := self new.
	form fee: aFee.
	form callback: aBlock.
   form content: aContent.
	^ form
]

{ #category : #accessing }
ERFeeForm >> callback: anObject [
	callback := anObject
]

{ #category : #accessing }
ERFeeForm >> content: anObject [
	content := anObject
]

{ #category : #accessing }
ERFeeForm >> fee [
	^ fee 
]

{ #category : #accessing }
ERFeeForm >> fee: anObject [
	fee := anObject
]

{ #category : #rendering }
ERFeeForm >> initialize [
	super initialize.
	fee := ERFee new.
	dialog := ERDialog new
		title: 'Cancel';
		message: 'Are you sure you want to cancel?';
		idClose: 'buttonClose';
		idOpen: 'cancelAddFee';
		okCallback: [ self returnToThePreviousState ]
]

{ #category : #rendering }
ERFeeForm >> renderAcceptButton: html [
	self
		createColoredButtonAsSubmit: 'Accept'
		with: callback
		id: 'acceptAddFee'
		on: html
]

{ #category : #rendering }
ERFeeForm >> renderAddressString: html [
	self
		createTextAreaField: 'Address String'
		for: #addressString:
		with: #addressString
		withRows: 5
		to: fee bankAccountInformation bankInformation
		on: html
]

{ #category : #rendering }
ERFeeForm >> renderCancelButton: html [
	self
		createColoredAnchorButton: 'Cancel'
		id: 'cancelAddFee'
		on: html
]

{ #category : #rendering }
ERFeeForm >> renderContentPage: html [
	html div
		class: 'mdl-js-ripple-effect';
		with: [ html form
				method: 'post';
				id: 'formFee';
				with: [ self renderFormConferenceFee: html.
					self renderFormBankAccountInformation: html.
					self renderFormBankInformation: html.
					self renderAddressString: html.
					self renderPayPALUrl: html.
					self renderAcceptButton: html.
					self renderCancelButton: html ] ].
			html render: dialog
]

{ #category : #rendering }
ERFeeForm >> renderFormBankAccountInformation: html [
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
ERFeeForm >> renderFormBankInformation: html [
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
ERFeeForm >> renderFormConferenceFee: html [
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
ERFeeForm >> renderPayPALUrl: html [
	self createTextField: 'Pay Pal URL:' for: #bankPayPalUrl: with: #bankPayPalUrl to: fee on: html
]
