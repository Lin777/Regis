Class {
	#name : #ERFees,
	#superclass : #ERConfiguration,
	#instVars : [
		'formFee',
		'fee'
	],
	#category : #'ESUGApp-Components'
}

{ #category : #rendering }
ERFees >> addFee [
	self initializeFormAddFee.
	content state: formFee
]

{ #category : #rendering }
ERFees >> addFeeToConference [
	| aFee |
	fee bankAccountInformation bankInformation save.
	fee bankAccountInformation save.
	aFee := fee save.
	controller conference addFee: aFee.
	controller conference save.
	self returnToThePreviousState.
	^ aFee
]

{ #category : #rendering }
ERFees >> blockTableToExecute [
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
ERFees >> deleteFee: aFee [
	controller deleteFee: aFee
]

{ #category : #rendering }
ERFees >> fees [
	^ controller fees
]

{ #category : #rendering }
ERFees >> headers [
	^ #('Currency(D)' 'Early Days' 'Early One Day' 'Late All Days' 'Late One Day' '')
]

{ #category : #rendering }
ERFees >> initialize [
	super initialize.
]

{ #category : #rendering }
ERFees >> initializeFormAddFee [
	
	fee := ERFee new.
	callback := [ self addFeeToConference ].
	formFee := ERContainerFormFee
		on: fee
		callback: callback
		withContent: content
]

{ #category : #rendering }
ERFees >> initializeFormModifyFee: aFee [
	callback := [ self modifyFeeOfConference: aFee ].
	formFee := ERContainerFormFee
		on: aFee
		callback: callback
		withContent: content
]

{ #category : #rendering }
ERFees >> listDataToRenderButton [
	^ OrderedCollection new
		add:
			(Array
				with: 'Modify'
				with: [ :aFee | self modifyFee: aFee ]
				with: [ :aFee | aFee id , '-modify' ]);
		add:
			(Array
				with: 'Delete'
				with: [ :aFee | self deleteFee: aFee ]
				with: [ :aFee | aFee id , '-delete' ]);
		yourself
]

{ #category : #rendering }
ERFees >> modifyFee: aFee [
	
	self initializeFormModifyFee: aFee.
	content state: formFee
]

{ #category : #rendering }
ERFees >> modifyFeeOfConference: aFee [
	self returnToThePreviousState.
	^ aFee save.
	
]

{ #category : #rendering }
ERFees >> renderButtonsOfAFee: aFee at: html [
	self
		createColoredButton: 'Modify'
		with: [ self modifyRegistrationInformation: aFee ]
		id: aFee id , '-modify'
		on: html.
	self
		createColoredButton: 'Delete'
		with: [ self deleteAttendeeFromGroup: aFee ]
		id: aFee id , '-delete'
		on: html.
]

{ #category : #rendering }
ERFees >> renderContainer: html [
	self
		createColoredAnchorButton: 'Add'
		with: [ self addFee ]
		id: 'addFee'
		on: html.
	html horizontalRule.
	self renderTableOfFees: html
]

{ #category : #rendering }
ERFees >> renderTableOfFees: html [
	| table |
	table := ERTableGenericData new
		headers: self headers;
		levelTotal: 6;
		listObject: self fees;
		blockToExecute: self blockTableToExecute;
		listToRenderButton: self listDataToRenderButton.
	html render: table
]

{ #category : #accessing }
ERFees >> tabId [ 
	^ 'tabFees'
]

{ #category : #accessing }
ERFees >> tabName [
	^ 'Fees'
]

{ #category : #accessing }
ERFees >> title [
	^ 'Fees'
]
