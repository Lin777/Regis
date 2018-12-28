Class {
	#name : #ERTableOfFees,
	#superclass : #ERTable,
	#category : #'ESUGApp-Form'
}

{ #category : #rendering }
ERTableOfFees >> headers [
	^ #('Currency(D)' 'Early Days' 'Early One Day' 'Late All Days' 'Late One Day' '')
]

{ #category : #rendering }
ERTableOfFees >> renderAnItem: anItem at: html [
	html mdlTableHeading: anItem currency.
	html mdlTableHeading: anItem erfAllDaysFee.
	html mdlTableHeading: anItem erfOneDayFee.
	html mdlTableHeading: anItem lrfAllDaysFee.
	html mdlTableHeading: anItem lrfOneDayFee.
	html mdlTableHeading: [ self renderButtonsOfAFee: anItem at: html ]
]

{ #category : #rendering }
ERTableOfFees >> renderButtonsOfAFee: aFee at: html [
	self
		createColoredButton: 'Modify'
		with: [ self modifyRegistrationInformation: aFee ]
		id: aFee id , '-modify'
		on: html.
	self
		createColoredButton: 'Delete'
		with: [ self deleteAttendeeFromGroup: aFee ]
		id: aFee id , '-delete'
		on: html
]
