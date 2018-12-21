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
	html render: (ERPaymentInformation on: attendee)
]

{ #category : #accessing }
ERPaymentInformationForm >> tabId [
	^ 'paymentInfoForm'
]

{ #category : #accessing }
ERPaymentInformationForm >> tabName [
	^ 'Payment'
]
