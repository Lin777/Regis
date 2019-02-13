Class {
	#name : #ERFeeForm1,
	#superclass : #ERConfigurationTab,
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
ERFeeForm1 >> cancel [ 	
	self returnToThePreviousState.
	cancelCallback value
]

{ #category : #accessing }
ERFeeForm1 >> cancelCallback: anObject [
	cancelCallback := anObject
]

{ #category : #hooks }
ERFeeForm1 >> children [
	^ OrderedCollection new
		add: dialog;
		add: feeForm  ;
		add: bankAccountInfoForm  ;
		add: bankInfoForm;
		yourself
]

{ #category : #accessing }
ERFeeForm1 >> content: anObject [
	content := anObject
]

{ #category : #initialization }
ERFeeForm1 >> initialize [
	super initialize.
	self initializeController.
	fee := controller fees first.
	self initializeForms .
	messageComponent := ERAlert warningAlert id: 'formFeeAlert'.
	dialog := ERDialog cancelDialog 
		idOpen: 'cancelAddFee';
		okCallback: [ self cancel ]
]

{ #category : #initialization }
ERFeeForm1 >> initializeForms [
	feeForm := self createFormOf: fee.
	bankAccountInfoForm := self createFormOf: fee bankAccountInformation.
	bankInfoForm := self createFormOf: fee bankAccountInformation bankInformation 
]

{ #category : #rendering }
ERFeeForm1 >> renderAcceptButton: html [
	html mdlButton
		colored;
		beSubmit;
		id: 'acceptAddFee';
		callback: [self saveAndValidateFee];
		with: 'Accept'
]

{ #category : #rendering }
ERFeeForm1 >> renderButtonsOn: html [ 
	self renderCancelButton: html.
	self renderAcceptButton: html
]

{ #category : #rendering }
ERFeeForm1 >> renderCancelButton: html [
	html mdlAnchorButton 
		openDialogWithId: 'cancelAddFee'; 
		colored;
		with: 'Cancel'.
]

{ #category : #rendering }
ERFeeForm1 >> renderContentOn: html [
	html form
		method: 'post';
		id: 'formFee';
		with: [ self renderFormConferenceFee: html.
					self renderFormBankAccountInformation: html.
					self renderFormBankInformation: html.
					self renderButtonsOn: html].
	html render: dialog
]

{ #category : #rendering }
ERFeeForm1 >> renderFormBankAccountInformation: html [
	html heading level: 5;
		with: [ html strong: 'Bank Account Information:'].
	html horizontalRule.
	html render: bankAccountInfoForm 
]

{ #category : #rendering }
ERFeeForm1 >> renderFormBankInformation: html [
	html heading level: 5;
		with: [ html strong: 'Bank Information:'].
	html horizontalRule.
	html render: bankInfoForm  
]

{ #category : #rendering }
ERFeeForm1 >> renderFormConferenceFee: html [
	html heading level: 5;
		with: [ html strong: 'Conference Fee:'].
	html horizontalRule.
	html render: messageComponent .
	html render: feeForm .
]

{ #category : #'as yet unclassified' }
ERFeeForm1 >> saveAndValidateFee [
	[feeForm save.
	bankAccountInfoForm save.
	bankInfoForm save.
	callback cull: feeForm model cull: bankInfoForm model cull: bankAccountInfoForm model]
	on: ERException 
	do: [:exception | messageComponent 
					errorMessage: exception messageText ]
]

{ #category : #accessing }
ERFeeForm1 >> tabId [ 
	^ 'tabFees'
]

{ #category : #accessing }
ERFeeForm1 >> tabName [
	^ 'Fee'
]

{ #category : #accessing }
ERFeeForm1 >> title [
	^ 'Fee'
]
