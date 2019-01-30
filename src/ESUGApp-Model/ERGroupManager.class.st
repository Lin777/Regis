Class {
	#name : #ERGroupManager,
	#superclass : #SDActiveRecord,
	#instVars : [
		'userAccount',
		'affiliationInformation'
	],
	#category : #'ESUGApp-Model-Magritte'
}

{ #category : #accessing }
ERGroupManager >> affiliationInformation [
	^ affiliationInformation
]

{ #category : #accessing }
ERGroupManager >> affiliationInformation: anObject [
	affiliationInformation := anObject
]

{ #category : #'initialize-release' }
ERGroupManager >> initialize [ 
	super initialize .
	userAccount := ERUserAccount1 asGroupManager.
	affiliationInformation := ERAffiliationInformation new.
]

{ #category : #accessing }
ERGroupManager >> userAccount [
	^ userAccount
]

{ #category : #accessing }
ERGroupManager >> userAccount: anObject [
	userAccount := anObject
]
