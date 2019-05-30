"
I am a model of Group
"
Class {
	#name : #ERGroup,
	#superclass : #ERRegisteredObject,
	#instVars : [
		'groupManager',
		'listAttends'
	],
	#category : #'ESUGApp-Model-Magritte'
}

{ #category : #accessing }
ERGroup class >> groupManager: aGroupManager [
	^ self new groupManager: aGroupManager ; yourself
]

{ #category : #adding }
ERGroup >> addAttendee: anAttendee [
	listAttends add: anAttendee.
	self updatePaymentForAttendees
]

{ #category : #rendering }
ERGroup >> deleteAttendee: anAttendee [
	self listAttends removeAllSuchThat: [ :each | anAttendee id = each id ]
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

{ #category : #accessing }
ERGroup >> idGroup [
	^ self id
]

{ #category : #'initialize-release' }
ERGroup >> initialize [
	super initialize .
	listAttends := OrderedCollection new.
]

{ #category : #testing }
ERGroup >> isAbleToPay [
	^ paymentInformation hasPaid
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
ERGroup >> totalAmount [
	self listAttends ifNotEmpty: [ :list | ^ list sum: [ :each | each paymentAmount ]]
	ifEmpty: [ ^ 0 ]
]

{ #category : #updating }
ERGroup >> updateHasPaidOfAll [
	self listAttends do: [ :each | each paymentInformation hasPaid: 
												self paymentInformation hasPaid.
											  each save. ].
]

{ #category : #updating }
ERGroup >> updatePaymentForAttendees [
	self listAttends do: [ :att | 
		att paymentInformation paymentType: self paymentInformation paymentType .
		att paymentInformation paymentCurrency: self paymentInformation paymentCurrency. 
		att save ].
	self save.
]

{ #category : #updating }
ERGroup >> updatePaymentRateWith: aBlock [
	| amount |
	amount := self totalAmount.
	self paymentInformation paymentAmount: (amount  roundDownTo: 0.01).
]

{ #category : #accessing }
ERGroup >> userAccount [
	^ groupManager userAccount
]
