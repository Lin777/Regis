Class {
	#name : #ERMyRegistrationSummary,
	#superclass : #ERTabContainerPage,
	#category : #'ESUGApp-Components'
}

{ #category : #rendering }
ERMyRegistrationSummary >> getInvoice [
]

{ #category : #rendering }
ERMyRegistrationSummary >> modifyRegistration [
]

{ #category : #rendering }
ERMyRegistrationSummary >> renderButtons: html [
	html render: (self createButtonField: 'Modify Registration Information' with: [ self modifyRegistration ] id: 'modifyRegistration' ) forContentButton.
	html render: (self createButtonField: 'Pay' with: [ self pay ] id: 'pay' ) forContentButton.
	html render: (self createButtonField: 'Get my invoice' with: [ self getInvoice ] id: 'invoice' ) forContentButtonColored 
]

{ #category : #rendering }
ERMyRegistrationSummary >> renderContainer: html [ 	
	html horizontalRule .
	self renderLabelsSummary: html.
	self renderButtons: html.
]

{ #category : #rendering }
ERMyRegistrationSummary >> renderLabelsSummary: html [
	self createTextStrong: 'Attendace Date(s): ' withText: 'Monday 10, Tuesday 11, Wednesday 12, Thursday 13 and Friday 14' on: html.
	self createTextStrong: 'Payment Status: ' withText: 'Payment no registered yet. Amount due: 660.00 Euros (NOTE: you could have paid but we could have not registered it yet)' on: html
]

{ #category : #accessing }
ERMyRegistrationSummary >> tabId [
	^ 'summary'
]

{ #category : #accessing }
ERMyRegistrationSummary >> tabName [
	^ 'Summary'
]

{ #category : #accessing }
ERMyRegistrationSummary >> title [
	^ 'Registration Summary'
]
