Class {
	#name : #ERGroup,
	#superclass : #SDActiveRecord,
	#instVars : [
		'groupManager',
		'listAttends',
		'paymentType',
		'paymentCurrency',
		'invoiceNumber'
	],
	#category : #'ESUGApp-Model'
}

{ #category : #accessing }
ERGroup class >> groupManager: anObject [
	^ self new
		groupManager: anObject;
		yourself
]

{ #category : #adding }
ERGroup >> addAttendee: anAttendee [
	listAttends add: anAttendee
]

{ #category : #accessing }
ERGroup >> groupManager [
	^ groupManager
]

{ #category : #accessing }
ERGroup >> groupManager: anObject [
	groupManager := anObject
]

{ #category : #accessing }
ERGroup >> initialize [
	super initialize .
	listAttends := OrderedCollection new.
	
]

{ #category : #'as yet unclassified' }
ERGroup >> invoiceNumberIfNone: aBlock [
	invoiceNumber ifNil: [ invoiceNumber := aBlock value ].
	^ invoiceNumber 
]

{ #category : #accessing }
ERGroup >> listAttends [
	^ listAttends
]

{ #category : #accessing }
ERGroup >> listAttends: anObject [
	listAttends := anObject
]

{ #category : #accessing }
ERGroup >> paymentCurrency [
	^ paymentCurrency
]

{ #category : #accessing }
ERGroup >> paymentCurrency: anObject [
	paymentCurrency := anObject 
]

{ #category : #accessing }
ERGroup >> paymentType [
	^ paymentType
]

{ #category : #accessing }
ERGroup >> paymentType: anObject [
	paymentType := anObject
]

{ #category : #'as yet unclassified' }
ERGroup >> paymentTypeIsBankTransfer [
	^ 'Bank transfer' = paymentType
]

{ #category : #'as yet unclassified' }
ERGroup >> paymentTypeIsCreditCard [
	^  'Credit Card' = paymentType
]
