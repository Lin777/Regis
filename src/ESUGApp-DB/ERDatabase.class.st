Class {
	#name : #ERDatabase,
	#superclass : #Object,
	#category : #'ESUGApp-DB'
}

{ #category : #adding }
ERDatabase >> addAccount: aAccount [
	self subclassResponsibility 
]

{ #category : #adding }
ERDatabase >> addAffiliationInfo: anAfiliationInfo [
	self subclassResponsibility 
]

{ #category : #adding }
ERDatabase >> addAttendee: anAccount toConference: aConference [
	self subclassResponsibility 
]

{ #category : #actions }
ERDatabase >> addConference: aCoupon [
	
	self subclassResponsibility 
]

{ #category : #actions }
ERDatabase >> addCoupon: aCoupon [
	
	self subclassResponsibility 
]

{ #category : #adding }
ERDatabase >> addDaysAssist: aDays [

	self subclassResponsibility 
]

{ #category : #adding }
ERDatabase >> addInvoice: aInvoice [
	self subclassResponsibility 
]

{ #category : #adding }
ERDatabase >> addPrice: aPrice [
	self subclassResponsibility 
]

{ #category : #actions }
ERDatabase >> addUser: aUser [
	
	self subclassResponsibility 
]

{ #category : #actions }
ERDatabase >> connect [

 ^ true
]

{ #category : #actions }
ERDatabase >> connectionFailed [

 ^ false
]

{ #category : #actions }
ERDatabase >> disconnect [

 ^ true

]

{ #category : #actions }
ERDatabase >> editUser: aUser [
	
	self subclassResponsibility 
]

{ #category : #adding }
ERDatabase >> findAllUsersThatPaid [
	self subclassResponsibility 
]

{ #category : #actions }
ERDatabase >> findUserByEmail: aEmail [
	self subclassResponsibility 
]

{ #category : #actions }
ERDatabase >> getAllInvoicesByConference: aConference [
]

{ #category : #adding }
ERDatabase >> getAmountManAndWomen [
	self subclassResponsibility 
]

{ #category : #actions }
ERDatabase >> updateUser: aUser [
	
	self subclassResponsibility 
]
