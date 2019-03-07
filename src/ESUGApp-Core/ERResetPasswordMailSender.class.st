Class {
	#name : #ERResetPasswordMailSender,
	#superclass : #ERMailSender,
	#instVars : [
		'user',
		'newPassword',
		'conference'
	],
	#category : #'ESUGApp-Core'
}

{ #category : #'instance creation' }
ERResetPasswordMailSender class >> on: anUser [
	^ self new user: anUser  
]

{ #category : #accessing }
ERResetPasswordMailSender >> conference [
	^ conference ifNil: [ conference := ERController uniqueInstance conference ]
]

{ #category : #rendering }
ERResetPasswordMailSender >> subjectDescription [
	^ 'New Password for ', conference name asString
]

{ #category : #rendering }
ERResetPasswordMailSender >> textBody [
	^  'Your password has been reseted.
		Your new temporary password is: ', newPassword, 
		'Please change it as soon as yoy can.
		
		Thank you!'		
]

{ #category : #rendering }
ERResetPasswordMailSender >> titleBody [
	^ '<h3> Reset password </h3>'
]

{ #category : #rendering }
ERResetPasswordMailSender >> toEmailString [
	^ user email
]

{ #category : #accessing }
ERResetPasswordMailSender >> user: anUser [
	user := anUser
]
