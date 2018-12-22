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
	html mdlButton
		colored;
		id: 'accept-change-affiliation';
		callback: [ self updateAffiliationInformation ];
		with: 'Accept'
]

{ #category : #rendering }
ERContainerModifyAffiliationView >> renderButtons: html [
	self renderAcceptButtonOn: html.
			self renderCancelButtonOn: html 
]

{ #category : #rendering }
ERContainerModifyAffiliationView >> renderCancelButtonOn: html [
	html mdlButton
		colored;
		id: 'cancel-change-affiliation';
		callback: [ self cancel ];
		with: 'Cancel'
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

{ #category : #rendering }
ERContainerModifyAffiliationView >> updateAffiliationInformation [
	attendee save.
	self cancel
]
