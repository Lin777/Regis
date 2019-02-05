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
	| button |
	listToRenderButton
		do: [ :dataButton | 
			button := html mdlAnchorButton colored;	rippleEffect;
				id: (dataButton third value: aObject);
				callback: [ dataButton second value: aObject ].
			button disabled: ([(dataButton fourth value: aObject) not] on: SubscriptOutOfBounds do: [false]).
			button icon: dataButton first].
	self renderListDownloadButton: html with: aObject.
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
	| downloadButton |
	listToRenderDownloadButton do: [ :dataButton | 
		downloadButton := html mdlAnchorButton colored;	rippleEffect;
			id: (dataButton second value: aObject);
			disabled: (((aObject isKindOf: ERAttendee) and: [aObject encodedInvoice isNotNil]) and: [aObject hasPaid]) not.
		downloadButton isDisabled ifFalse: [ 
			downloadButton url: (dataButton fourth value: aObject);
			attributeAt: 'download' put: (dataButton third value: aObject)].
		downloadButton icon: dataButton first.
	].
]

{ #category : #rendering }
ERTable >> renderTotalRows: html [
	html heading
		level: levelTotal;
		with: [ html strong: 'Total: '.
			html text: listObject size asString ]
]
