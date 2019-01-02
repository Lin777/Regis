Class {
	#name : #ERFees,
	#superclass : #ERConfiguration,
	#instVars : [
		'formAddFee'
	],
	#category : #'ESUGApp-Components'
}

{ #category : #rendering }
ERFees >> addFee [
	self initializeFormAddFee  .
	content state: formAddFee 
]

{ #category : #rendering }
ERFees >> fees [
	^ OrderedCollection new
]

{ #category : #rendering }
ERFees >> headers [
	^ #('Currency(D)' 'Early Days' 'Early One Day' 'Late All Days' 'Late One Day' '')
]

{ #category : #rendering }
ERFees >> initializeFormAddFee [
	formAddFee := (ERContainerAddFee on: attendee withContent: content)
]

{ #category : #rendering }
ERFees >> renderAnAttendee: aFee at: html [
	html mdlTableHeading: aFee currency.
	html mdlTableHeading: aFee erfAllDaysFee.
	html mdlTableHeading: aFee erfOneDayFee.
	html mdlTableHeading: aFee lrfAllDaysFee.
	html mdlTableHeading: aFee lrfOneDayFee.
	html
		mdlTableHeading: [ self renderButtonsOfAFee: aFee at: html ]
]

{ #category : #rendering }
ERFees >> renderBody: html [
	html
		tableBody: [ self fees
				do:
					[ :anAttendee | html tableRow: [ self renderAnAttendee: anAttendee at: html ] ] ]
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
	html horizontalRule .
	self renderTable: html
]

{ #category : #rendering }
ERFees >> renderHeaders: html [
	html
		tableHead: [ html
				tableRow: [ self headers do: [ :each | html mdlTableHeading: each ] ] ]
]

{ #category : #rendering }
ERFees >> renderTable: html [
	html div
		style: 'overflow-x:auto;';
		with: [ html mdlTable
				class: 'mdl-shadow--2dp';
				style: 'width:100%;';
				with: [ self renderHeaders: html.
					self renderBody: html ] ]
]

{ #category : #accessing }
ERFees >> tabId [
	^ 'fees'
]

{ #category : #accessing }
ERFees >> tabName [
	^ 'Fees'
]

{ #category : #accessing }
ERFees >> title [
	^ 'Fees'
]
