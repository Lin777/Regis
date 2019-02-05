Class {
	#name : #ERTable,
	#superclass : #ERComponentFactory,
	#instVars : [
		'blockToExecute',
		'listToRenderButton',
		'listObject',
		'levelTotal',
		'headers'
	],
	#category : #'ESUGApp-Component'
}

{ #category : #accessing }
ERTable >> blockToExecute: anObject [
	blockToExecute := anObject
]

{ #category : #accessing }
ERTable >> headers: anObject [
	headers := anObject
]

{ #category : #initialization }
ERTable >> initialize [
	"blockToExecute listToRenderButton listObject levelTotal headers"
	super initialize.
	listToRenderButton := OrderedCollection new.
	listObject := OrderedCollection new.
	levelTotal := 6.
	headers := OrderedCollection new.
]

{ #category : #accessing }
ERTable >> levelTotal: anObject [
	levelTotal := anObject
]

{ #category : #accessing }
ERTable >> listObject: anObject [
	listObject := anObject
]

{ #category : #accessing }
ERTable >> listToRenderButton: anObject [
	listToRenderButton := anObject
]

{ #category : #rendering }
ERTable >> render: html with: aObject [
	| listContent |
	listContent := blockToExecute value: aObject.
	listContent do: [ :content |
		html mdlTableCell nonNumerical; with: content.
	].
	html mdlTableCell nonNumerical; with: [ self renderButton: html with: aObject ]
	
]

{ #category : #rendering }
ERTable >> renderBody: html [
	html tableBody: [ 
		listObject do: [ :object | 
			html tableRow: [ 
				self render: html with: object ] ] ]
]

{ #category : #rendering }
ERTable >> renderButton: html with: aObject [
	listToRenderButton
		do: [ :dataButton | 
			html mdlAnchorButton
		colored;
		id: (dataButton third value: aObject);
		callback: [ dataButton second value: aObject ];
		with: dataButton first]
]

{ #category : #rendering }
ERTable >> renderContentOn: html [
	html div style: 'overflow-x:auto;';
	with: [ 
		html mdlTable class: 'mdl-shadow--2p';
		style: 'width:100%;';
		with: [ 
			self renderHeaders: html.
			self renderBody: html. 
		]
	].
	self renderTotalRows: html.
]

{ #category : #rendering }
ERTable >> renderHeaders: html [
	html tableHead: [ 
		html tableRow: [ 
			headers do: [ :each | 
				html mdlTableHeading nonNumerical; with: each ] ] ]
]

{ #category : #rendering }
ERTable >> renderTotalRows: html [
	html heading
		level: levelTotal;
		with: [ html strong: 'Total: '.
			html text: listObject size asString ]
]
