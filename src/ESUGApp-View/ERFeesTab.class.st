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
	content state: formFee
]

{ #category : #rendering }
ERFeesTab >> addFeeToConference [
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
ERFeesTab >> initialize [
	super initialize.
]

{ #category : #rendering }
ERFeesTab >> initializeFormAddFee [
	
	fee := ERFee new.
	callback := [ self addFeeToConference ].
	formFee := ERFeeForm
		on: fee
		callback: callback
		withContent: content
]

{ #category : #rendering }
ERFeesTab >> initializeFormModifyFee: aFee [
	callback := [ self modifyFeeOfConference: aFee ].
	formFee := ERFeeForm
		on: aFee
		callback: callback
		withContent: content
]

{ #category : #rendering }
ERFeesTab >> listDataToRenderButton [
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
ERFeesTab >> modifyFee: aFee [
	
	self initializeFormModifyFee: aFee.
	content state: formFee
]

{ #category : #rendering }
ERFeesTab >> modifyFeeOfConference: aFee [
	self returnToThePreviousState.
	^ aFee save.
	
]

{ #category : #rendering }
ERFeesTab >> renderButtonsOfAFee: aFee at: html [
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
ERFeesTab >> renderContainer: html [
	self
		createColoredAnchorButton: 'Add'
		with: [ self addFee ]
		id: 'addFee'
		on: html.
	html horizontalRule.
	self renderTableOfFees: html
]

{ #category : #rendering }
ERFeesTab >> renderTableOfFees: html [
	| table |
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
