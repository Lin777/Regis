Class {
	#name : #ERAdminController,
	#superclass : #ERLoggedController,
	#category : #'ESUGApp-Controller'
}

{ #category : #accessing }
ERAdminController class >> attendee: anAtteendee [
	| controller |
	controller := self new.
	controller attendee: anAtteendee.
	^ controller
]

{ #category : #'as yet unclassified' }
ERAdminController >> changePasswordTo: aString [
	attendee password: (ERUserAccount hashPassword: aString) asString.
	attendee save.
	self notifyAllObservers .
	^ attendee
]

{ #category : #'as yet unclassified' }
ERAdminController >> validateCurrentPassword: confirmPassword [
	^ attendee password
		= (ERUserAccount hashPassword: confirmPassword) asString
]

{ #category : #'as yet unclassified' }
ERAdminController >> validateNewPassword: aString1 with: aString2 [
	^ aString1 = aString2
]

{ #category : #'as yet unclassified' }
ERAdminController >> validatePatternPassword: aString [
	^ (aString matchesRegex: '[A-Za-z0-9._]{8,}') 
	and: [aString size >= 8].
]
