Class {
	#name : #ERAttendee1,
	#superclass : #SDActiveRecord,
	#instVars : [
		'userAccount',
		'contactInformation',
		'conferenceInformation',
		'affiliationInformation',
		'additionalInformation',
		'paymentInformation'
	],
	#category : #'ESUGApp-Model-Magritte'
}

{ #category : #accessing }
ERAttendee1 >> additionalInformation [
	^ additionalInformation
]

{ #category : #accessing }
ERAttendee1 >> additionalInformation: anObject [
	additionalInformation := anObject
]

{ #category : #accessing }
ERAttendee1 >> affiliationInformation [
	^ affiliationInformation
]

{ #category : #accessing }
ERAttendee1 >> affiliationInformation: anObject [
	affiliationInformation := anObject
]

{ #category : #accessing }
ERAttendee1 >> conferenceInformation [
	^ conferenceInformation
]

{ #category : #accessing }
ERAttendee1 >> conferenceInformation: anObject [
	conferenceInformation := anObject
]

{ #category : #accessing }
ERAttendee1 >> contactInformation [
	^ contactInformation
]

{ #category : #accessing }
ERAttendee1 >> contactInformation: anObject [
	contactInformation := anObject
]

{ #category : #'initialize-release' }
ERAttendee1 >> initialize [ 
	super initialize .
	userAccount := ERUserAccount1 new.
	contactInformation := ERContactInformation new.
	conferenceInformation := ERRegisterConferenceInformation new.
	affiliationInformation := ERAffiliationInformation new.
	additionalInformation := ERAdditionalInformation new.
	paymentInformation := ERPaymentInformation new.
]

{ #category : #accessing }
ERAttendee1 >> paymentInformation [
	^ paymentInformation
]

{ #category : #accessing }
ERAttendee1 >> paymentInformation: anObject [
	paymentInformation := anObject
]

{ #category : #accessing }
ERAttendee1 >> userAccount [
	^ userAccount
]

{ #category : #accessing }
ERAttendee1 >> userAccount: anObject [
	userAccount := anObject
]
