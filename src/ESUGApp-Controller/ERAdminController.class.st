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
	attendee password = (ERUserAccount hashPassword: confirmPassword) asString 
		ifFalse: [ ERException passwordDoesNotMatch signal  ]
]

{ #category : #'as yet unclassified' }
ERAdminController >> validatePatternPassword: aString [
	((aString matchesRegex: '[A-Za-z0-9._]{8,}') and: [aString size >= 8])
	ifFalse: [ ERException incorrectPatternOfPassword signal ]
]
