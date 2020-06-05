Class {
	#name : #ERPaymentGroupManagerView,
	#superclass : #ERTittledView,
	#instVars : [
		'updatePayment',
		'cancel',
		'messageComponent',
		'blockForUpdate'
	],
	#category : #'ESUGApp-View-View'
}

{ #category : #rendering }
ERPaymentGroupManagerView >> acceptAction [
	|saved|
	saved := attendee save.
	updatePayment cull: saved.
]

{ #category : #updating }
ERPaymentGroupManagerView >> blockForUpdate: aBlock [
	blockForUpdate := aBlock
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
	html mdlButton
		colored;
		id: 'accept-change-affiliation' ;
		callback: [self acceptAction];
		with: 'Accept'
]

{ #category : #rendering }
ERPaymentGroupManagerView >> renderCancelButtonOn: html [
	html mdlAnchorButton
		colored;
		id: 'cancel-change-affiliation';
		callback: [ ERGroupRegistrationView
				attendee: self session user
				content: content ];
		with: 'Cancel'
]

{ #category : #rendering }
ERPaymentGroupManagerView >> renderPageOn: html [
	html form
		method: 'post';
		id: 'formPaymentGroupManager';
		with: [ self renderSelectorOfPayment: html.
			self renderSelectorOfCurrency: html.
			self renderCancelButtonOn: html.
			self renderAcceptButtonOn: html ]
]

{ #category : #rendering }
ERPaymentGroupManagerView >> renderSelectorOfCurrency: html [
	html mdlTextFieldContainer
		floatingLabel;
		with: [ html mdlTextFieldLabel with: 'Currency type: '.
			html select
				class: 'mdl-textfield__input';
				list: ERPaymentInformation currencyTypes ;
				selected: attendee paymentInformation paymentCurrency;
				callback: [ :value | attendee paymentInformation paymentCurrency: value asString ] ].
]

{ #category : #rendering }
ERPaymentGroupManagerView >> renderSelectorOfPayment: html [
	html mdlTextFieldContainer
		floatingLabel;
		with: [ html mdlTextFieldLabel with: 'Payment type: '.
			html select
				onChange: 'submit()';
				class: 'mdl-textfield__input';
				list: ERPaymentInformation paymentTypes;
				selected: attendee paymentInformation paymentType;
				callback: [ :value | self updatePaymentInformation: value ] ].
]

{ #category : #accessing }
ERPaymentGroupManagerView >> title [
	^ 'Amount to pay : ', attendee paymentInformation paymentAmount asString, '. Please choose payment Type'
]

{ #category : #updating }
ERPaymentGroupManagerView >> updatePayment: aBlock [
	updatePayment := aBlock
]

{ #category : #updating }
ERPaymentGroupManagerView >> updatePaymentInformation: value [
	({value} includesAnyOf: ERPaymentInformation paymentTypes )
		ifTrue: [ attendee paymentInformation paymentType: value asString.
			attendee save.
			blockForUpdate cull: attendee ]
		ifFalse: [ ERException paymentTypeNoValid signal ]

	
]
