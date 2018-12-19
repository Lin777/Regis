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
	html
		html:
			'<br><p>Pay by transfer or pay/card. Pay in euros</p>
                    <p><strong>IMPORTANT: Bank transfer should mention "ESUG" & the registrant name(s) as comment (e.g "Esug John Johnson")</strong></p>
                    <p>Use the inter-country IBAN / BIC data (may need to ask your bank to process he payment)</p>'.
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
