Class {
	#name : #ERFeesTab,
	#superclass : #ERConfigurationTab,
	#instVars : [
		'formFee',
		'fee'
	],
	#category : #'ESUGApp-View-Tab'
}

{ #category : #rendering }
ERFeesTab >> addFee [
	self initializeFormAddFee.
	content state: formFee.
	self updateStateTab: self tabName 
]

{ #category : #rendering }
ERFeesTab >> addFee: aFee withBankInfo: aBankInfo withAccountBankInfo: anAccountBankInfo [
	aFee bankAccountInformation: anAccountBankInfo.
	aFee bankAccountInformation bankInformation: aBankInfo.
	controller addFee: aFee.
	self returnToThePreviousState
]

{ #category : #rendering }
ERFeesTab >> addFeeToConference [
	| aFee |
	aFee := controller addFee: fee.
	self returnToThePreviousState
]

{ #category : #rendering }
ERFeesTab >> blockTableToExecute [
	^ [ :aFee | 
	OrderedCollection new
		add: ([ :att | att currency ] value: aFee);
		add: ([ :att | att erfAllDaysFee ] value: aFee);
		add: ([ :att | att erfOneDayFee ] value: aFee);
		add: ([ :att | att lrfAllDaysFee ] value: aFee);
		add: ([ :att | att lrfOneDayFee ] value: aFee);
		yourself ]
]

{ #category : #rendering }
ERFeesTab >> deleteFee: aFee [
	controller deleteFee: aFee
]

{ #category : #rendering }
ERFeesTab >> fees [
	^ controller fees
]

{ #category : #rendering }
ERFeesTab >> headers [
	^ #('Currency(D)' 'Early Days' 'Early One Day' 'Late All Days' 'Late One Day' '')
]

{ #category : #rendering }
ERFeesTab >> initializeFormAddFee [
	fee := ERFee new.
	callback := [ self addFeeToConference ].
	formFee := ERFeeForm
		on: fee
		callback: [ :a :b :c | self addFee: a withBankInfo: b
			withAccountBankInfo: c]
		cancel: [ self updateStateTab: self tabName. ]
		withContent: content
]

{ #category : #rendering }
ERFeesTab >> initializeFormModifyFee: aFee [
	formFee := ERFeeForm
		on: aFee
		callback: [ :a :b :c | self modifyFee: a withBankInfo: b 
			withAccountBankInfo: c ]
		cancel: [ self updateStateTab: self tabName. ]
		withContent: content
]

{ #category : #rendering }
ERFeesTab >> listDataToRenderButton [
	^ OrderedCollection new
		add:
			(Array
				with: 'edit'
				with: [ :aFee | self modifyFee: aFee ]
				with: [ :aFee | aFee id , '-modify' ]
				with: 'Modify');
		add:
			(Array
				with: 'delete'
				with: [ :aFee | self deleteFee: aFee ]
				with: [ :aFee | aFee id , '-delete' ]
				with: 'Delete');
		yourself
]

{ #category : #rendering }
ERFeesTab >> modifyFee: aFee [
	
	self initializeFormModifyFee: aFee.
	content state: formFee
]

{ #category : #rendering }
ERFeesTab >> modifyFee: aFee withBankInfo: aBankInfo withAccountBankInfo: anAccountBankInfo [
	aFee bankAccountInformation: anAccountBankInfo.
	aFee bankAccountInformation bankInformation: aBankInfo.
	controller updateFee: aFee.
	self returnToThePreviousState.
	self updateStateTab: self tabName
	
]

{ #category : #rendering }
ERFeesTab >> modifyFeeOfConference: aFee [
	self returnToThePreviousState.
	^ aFee save.
	
]

{ #category : #rendering }
ERFeesTab >> renderContainer: html [
	html mdlAnchorButton
		colored;
		id: 'addFee';
		callback: [ self addFee ];
		with: 'Add'.
	html horizontalRule.
	self renderTableOfFees: html
]

{ #category : #rendering }
ERFeesTab >> renderTableOfFees: html [
	table := ERTable new
		headers: self headers;
		levelTotal: 6;
		listObject: self fees;
		blockToExecute: self blockTableToExecute;
		listToRenderButton: self listDataToRenderButton.
	html render: table
]

{ #category : #accessing }
ERFeesTab >> tabId [ 
	^ 'tabFees'
]

{ #category : #accessing }
ERFeesTab >> tabName [
	^ 'Fees'
]

{ #category : #accessing }
ERFeesTab >> title [
	^ 'Fees'
]
