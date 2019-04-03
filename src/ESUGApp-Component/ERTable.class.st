"
Description
--------------------

I am a personalized table, I render la list of objects.

Instance Variables
--------------------
	headers:     			list of strings.
	listObject:  			list of object.
	blockToExecute:    	block with info how render each object of the list.
	listToRenderButton:   block only necesary if tht table will have a buttons for each row (e.g. delete, update)
"
Class {
	#name : #ERTable,
	#superclass : #ERComponentFactory,
	#instVars : [
		'blockToExecute',
		'listToRenderButton',
		'listObject',
		'levelTotal',
		'headers',
		'dictToRenderDownloadButton'
	],
	#category : #'ESUGApp-Component'
}

{ #category : #accessing }
ERTable >> blockToExecute: anObject [
	blockToExecute := anObject
]

{ #category : #accessing }
ERTable >> dictToRenderDownloadButton: aDictionary [
	dictToRenderDownloadButton := aDictionary 
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
	dictToRenderDownloadButton := Dictionary new.
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
	listContent := blockToExecute valueWithPossibleArgs: {aObject. html}.
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
			html mdlAnchorButton colored; rippleEffect;
				id: (dataButton third value: aObject);
				onClick: dataButton fifth ;
				disabled: (dataButton sixth ifTrue: 'disabled');
				callback: [ dataButton second value: aObject ];
				icon: dataButton first.
			html div	class: 'mdl-tooltip'; 
				attributeAt: 'data-mdl-for' put: (dataButton third value: aObject) ;
				with: dataButton fourth].
	self renderDownloadButton: html with: aObject
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
ERTable >> renderDownloadButton: html with: aObject [
	dictToRenderDownloadButton ifNotEmpty: [ 
		| downloadButton |
		downloadButton := html mdlAnchorButton colored;	rippleEffect;
			id: ((dictToRenderDownloadButton at: 'id') value: aObject).
		downloadButton isDisabled ifFalse: [ 
			downloadButton url: ((dictToRenderDownloadButton at: 'url') value: aObject);
			attributeAt: 'download' put: ((dictToRenderDownloadButton at: 'download') value: aObject)].
		downloadButton icon: (dictToRenderDownloadButton at: 'icon').
		html div	class: 'mdl-tooltip'; 
				attributeAt: 'data-mdl-for' put: ((dictToRenderDownloadButton at: 'id') value: aObject) ;
				with: 'Download invoice'].
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
