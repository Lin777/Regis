Class {
	#name : #ERContainerAddFee,
	#superclass : #ERContainerView,
	#instVars : [
		'conference',
		'aFee'
	],
	#category : #'ESUGApp-Components'
}

{ #category : #rendering }
ERContainerAddFee >> renderContentPage: html [
	html div class: 'mdl-js-ripple-effect'; with: [ 
		self renderFormConferenceFee: html
		 ]
]

{ #category : #rendering }
ERContainerAddFee >> renderFormConferenceFee: html [
	self createHeadingStrong: 'Conference Fee:' level: 5 on: html.
	html horizontalRule .
	self createSelectField: 'Currency:' for: #currency: with: #currency list: ERAttendee currencyTypes to: aFee on: html.
	self createDivGridWith: [ 
		self createDivCell6ColWith: [ 
			html strong: 'Early Registration Fee:' .
			self createTextField: 'All days Fee:' for: #erfAllDaysFee: with: #erfAllDaysFee percent: 49 to: aFee on: html.
			self createTextField: 'One day Fee:' for: #erfOneDayFee: with: #erfOneDayFee percent: 49 to: aFee on: html.
			 ] on: html.
		self createDivCell6ColWith: [
			html strong: 'Late Registration Fee:'.
			self createTextField: 'All days Fee:' for: #lrfAllDaysFee: with: #lrfAllDaysFee percent: 49 to: aFee on: html.
			self createTextField: 'One day Fee:' for: #lrfOneDayFee: with: #lrfOneDayFee percent: 49 to: aFee on: html.
			 ] on: html.
	] on: html.
]
