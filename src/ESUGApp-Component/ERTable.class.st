Class {
	#name : #ERTable,
	#superclass : #ERComponentFactory,
	#instVars : [
		'blockToExecute',
		'listToRenderButton',
		'listObject',
		'levelTotal',
		'headers',
		'listToRenderDownloadButton'
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
	listToRenderDownloadButton := OrderedCollection new.
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

{ #category : #accessing }
ERTable >> listToRenderDownloadButton: aCollection [
	listToRenderDownloadButton := aCollection
]

{ #category : #rendering }
ERTable >> render: html with: aObject [
	| listContent |
	listContent := blockToExecute value: aObject.
	listContent do: [ :content |
		html mdlTableHeading: content
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
			html mdlAnchorButton
		colored;	rippleEffect;
		id: (dataButton third value: aObject);
		callback: [ dataButton second value: aObject ];
		icon: dataButton first].
	self renderListDownloadButton: html with: aObject.
			"self
				createColoredAnchorButton: dataButton first
				with: [ dataButton second value: aObject ]
				id: (dataButton third value: aObject)
				on: html ]"
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
				html mdlTableHeading: each ] ] ]
]

{ #category : #rendering }
ERTable >> renderListDownloadButton: html with: aObject [
	listToRenderDownloadButton do: [ :dataButton | 
		html mdlAnchorButton colored;	rippleEffect;
			icon: dataButton first;
			id: (dataButton second value: aObject);
			callback: [dataButton third value: aObject];
			disabled: ((aObject isKindOf: ERAttendee) and: [aObject encodedInvoice isNotNil]) not;
			attributeAt: 'download' put: (dataButton fourth)
	].
]

{ #category : #rendering }
ERTable >> renderTotalRows: html [
	html heading
		level: levelTotal;
		with: [ html strong: 'Total: '.
			html text: listObject size asString ]
]
