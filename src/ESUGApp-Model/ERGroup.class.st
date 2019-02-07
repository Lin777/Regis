Class {
	#name : #ERGroup,
	#superclass : #SDActiveRecord,
	#instVars : [
		'groupManager',
		'listAttends',
		'paymentInformation',
		'encodedInvoice'
	],
	#category : #'ESUGApp-Model-Magritte'
}

{ #category : #accessing }
ERGroup class >> groupManager: aGroupManager [
	^ self new groupManager: aGroupManager ; yourself
]

{ #category : #'initialize-release' }
ERGroup >> addAttendee: anAttendee [
	listAttends add: anAttendee
]

{ #category : #accessing }
ERGroup >> encodedInvoice [
	^ encodedInvoice
]

{ #category : #accessing }
ERGroup >> encodedInvoice: anObject [
	encodedInvoice := anObject
]

{ #category : #accessing }
ERGroup >> firstName [ 
	^ groupManager userAccount firstName
]

{ #category : #accessing }
ERGroup >> groupManager [
	^ groupManager
]

{ #category : #accessing }
ERGroup >> groupManager: anObject [
	groupManager := anObject
]

{ #category : #'initialize-release' }
ERGroup >> initialize [
	super initialize .
	listAttends := OrderedCollection new.
	paymentInformation := ERPaymentInformation new.
]

{ #category : #accessing }
ERGroup >> invoiceNumber [
	^ paymentInformation invoiceNumber 
]

{ #category : #accessing }
ERGroup >> lastName [ 
	^ groupManager userAccount lastName
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
ERGroup >> organizationAddress1 [
	^ groupManager affiliationInformation organizationAddrees1
]

{ #category : #accessing }
ERGroup >> organizationCity [ 	
	^ groupManager affiliationInformation organizationCity 
]

{ #category : #accessing }
ERGroup >> organizationName [
	^ groupManager affiliationInformation organizationName
]

{ #category : #accessing }
ERGroup >> organizationPostal [
	^ groupManager affiliationInformation organizationPostal 
]

{ #category : #accessing }
ERGroup >> paymentAmount [
	^ paymentInformation paymentAmount
]

{ #category : #accessing }
ERGroup >> paymentAmount: anObject [
	^ paymentInformation paymentAmount: anObject
]

{ #category : #accessing }
ERGroup >> paymentInformation [
	^ paymentInformation
]

{ #category : #accessing }
ERGroup >> paymentInformation: anObject [
	paymentInformation := anObject
]
