Class {
	#name : #ERAdminViewController,
	#superclass : #ERLoggedController,
	#category : #'ESUGApp-Controllers'
}

{ #category : #accessing }
ERAdminViewController class >> attendee: anAtteendee [
	| controller |
	controller := self new.
	controller attendee: anAtteendee.
	^ controller
]

{ #category : #'as yet unclassified' }
ERAdminViewController >> changePasswordTo: aString [
	attendee password: (ERUserAccount hashPassword: aString) asString.
	^ attendee save.
]

{ #category : #'as yet unclassified' }
ERAdminViewController >> updateAttendee: modifiedUser [
	^ (attendee
		email: modifiedUser email;
		firstName: modifiedUser firstName;
		lastName: modifiedUser lastName;
		userAccount) save
]

{ #category : #'as yet unclassified' }
ERAdminViewController >> updateUserFields: anUser [
	(self verifyIfEmailIsAlreadyRegistered: anUser)
		ifTrue: [ ^ self updateAttendee: anUser ].
		^ nil
]

{ #category : #'as yet unclassified' }
ERAdminViewController >> validateCurrentPassword: confirmPassword [
	^ attendee password
		= (ERUserAccount hashPassword: confirmPassword) asString
]

{ #category : #'as yet unclassified' }
ERAdminViewController >> validateNewPassword: aString1 with: aString2 [
	^ aString1 = aString2
]

{ #category : #'as yet unclassified' }
ERAdminViewController >> validatePatternPassword: aString [
	^ (aString matchesRegex: '[A-Za-z0-9._]{8,}') 
	and: [aString size >= 8].
]

{ #category : #'as yet unclassified' }
ERAdminViewController >> verifyIfEmailIsAlreadyRegistered: modifiedUser [
	^ (ERUserAccount findUserByEmail: modifiedUser email) isNil
		or: attendee email = modifiedUser email

]
