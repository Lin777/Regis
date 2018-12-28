Class {
	#name : #ERFee,
	#superclass : #SDActiveRecord,
	#instVars : [
		'currency',
		'erfAllDaysFee',
		'erfOneDayFee',
		'lrfAllDaysFee',
		'lrfOneDayFee',
		'bankAccountOwner',
		'bankAccountNumber',
		'bankAccountIBAN',
		'bankAccountRibKey',
		'bankName',
		'bankCode',
		'bankCounterCode',
		'bankBIC',
		'bankAddressString',
		'bankPayPalUrl'
	],
	#category : #'ESUGApp-Models'
}

{ #category : #accessing }
ERFee >> bankAccountIBAN [
	^ bankAccountIBAN
]

{ #category : #accessing }
ERFee >> bankAccountIBAN: anObject [
	bankAccountIBAN := anObject
]

{ #category : #accessing }
ERFee >> bankAccountNumber [
	^ bankAccountNumber
]

{ #category : #accessing }
ERFee >> bankAccountNumber: anObject [
	bankAccountNumber := anObject
]

{ #category : #accessing }
ERFee >> bankAccountOwner [
	^ bankAccountOwner
]

{ #category : #accessing }
ERFee >> bankAccountOwner: anObject [
	bankAccountOwner := anObject
]

{ #category : #accessing }
ERFee >> bankAccountRibKey [
	^ bankAccountRibKey
]

{ #category : #accessing }
ERFee >> bankAccountRibKey: anObject [
	bankAccountRibKey := anObject
]

{ #category : #accessing }
ERFee >> bankAddressString [
	^ bankAddressString
]

{ #category : #accessing }
ERFee >> bankAddressString: anObject [
	bankAddressString := anObject
]

{ #category : #accessing }
ERFee >> bankBIC [
	^ bankBIC
]

{ #category : #accessing }
ERFee >> bankBIC: anObject [
	bankBIC := anObject
]

{ #category : #accessing }
ERFee >> bankCode [
	^ bankCode
]

{ #category : #accessing }
ERFee >> bankCode: anObject [
	bankCode := anObject
]

{ #category : #accessing }
ERFee >> bankCounterCode [
	^ bankCounterCode
]

{ #category : #accessing }
ERFee >> bankCounterCode: anObject [
	bankCounterCode := anObject
]

{ #category : #accessing }
ERFee >> bankName [
	^ bankName
]

{ #category : #accessing }
ERFee >> bankName: anObject [
	bankName := anObject
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
