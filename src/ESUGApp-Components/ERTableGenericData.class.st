Class {
	#name : #ERTableGenericData,
	#superclass : #ERComponentFactory,
	#instVars : [
		'blockToExecute',
		'listToRenderButton',
		'listObject',
		'levelTotal',
		'headers'
	],
	#category : #'ESUGApp-Components'
}

{ #category : #accessing }
ERTableGenericData >> blockToExecute: anObject [
	blockToExecute := anObject
]

{ #category : #accessing }
ERTableGenericData >> headers: anObject [
	headers := anObject
]

{ #category : #initialization }
ERTableGenericData >> initialize [
	"blockToExecute listToRenderButton listObject levelTotal headers"
	super initialize.
	listToRenderButton := OrderedCollection new.
	listObject := OrderedCollection new.
	levelTotal := 6.
	headers := OrderedCollection new.
]

{ #category : #accessing }
ERTableGenericData >> levelTotal: anObject [
	levelTotal := anObject
]

{ #category : #accessing }
ERTableGenericData >> listObject: anObject [
	listObject := anObject
]

{ #category : #accessing }
ERTableGenericData >> listToRenderButton: anObject [
	listToRenderButton := anObject
]

{ #category : #rendering }
ERTableGenericData >> render: html with: aObject [
	| listContent |
	listContent := blockToExecute value: aObject.
	listContent do: [ :content |
		html mdlTableHeading: content
	].
	html mdlTableHeading: [ self renderButton: html with: aObject ]
	
]

{ #category : #rendering }
ERTableGenericData >> renderBody: html [
	html tableBody: [ 
		listObject do: [ :object | 
			html tableRow: [ 
				self render: html with: object ] ] ]
]

{ #category : #rendering }
ERTableGenericData >> renderButton: html with: aObject [
	listToRenderButton
		do: [ :dataButton | 
			self
				createColoredAnchorButton: dataButton first
				with: [ dataButton second value: aObject ]
				id: (dataButton third value: aObject)
				on: html ]
]

{ #category : #rendering }
ERTableGenericData >> renderContentOn: html [
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
ERTableGenericData >> renderHeaders: html [
	html tableHead: [ 
		html tableRow: [ 
			headers do: [ :each | 
				html mdlTableHeading: each ] ] ]
]

{ #category : #rendering }
ERTableGenericData >> renderTotalRows: html [
	html heading
		level: levelTotal;
		with: [ html strong: 'Total: '.
			html text: listObject size asString ]
]
