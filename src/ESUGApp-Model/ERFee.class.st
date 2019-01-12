Class {
	#name : #ERFee,
	#superclass : #SDActiveRecord,
	#instVars : [
		'currency',
		'erfAllDaysFee',
		'erfOneDayFee',
		'lrfAllDaysFee',
		'lrfOneDayFee',
		'bankAccountInformation',
		'bankPayPalUrl',
		'extraPersonSD'
	],
	#category : #'ESUGApp-Model'
}

{ #category : #accessing }
ERFee >> bankAccountInformation [
	^ bankAccountInformation
]

{ #category : #accessing }
ERFee >> bankAccountInformation: anObject [
	bankAccountInformation := anObject
]

{ #category : #accessing }
ERFee >> bankPayPalUrl [
	^ bankPayPalUrl
]

{ #category : #accessing }
ERFee >> bankPayPalUrl: anObject [
	bankPayPalUrl := anObject
]

{ #category : #accessing }
ERFee >> currency [
	^ currency
]

{ #category : #accessing }
ERFee >> currency: anObject [
	currency := anObject
]

{ #category : #accessing }
ERFee >> erfAllDaysFee [
	^ erfAllDaysFee
]

{ #category : #accessing }
ERFee >> erfAllDaysFee: anObject [
	erfAllDaysFee := anObject
]

{ #category : #accessing }
ERFee >> erfOneDayFee [
	^ erfOneDayFee
]

{ #category : #accessing }
ERFee >> erfOneDayFee: anObject [
	erfOneDayFee := anObject
]

{ #category : #accessing }
ERFee >> extraPersonSD [
	^ extraPersonSD
]

{ #category : #accessing }
ERFee >> extraPersonSD: anObject [
	extraPersonSD := anObject
]

{ #category : #initialization }
ERFee >> initialize [
	super initialize.
	bankAccountInformation := ERBankAccountInformation new.
	
]

{ #category : #accessing }
ERFee >> lrfAllDaysFee [
	^ lrfAllDaysFee
]

{ #category : #accessing }
ERFee >> lrfAllDaysFee: anObject [
	lrfAllDaysFee := anObject
]

{ #category : #accessing }
ERFee >> lrfOneDayFee [
	^ lrfOneDayFee
]

{ #category : #accessing }
ERFee >> lrfOneDayFee: anObject [
	lrfOneDayFee := anObject
]

{ #category : #'as yet unclassified' }
ERFee >> payPalAmountToken [
	^ '[AMOUNT]'
]

{ #category : #'as yet unclassified' }
ERFee >> payPalInvoiceNumberToken [
	
	^ '[INVOICENUMBER]'
]
