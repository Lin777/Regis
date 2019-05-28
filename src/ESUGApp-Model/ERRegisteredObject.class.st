"
Description
--------------------

I am an abstract class for registered objects in conference
"
Class {
	#name : #ERRegisteredObject,
	#superclass : #SDActiveRecord,
	#instVars : [
		'paymentInformation',
		'encodedInvoice'
	],
	#category : #'ESUGApp-Model-Magritte'
}

{ #category : #accessing }
ERRegisteredObject >> addPayPalComissionifApply: payPalComission [
	(paymentInformation paymentTypeIsCreditCard)
	ifTrue: [ paymentInformation paymentAmount: 
					(paymentInformation paymentAmount + payPalComission )]
]

{ #category : #accessing }
ERRegisteredObject >> encodedInvoice [
	^ encodedInvoice
]

{ #category : #accessing }
ERRegisteredObject >> encodedInvoice: anObject [
	encodedInvoice := anObject
]

{ #category : #accessing }
ERRegisteredObject >> firstName [ 
	self subclassResponsibility 
]

{ #category : #accessing }
ERRegisteredObject >> idGroup [
	self subclassResponsibility 
]

{ #category : #accessing }
ERRegisteredObject >> initialize [
	super initialize .
	paymentInformation := ERPaymentInformation new.
]

{ #category : #accessing }
ERRegisteredObject >> invoiceNumber [
	^ paymentInformation invoiceNumber 
]

{ #category : #accessing }
ERRegisteredObject >> lastName [ 
	self subclassResponsibility 
]

{ #category : #accessing }
ERRegisteredObject >> organizationAddress1 [
	self subclassResponsibility 
]

{ #category : #accessing }
ERRegisteredObject >> organizationCity [ 	
	self subclassResponsibility 
]

{ #category : #accessing }
ERRegisteredObject >> organizationName [ 	
	self subclassResponsibility 
]

{ #category : #accessing }
ERRegisteredObject >> organizationPostal [ 	
	self subclassResponsibility 
]

{ #category : #accessing }
ERRegisteredObject >> paymentAmount [
	^ paymentInformation paymentAmount
]

{ #category : #accessing }
ERRegisteredObject >> paymentAmount: anObject [
	^ paymentInformation paymentAmount: (anObject roundDownTo: 0.01)
]

{ #category : #accessing }
ERRegisteredObject >> paymentInformation [
	^ paymentInformation
]

{ #category : #accessing }
ERRegisteredObject >> paymentInformation: anObject [
	paymentInformation := anObject
]

{ #category : #updating }
ERRegisteredObject >> stateUpdatePaidWith: aBoolean actions: aCollection [
	self paymentInformation hasPaid: aBoolean.
	self userAccount isGroupManager ifTrue: [
		aCollection first cull: self.
	]
	ifFalse: [ aCollection second cull: self ]
]

{ #category : #accessing }
ERRegisteredObject >> userAccount [
	self subclassResponsibility 
]
