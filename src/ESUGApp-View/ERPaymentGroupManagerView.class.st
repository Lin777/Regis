Class {
	#name : #ERPaymentGroupManagerView,
	#superclass : #ERTittledView,
	#instVars : [
		'updatePayment',
		'cancel',
		'messageComponent',
		'amountString'
	],
	#category : #'ESUGApp-View'
}

{ #category : #accessing }
ERPaymentGroupManagerView >> amountString: aString [
	amountString := aString
]

{ #category : #accessing }
ERPaymentGroupManagerView >> cancel: aBlock [
	cancel := aBlock
]

{ #category : #accessing }
ERPaymentGroupManagerView >> content: anObject [
	content := anObject
]

{ #category : #rendering }
ERPaymentGroupManagerView >> renderAcceptButtonOn: html [	
	self
		createColoredButton: 'Accept'
		with: updatePayment "[ updatePayment
				on: ERException
				do: [ :exception | messageComponent errorMessage: exception messageText ] ]"
		id: 'accept-change-affiliation'
		on: html
]

{ #category : #rendering }
ERPaymentGroupManagerView >> renderCancelButtonOn: html [
	self
		createColoredAnchorButton: 'Cancel'
		with: cancel
		id: 'cancel-change-affiliation'
		on: html
]

{ #category : #rendering }
ERPaymentGroupManagerView >> renderPageOn: html [
	"html render: messageComponent ."
	html form
		method: 'post';
		id: 'formPaymentGroupManager';
		with: [ self renderSelectorOfPayment: html.
			self renderSelectorOfCurrency: html.
			self renderAcceptButtonOn: html.
			self renderCancelButtonOn: html ]
]

{ #category : #rendering }
ERPaymentGroupManagerView >> renderSelectorOfCurrency: html [
	self
		createSelectField: 'Currency type: '
		for: #paymentCurrency:
		with: #paymentCurrency
		list: ERController currencyAvailable
		to: attendee
		on: html			
]

{ #category : #rendering }
ERPaymentGroupManagerView >> renderSelectorOfPayment: html [
	self
		createSelectField: 'Payment type: '
		for: #paymentType:
		with: #paymentType
		list: ERAttendee paymentTypes  
		to: attendee
		on: html			
]

{ #category : #accessing }
ERPaymentGroupManagerView >> title [
	^ 'Amount to pay : ', amountString, '. Please choose payment Type'
]

{ #category : #accessing }
ERPaymentGroupManagerView >> updatePayment: aBlock [
	updatePayment := aBlock
]
