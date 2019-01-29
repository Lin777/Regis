Class {
	#name : #ERPaymentForm,
	#superclass : #ERForm,
	#category : #'ESUGApp-Form'
}

{ #category : #'as yet unclassified' }
ERPaymentForm >> formId [
	^ 'paymentInfoForm'
]

{ #category : #'as yet unclassified' }
ERPaymentForm >> formName [
	^ 'Payment'
]

{ #category : #initialization }
ERPaymentForm >> initializeForm [
	form := attendee paymentInformation asComponent
]

{ #category : #rendering }
ERPaymentForm >> renderContentOn: html [
	html
		html:
			'<br><p>Pay by transfer or pay/card. Pay in euros</p>
                    <p><strong>IMPORTANT: Bank transfer should mention "ESUG" & the registrant name(s) as comment (e.g "Esug John Johnson")</strong></p>
                    <p>Use the inter-country IBAN / BIC data (may need to ask your bank to process he payment)</p>'.
	"self
		createSelectField: 'Payment Type: '
		for: #paymentType:
		with: #paymentType
		list: ERAttendee paymentTypes
		on: html.
	self
		createTextField: 'Reduction Ticket Code: '
		for: #coupon:
		with: #coupon
		on: html.
	self
		createSelectField: 'Payment Currency'
		for: #paymentCurrency:
		with: #paymentCurrency
		list: ERController currencyAvailable
		on: html"html render: form.
]
