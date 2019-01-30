Class {
	#name : #ERModifyForm,
	#superclass : #ERTittledView,
	#instVars : [
		'form',
		'dialog',
		'updateCallback'
	],
	#category : #'ESUGApp-Form'
}

{ #category : #accessing }
ERModifyForm >> content: anObject [
	content := anObject
]

{ #category : #accessing }
ERModifyForm >> dialog [
	^ dialog
]

{ #category : #accessing }
ERModifyForm >> dialog: anObject [
	dialog := anObject
]

{ #category : #accessing }
ERModifyForm >> form [
	^ form
]

{ #category : #accessing }
ERModifyForm >> form: anObject [
	form := anObject
]

{ #category : #initialization }
ERModifyForm >> initializeDialog [
	dialog := ERDialog new
		title: 'Cancel';
		message: 'Are you sure you want to cancel?';
		idClose: 'buttonClose';
		idOpen: 'cancel-change-affiliation';
		okCallback: cancelCallback
]

{ #category : #rendering }
ERModifyForm >> renderAcceptButtonOn: html [
	self
		createColoredButton: 'Accept'
		with: updateCallback 
		id: 'accept-change-affiliation'
		on: html
]

{ #category : #rendering }
ERModifyForm >> renderButtons: html [
	self renderAcceptButtonOn: html.
			self renderCancelButtonOn: html 
]

{ #category : #rendering }
ERModifyForm >> renderCancelButtonOn: html [
	self initializeDialog .
	self createColoredAnchorButton: 'Cancel' id: 'cancel-change-affiliation' on: html
]

{ #category : #rendering }
ERModifyForm >> renderFormOn: html [
	html render: form
]

{ #category : #rendering }
ERModifyForm >> renderPageOn: html [
	html form
		method: 'post';
		id: 'formUpdateAffiliation';
		with: [ self renderFormOn: html.
			self renderButtons: html ].
	html render: dialog 
]

{ #category : #accessing }
ERModifyForm >> title [
	^ title
]

{ #category : #accessing }
ERModifyForm >> title: anObject [
	title := anObject
]

{ #category : #accessing }
ERModifyForm >> updateCallback: anObject [
	updateCallback := anObject 
]
