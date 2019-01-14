Class {
	#name : #ERModifyAffiliationForm,
	#superclass : #ERTittledView,
	#instVars : [
		'formAffiliation',
		'dialog',
		'updateCallback'
	],
	#category : #'ESUGApp-Form'
}

{ #category : #accessing }
ERModifyAffiliationForm >> content: anObject [
	content := anObject
]

{ #category : #initialization }
ERModifyAffiliationForm >> initializeDialog [
	dialog := ERDialog new
		title: 'Cancel Modify Affiliation';
		message: 'Are you sure you want to cancel?';
		idClose: 'buttonClose';
		idOpen: 'cancel-change-affiliation';
		okCallback: cancelCallback
]

{ #category : #initialization }
ERModifyAffiliationForm >> initializeFormAffiliation [
	formAffiliation := ERAffiliationInformationForm on: attendee
]

{ #category : #rendering }
ERModifyAffiliationForm >> renderAcceptButtonOn: html [
	self
		createColoredButton: 'Accept'
		with: updateCallback 
		id: 'accept-change-affiliation'
		on: html
]

{ #category : #rendering }
ERModifyAffiliationForm >> renderButtons: html [
	self renderAcceptButtonOn: html.
			self renderCancelButtonOn: html 
]

{ #category : #rendering }
ERModifyAffiliationForm >> renderCancelButtonOn: html [
	self initializeDialog .
	self createColoredAnchorButton: 'Cancel' id: 'cancel-change-affiliation' on: html
]

{ #category : #rendering }
ERModifyAffiliationForm >> renderFormOn: html [
	self initializeFormAffiliation .
	html render: formAffiliation
]

{ #category : #rendering }
ERModifyAffiliationForm >> renderPageOn: html [
	html form
		method: 'post';
		id: 'formUpdateAffiliation';
		with: [ self renderFormOn: html.
			self renderButtons: html ].
	html render: dialog 
]

{ #category : #rendering }
ERModifyAffiliationForm >> title [
	^ 'Affiliation Information'
]

{ #category : #accessing }
ERModifyAffiliationForm >> updateCallback: anObject [
	updateCallback := anObject 
]
