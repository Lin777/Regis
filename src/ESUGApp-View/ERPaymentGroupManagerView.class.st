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
	html mdlTextFieldContainer
		floatingLabel;
		with: [ html mdlTextFieldLabel with: 'Currency type: '.
			html select
				class: 'mdl-textfield__input';
				list: ERController currencyAvailable;
				selected: attendee paymentInformation paymentCurrency;
				callback: [ :value | attendee paymentInformation paymentCurrency: value asString ] ].
]

{ #category : #rendering }
ERPaymentGroupManagerView >> renderSelectorOfPayment: html [
	html mdlTextFieldContainer
		floatingLabel;
		with: [ html mdlTextFieldLabel with: 'Payment type: '.
			html select
				class: 'mdl-textfield__input';
				list: ERAttendee1 paymentTypes;
				selected: attendee paymentInformation paymentType;
				callback: [ :value | attendee paymentInformation paymentType: value asString ] ].
]

{ #category : #accessing }
ERPaymentGroupManagerView >> title [
	^ 'Amount to pay : ', amountString, '. Please choose payment Type'
]

{ #category : #accessing }
ERPaymentGroupManagerView >> updatePayment: aBlock [
	updatePayment := aBlock
]
