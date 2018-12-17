Class {
	#name : #ERPaymentInformationTabForm,
	#superclass : #ERAttendeeRegistrationTabForm,
	#category : #'ESUGApp-Components'
}

{ #category : #rendering }
ERPaymentInformationTabForm >> renderFormOn: html [
	html html: '<br><p>Pay by transfer or pay/card. Pay in euros</p>
                    <p><strong>IMPORTANT: Bank transfer should mention "ESUG" & the registrant name(s) as comment (e.g "Esug John Johnson")</strong></p>
                    <p>Use the inter-country IBAN / BIC data (may need to ask your bank to process he payment)</p>'.
	html render: (self createSelectField: 'Payment Type: ' for: #paymentType: list: ERAttendee paymentTypes ).
	html render: (self createTextField: 'Reduction Ticket Code: ' for: #coupon:).
	html render: (self createSelectField: 'Payment Currency' for: #paymentCurrency: list: ERAttendee currencyTypes).
	
]

{ #category : #accessing }
ERPaymentInformationTabForm >> tabId [
	^ 'paymentInfoForm'
]

{ #category : #accessing }
ERPaymentInformationTabForm >> tabName [
	^ 'Payment Information'
]
