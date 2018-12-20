Class {
	#name : #ERPaymentInformationForm,
	#superclass : #ERAttendeeRegistrationForm,
	#category : #'ESUGApp-Components'
}

{ #category : #initialization }
ERPaymentInformationForm >> initialize [
	super initialize.
]

{ #category : #rendering }
ERPaymentInformationForm >> renderFormOn: html [
	html break.
	html paragraph: 'Pay by transfer or pay/card. Pay in euros'.
	html paragraph  with: [ 
		html strong: 'IMPORTANT: Bank transfer should mention "ESUG" & the registrant name(s) as comment (e.g "Esug John Johnson")'
	].
	html paragraph: 'Use the inter-country IBAN / BIC data (may need to ask your bank to process he payment)'.
	html
		render:
			(self
				createSelectField: 'Payment Type: '
				for: #paymentType:
				list: ERAttendee paymentTypes).
	html
		render:
			(self createTextField: 'Reduction Ticket Code: ' for: #coupon:).
	html
		render:
			(self
				createSelectField: 'Payment Currency'
				for: #paymentCurrency:
				list: ERAttendee currencyTypes).
	self renderPreviousTabFromOn: html.
	self renderNextTabFromOn: html
]

{ #category : #accessing }
ERPaymentInformationForm >> tabId [
	^ 'paymentInfoForm'
]

{ #category : #accessing }
ERPaymentInformationForm >> tabName [
	^ 'Payment'
]
