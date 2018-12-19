Class {
	#name : #ERLoggedAdminContainerController,
	#superclass : #ERLoggedController,
	#instVars : [
		'attendee'
	],
	#category : #'ESUGApp-Controllers'
}

{ #category : #accessing }
ERLoggedAdminContainerController class >> attendee: anAtteendee [
	| controller |
	controller := self new.
	controller attendee: anAtteendee.
	^ controller
]

{ #category : #accessing }
ERLoggedAdminContainerController >> attendee [
	^ attendee
]

{ #category : #accessing }
ERLoggedAdminContainerController >> attendee: anObject [
	attendee := anObject
]

{ #category : #'as yet unclassified' }
ERLoggedAdminContainerController >> changePasswordFrom: confirmPassword to: passwordChanged [
	(self validateCurrentPassword: confirmPassword)
		ifTrue: [ attendee
				password: (ERUserAccount hashPassword: passwordChanged) asString.
			^ attendee save ].
		^ nil
]

{ #category : #'as yet unclassified' }
ERLoggedAdminContainerController >> updateAttendee: modifiedUser [
	^ (attendee
		email: modifiedUser email;
		firstName: modifiedUser firstName;
		lastName: modifiedUser lastName;
		userAccount) save
]

{ #category : #'as yet unclassified' }
ERLoggedAdminContainerController >> updateUserFields: anUser [
	(self verifyIfEmailIsAlreadyRegistered: anUser)
		ifTrue: [ ^ self updateAttendee: anUser ].
		^ nil
]

{ #category : #'as yet unclassified' }
ERLoggedAdminContainerController >> validateCurrentPassword: confirmPassword [
	^ attendee password
		= (ERUserAccount hashPassword: confirmPassword) asString
]

{ #category : #'as yet unclassified' }
ERLoggedAdminContainerController >> verifyIfEmailIsAlreadyRegistered: modifiedUser [
	^ (ERUserAccount findUserByEmail: modifiedUser email) isNil
		or: attendee email = modifiedUser email

]
