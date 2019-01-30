Class {
	#name : #ERGroup1,
	#superclass : #SDActiveRecord,
	#instVars : [
		'groupManager',
		'listAttends',
		'paymentInformation'
	],
	#category : #'ESUGApp-Model-Magritte'
}

{ #category : #accessing }
ERGroup1 class >> groupManager: aGroupManager [
	^ self new groupManager: aGroupManager ; yourself
]

{ #category : #'initialize-release' }
ERGroup1 >> addAttendee: anAttendee [
	listAttends add: anAttendee
]

{ #category : #accessing }
ERGroup1 >> groupManager [
	^ groupManager
]

{ #category : #accessing }
ERGroup1 >> groupManager: anObject [
	groupManager := anObject
]

{ #category : #'initialize-release' }
ERGroup1 >> initialize [
	super initialize .
	listAttends := OrderedCollection new.
	paymentInformation := ERPaymentInformation new.
]

{ #category : #accessing }
ERGroup1 >> listAttends [
	^ listAttends
]

{ #category : #accessing }
ERGroup1 >> listAttends: anObject [
	listAttends := anObject
]

{ #category : #accessing }
ERGroup1 >> paymentInformation [
	^ paymentInformation
]

{ #category : #accessing }
ERGroup1 >> paymentInformation: anObject [
	paymentInformation := anObject
]
