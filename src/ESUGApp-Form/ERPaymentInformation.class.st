Class {
	#name : #ERPaymentInformation,
	#superclass : #ERForm,
	#category : #'ESUGApp-Form'
}

{ #category : #rendering }
ERPaymentInformation >> renderContentOn: html [
	html
		html:
			'<br><p>Pay by transfer or pay/card. Pay in euros</p>
                    <p><strong>IMPORTANT: Bank transfer should mention "ESUG" & the registrant name(s) as comment (e.g "Esug John Johnson")</strong></p>
                    <p>Use the inter-country IBAN / BIC data (may need to ask your bank to process he payment)</p>'.
self
		createSelectField: 'Payment Type: '
		for: #paymentType:
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
		list: ERAttendee currencyTypes
		on: html.

]
