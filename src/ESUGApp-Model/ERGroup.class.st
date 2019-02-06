Class {
	#name : #ERGroup,
	#superclass : #SDActiveRecord,
	#instVars : [
		'groupManager',
		'listAttends',
		'paymentInformation'
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
ERGroup >> listAttends [
	^ listAttends
]

{ #category : #accessing }
ERGroup >> listAttends: anObject [
	listAttends := anObject
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
