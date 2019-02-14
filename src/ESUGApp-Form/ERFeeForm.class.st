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
	feeForm cancel.
	bankAccountInfoForm cancel .
	bankInfoForm cancel.
	fee := fee abortChanges 
]

{ #category : #hooks }
ERFeeForm >> children [
	^ OrderedCollection new
		add: dialog;
		add: feeForm  ;
		add: bankAccountInfoForm  ;
		add: bankInfoForm;
		yourself
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

{ #category : #'as yet unclassified' }
ERFeeForm >> modifyFee: aFee withBankInfo: aBankInfo withAccountBankInfo: anAccountBankInfo [
	aFee bankAccountInformation: anAccountBankInfo.
	aFee bankAccountInformation bankInformation: aBankInfo.
	controller updateFee: aFee.
]

{ #category : #rendering }
ERFeeForm >> renderForm: html [
	self renderFormConferenceFee: html.
	self renderFormBankAccountInformation: html.
	self renderFormBankInformation: html.
	self renderButtonsOn: html
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

{ #category : #'as yet unclassified' }
ERFeeForm >> save [ 	
	 self modifyFee: feeForm model
			withBankInfo: bankInfoForm model
			withAccountBankInfo: bankAccountInfoForm model
]

{ #category : #'as yet unclassified' }
ERFeeForm >> saveAndValidateFee [
	[feeForm save.
	bankAccountInfoForm save.
	bankInfoForm save.
	callback cull: feeForm model cull: bankInfoForm model cull: bankAccountInfoForm model]
	on: ERException 
	do: [:exception | messageComponent 
					errorMessage: exception messageText ]
]

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
ERFeeForm >> validateForms [
]
