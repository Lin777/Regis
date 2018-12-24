Class {
	#name : #ERContainerModifyAffiliationView,
	#superclass : #ERGeneralContainerView,
	#category : #'ESUGApp-Components'
}

{ #category : #rendering }
ERContainerModifyAffiliationView >> cancel [
	content state: content lastState
]

{ #category : #accessing }
ERContainerModifyAffiliationView >> content: anObject [
	content := anObject
]

{ #category : #rendering }
ERContainerModifyAffiliationView >> renderAcceptButtonOn: html [
	self
		createColoredButton: 'Accept'
		with: acceptCallback 
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
		createColoredButton: 'Cancel'
		with: [ self cancel ]
		id: 'cancel-change-affiliation'
		on: html
	
]

{ #category : #rendering }
ERContainerModifyAffiliationView >> renderFormOn: html [
	html render: (ERAffiliationInformation on: attendee)
]

{ #category : #rendering }
ERContainerModifyAffiliationView >> renderPageOn: html [
	html form
		method: 'post';
		id: 'formModifyAffiliation';
		with: [ self renderFormOn: html.
			self renderButtons: html ]
]

{ #category : #rendering }
ERContainerModifyAffiliationView >> title [
	^ 'Affiliation Information'
]
