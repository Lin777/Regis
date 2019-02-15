Class {
	#name : #ERInvoice,
	#superclass : #SDActiveRecord,
	#instVars : [
		'numberInvoice',
		'encodedInvoice',
		'hasPaid'
	],
	#category : #'ESUGApp-Model'
}

{ #category : #'as yet unclassified' }
ERInvoice >> attendeeOrGroupManagerOwner [
	
]

{ #category : #accessing }
ERInvoice >> encodedInvoice [
	^ encodedInvoice
]

{ #category : #accessing }
ERInvoice >> encodedInvoice: anObject [
	encodedInvoice := anObject
]

{ #category : #accessing }
ERInvoice >> hasPaid [
	^ hasPaid
]

{ #category : #accessing }
ERInvoice >> hasPaid: anObject [
	hasPaid := anObject
]

{ #category : #accessing }
ERInvoice >> numberInvoice [
	^ numberInvoice
]

{ #category : #accessing }
ERInvoice >> numberInvoice: anObject [
	numberInvoice := anObject
]
