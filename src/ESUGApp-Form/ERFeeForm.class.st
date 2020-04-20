"
Description
--------------------

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

{ #category : #accessing }
ERFeeForm >> bankAccountInformation [

	^ fee bankAccountInformation
]

{ #category : #accessing }
ERFeeForm >> bankInformation [

	^ self bankAccountInformation bankInformation
]

{ #category : #actions }
ERFeeForm >> cancelForm [
	"Cancel form changes"

	fee := fee abortChanges.
	self initializeForms.
]

{ #category : #hooks }
ERFeeForm >> children [

	^ super children 
		asOrderedCollection 
		copyWithAll: (self sectionFormElements) 
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
	bankAccountInfoForm := self createFormOf: self bankAccountInformation.
	bankInfoForm := self createFormOf: self bankInformation
]

{ #category : #actions }
ERFeeForm >> modifyFee: aFee withBankInfo: aBankInfo withAccountBankInfo: anAccountBankInfo [

	aFee bankAccountInformation: anAccountBankInfo.
	aFee bankAccountInformation bankInformation: aBankInfo.
	controller updateFee: aFee.
]

{ #category : #rendering }
ERFeeForm >> renderFormBankAccountInformation: html [

	html heading 
		level: 3;
		with: 'Bank Account Information'.
	html horizontalRule.
	html render: bankAccountInfoForm 
]

{ #category : #rendering }
ERFeeForm >> renderFormBankInformation: html [

	html heading 
		level: 3;
		with: 'Bank Information'.
	html horizontalRule.
	html render: bankInfoForm  
]

{ #category : #rendering }
ERFeeForm >> renderFormConferenceFee: html [

	html heading 
		level: 3;
		with: 'Conference Fee'.
	html horizontalRule.
	html render: messageComponent .
	html render: feeForm .
]

{ #category : #rendering }
ERFeeForm >> renderFormOn: html [

	self renderFormTitleOn: html.
	self renderFormConferenceFee: html.
	self renderFormBankAccountInformation: html.
	self renderFormBankInformation: html.
	self renderButtonsOn: html
]

{ #category : #rendering }
ERFeeForm >> renderFormTitleOn: html [
	"Render general title in fee configuration"

	html heading 
		level: 2;
		with: self title.
]

{ #category : #actions }
ERFeeForm >> save [ 	
	
	 self modifyFee: feeForm model
			withBankInfo: bankInfoForm model
			withAccountBankInfo: bankAccountInfoForm model
]

{ #category : #actions }
ERFeeForm >> saveForms [

	feeForm save.
	bankAccountInfoForm save.
	bankInfoForm save.
]

{ #category : #accessing }
ERFeeForm >> sectionFormElements [

	^ OrderedCollection new
		add: dialog;
		add: feeForm;
		add: bankAccountInfoForm ;
		add: bankInfoForm;
		add: messageComponent;
		yourself
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

	^ 'Fee Configuration'
]

{ #category : #validating }
ERFeeForm >> validateForms [
	"Need implementation"
]
