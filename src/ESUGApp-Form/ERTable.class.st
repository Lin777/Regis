Class {
	#name : #ERTable,
	#superclass : #ERStateContent,
	#instVars : [
		'listOfTable'
	],
	#category : #'ESUGApp-Form'
}

{ #category : #accessing }
ERTable class >> list: aList [
	^ self new listOfTable: aList ; yourself
]

{ #category : #rendering }
ERTable >> headers [
	self subclassResponsibility 
]

{ #category : #accessing }
ERTable >> listOfTable [
	^ listOfTable
]

{ #category : #accessing }
ERTable >> listOfTable: anObject [
	listOfTable := anObject
]

{ #category : #rendering }
ERTable >> renderAnItem: anItem at: html [
	self subclassResponsibility 
]

{ #category : #rendering }
ERTable >> renderBody: html [
	html
		tableBody: [ self listOfTable
				do:
					[ :anItem | html tableRow: [ self renderAnItem: anItem at: html ] ] ]
]

{ #category : #rendering }
ERTable >> renderContentOn: html [
	self renderTableOfAttends: html.
	self renderTotalRows: html
]

{ #category : #rendering }
ERTable >> renderHeaders: html [
	html
		tableHead: [ html
				tableRow: [ self headers do: [ :each | html mdlTableHeading: each ] ] ]
]

{ #category : #rendering }
ERTable >> renderTableOfAttends: html [
	html div
		style: 'overflow-x:auto;';
		with: [ html mdlTable
				class: 'mdl-shadow--2dp';
				style: 'width:100%;';
				with: [ self renderHeaders: html.
					self renderBody: html ] ].
	self renderTotalRows: html
]

{ #category : #rendering }
ERTable >> renderTotalRows: html [
	self
		createHeadingStrong: 'Total: '
		level: 6
		withValue: self listOfTable size asString
		on: html
]
