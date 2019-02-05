Class {
	#name : #ERFeeForm,
	#superclass : #ERContainer,
	#instVars : [
		'fee',
		'callback',
		'dialog',
		'feeForm',
		'bankAccountInfoForm',
		'bankInfoForm',
		'cancelCallback',
		'messageComponent'
	],
	#category : #'ESUGApp-Form'
}

{ #category : #'as yet unclassified' }
ERFeeForm class >> on: aFee callback: block1 cancel: block2 withContent: aContent [
	| form |
	form := self new.
	form fee: aFee.
	form callback: block1.
	form cancelCallback: block2 .
   form content: aContent.
	form initializeForms.
	^ form
]

{ #category : #'as yet unclassified' }
ERFeeForm class >> on: aFee callback: aBlock withContent: aContent [
	| form |
	form := self new.
	form fee: aFee.
	form callback: aBlock.
   form content: aContent.
	form initializeForms.
	^ form
]

{ #category : #accessing }
ERFeeForm >> callback: anObject [
	callback := anObject
]

{ #category : #rendering }
ERFeeForm >> cancel [ 	
	self returnToThePreviousState.
	cancelCallback value
]

{ #category : #accessing }
ERFeeForm >> cancelCallback: anObject [
	cancelCallback := anObject
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
	messageComponent := ERAlert warningAlert id: 'formConferenceAlert'.
	dialog := ERDialog cancelDialog 
		idOpen: 'cancelAddFee';
		okCallback: [ self cancel ]
]

{ #category : #initialization }
ERFeeForm >> initializeForms [
	feeForm := self createFormOf: fee.
	bankAccountInfoForm := self createFormOf: fee bankAccountInformation.
	bankInfoForm := self createFormOf: fee bankAccountInformation bankInformation 
]

{ #category : #rendering }
ERFeeForm >> renderAcceptButton: html [
	html mdlButton
		colored;
		beSubmit;
		id: 'acceptAddFee';
		callback: [self saveAndValidateFee];
		with: 'Accept'
]

{ #category : #rendering }
ERFeeForm >> renderButtonsOn: html [ 
	self renderCancelButton: html.
	self renderAcceptButton: html
]

{ #category : #rendering }
ERFeeForm >> renderCancelButton: html [
	html mdlAnchorButton 
		openDialogWithId: 'cancelAddFee'; 
		colored;
		with: 'Cancel'.
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
					self renderButtonsOn: html ] ].
			html render: dialog
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
ERFeeForm >> saveAndValidateFee [
	[feeForm save.
	bankAccountInfoForm save.
	bankInfoForm save.
	callback cull: feeForm model cull: bankInfoForm model cull: bankAccountInfoForm model]
	on: ERException 
	do: [:exception | messageComponent 
					errorMessage: exception messageText ]
]
