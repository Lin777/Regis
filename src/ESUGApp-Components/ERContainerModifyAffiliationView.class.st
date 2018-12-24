Class {
	#name : #ERContainerModifyAffiliationView,
	#superclass : #ERGeneralContainerView,
	#instVars : [
		'formAffiliation'
	],
	#category : #'ESUGApp-Components'
}

{ #category : #accessing }
ERContainerModifyAffiliationView >> content: anObject [
	content := anObject
]

{ #category : #initialization }
ERContainerModifyAffiliationView >> initializeFormAffiliation [
	formAffiliation := ERAffiliationInformation on: attendee
]

{ #category : #rendering }
ERContainerModifyAffiliationView >> renderAcceptButtonOn: html [
	self
		createColoredButton: 'Accept'
		with: [ self updateAffiliation ]
		id: 'accept-change-affiliation'
		on: html
]

{ #category : #rendering }
ERContainerModifyAffiliationView >> renderButtons: html [
	self renderAcceptButtonOn: html.
			self renderCancelButtonOn: html 
]

{ #category : #rendering }
ERContainerModifyAffiliationView >> renderCancelButtonOn: html [
	self
		createColoredAnchorButton: 'Cancel'
		with: cancelCallback
		id: 'cancel-change-affiliation'
		on: html
]

{ #category : #rendering }
ERContainerModifyAffiliationView >> renderFormOn: html [
	self initializeFormAffiliation .
	html render: formAffiliation
]

{ #category : #rendering }
ERContainerModifyAffiliationView >> renderPageOn: html [
	html form
		method: 'post';
		id: 'formUpdateAffiliation';
		with: [ self renderFormOn: html.
			self renderButtons: html ]
]

{ #category : #rendering }
ERContainerModifyAffiliationView >> title [
	^ 'Affiliation Information'
]

{ #category : #rendering }
ERContainerModifyAffiliationView >> updateAffiliation [
	attendee save.
	self returnToThePreviousState
]
