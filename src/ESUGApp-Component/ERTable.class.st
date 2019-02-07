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
		html mdlTableHeading: content.
	].
	html mdlTableHeading: [ self renderButton: html with: aObject ]
	
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
			html mdlAnchorButton colored;	rippleEffect;
			id: (dataButton third value: aObject);
			callback: [ dataButton second value: aObject ];
			icon: dataButton first ].
	self renderDownloadButton: html with: aObject.
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
			id: ((dictToRenderDownloadButton at: 'id') value: aObject);
			disabled: ((dictToRenderDownloadButton at: 'disabled') value: aObject).
		downloadButton isDisabled ifFalse: [ 
			downloadButton url: ((dictToRenderDownloadButton at: 'url') value: aObject);
			attributeAt: 'download' put: ((dictToRenderDownloadButton at: 'download') value: aObject)].
		downloadButton icon: (dictToRenderDownloadButton at: 'icon').
	].
]

{ #category : #rendering }
ERTable >> renderHeaders: html [
	html tableHead: [ 
		html tableRow: [ 
			headers do: [ :each | 
				html mdlTableHeading: each ] ] ]
]

{ #category : #rendering }
ERTable >> renderTotalRows: html [
	html heading
		level: levelTotal;
		with: [ html strong: 'Total: '.
			html text: listObject size asString ]
]
