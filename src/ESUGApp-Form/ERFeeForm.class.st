"
I am a form for edit a Fee of conference.
"
Class {
	#name : #ERFeeForm,
	#superclass : #ERForm,
	#instVars : [
		'fee',
		'feeForm',
		'bankAccountInfoForm',
		'bankInfoForm',
		'cancelCallback'
	],
	#category : #'ESUGApp-Form'
}

{ #category : #actions }
ERFeeForm >> cancelForm [
	"feeForm cancel.
	bankAccountInfoForm cancel .
	bankInfoForm cancel.
	fee := fee abortChanges "
	fee := fee abortChanges .
	self initializeForms .
]

{ #category : #hooks }
ERFeeForm >> children [
	^ super children asOrderedCollection copyWithAll: (OrderedCollection new
		add: dialog;
		add: feeForm  ;
		add: bankAccountInfoForm  ;
		add: bankInfoForm;
		add: messageComponent ;
		yourself) yourself
]

{ #category : #initialization }
ERFeeForm >> initialize [
	super initialize.
	fee := controller conference fee.
	self initializeForms.
]

{ #category : #initialization }
ERFeeForm >> initializeForms [
	feeForm := self createFormOf: fee.
	bankAccountInfoForm := self createFormOf: fee bankAccountInformation.
	bankInfoForm := self createFormOf: fee bankAccountInformation bankInformation 
]

{ #category : #updating }
ERFeeForm >> modifyFee: aFee withBankInfo: aBankInfo withAccountBankInfo: anAccountBankInfo [
	aFee bankAccountInformation: anAccountBankInfo.
	aFee bankAccountInformation bankInformation: aBankInfo.
	controller updateFee: aFee.
]

{ #category : #rendering }
ERFeeForm >> renderFormBankAccountInformation: html [
	html heading level: 5;
		with: [ html strong: 'Bank Account Information:'].
	html horizontalRule.
	html render: bankAccountInfoForm 
]

{ #category : #rendering }
ERFeeForm >> renderFormBankInformation: html [
	html heading level: 5;
		with: [ html strong: 'Bank Information:'].
	html horizontalRule.
	html render: bankInfoForm  
]

{ #category : #rendering }
ERFeeForm >> renderFormConferenceFee: html [
	html heading level: 5;
		with: [ html strong: 'Conference Fee:'].
	html horizontalRule.
	html render: messageComponent .
	html render: feeForm .
]

{ #category : #rendering }
ERFeeForm >> renderFormOn: html [
	self renderFormConferenceFee: html.
	self renderFormBankAccountInformation: html.
	self renderFormBankInformation: html.
	self renderButtonsOn: html
]

{ #category : #saving }
ERFeeForm >> save [ 	
	 self modifyFee: feeForm model
			withBankInfo: bankInfoForm model
			withAccountBankInfo: bankAccountInfoForm model
]

{ #category : #saving }
ERFeeForm >> saveForms [
	feeForm save.
	bankAccountInfoForm save.
	bankInfoForm save.
]

{ #category : #accessing }
ERFeeForm >> tabId [ 
	^ 'tabFees'
]

{ #category : #accessing }
ERFeeForm >> tabName [
	^ 'Fee'
]

{ #category : #accessing }
ERFeeForm >> title [
	^ 'Fee'
]

{ #category : #validating }
ERFeeForm >> validateForms [
]
