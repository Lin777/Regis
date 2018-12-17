Class {
	#name : #ERTabMyRegistrationSummary,
	#superclass : #ERTabContainerPage,
	#category : #'ESUGApp-Components'
}

{ #category : #rendering }
ERTabMyRegistrationSummary >> getInvoice [
]

{ #category : #rendering }
ERTabMyRegistrationSummary >> modifyRegistration [
]

{ #category : #rendering }
ERTabMyRegistrationSummary >> renderButtons: html [
	html render: (self createButtonField: 'Modify Registration Information' with: [ self modifyRegistration ] id: 'modifyRegistration' ) forContentButton.
	html render: (self createButtonField: 'Pay' with: [ self pay ] id: 'pay' ) forContentButton.
	html render: (self createButtonField: 'Get my invoice' with: [ self getInvoice ] id: 'invoice' ) forContentButtonColored 
]

{ #category : #rendering }
ERTabMyRegistrationSummary >> renderContainer: html [ 	
	html horizontalRule .
	self renderLabelsSummary: html.
	self renderButtons: html.
]

{ #category : #rendering }
ERTabMyRegistrationSummary >> renderLabelsSummary: html [
	html render: (self createTextStrong: 'Attendace Date(s): ' text: 'Monday 10, Tuesday 11, Wednesday 12, Thursday 13 and Friday 14').
	html render: (self createTextStrong: 'Payment Status: ' text: 'Payment no registered yet. Amount due: 660.00 Euros (NOTE: you could have paid but we could have not registered it yet)').
	
]

{ #category : #accessing }
ERTabMyRegistrationSummary >> tabId [
	^ 'summary'
]

{ #category : #accessing }
ERTabMyRegistrationSummary >> tabName [
	^ 'Summary'
]

{ #category : #accessing }
ERTabMyRegistrationSummary >> title [
	^ 'Registration Summary'
]
