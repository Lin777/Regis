Class {
	#name : #ERLoginController,
	#superclass : #Object,
	#instVars : [
		'user'
	],
	#category : #'ESUGApp-Controllers'
}

{ #category : #initialization }
ERLoginController >> initialize [
	super initialize.
	user := ERAttendee new.
]

{ #category : #accessing }
ERLoginController >> user [
	^ user
]

{ #category : #accessing }
ERLoginController >> user: anObject [
	user := anObject
]

{ #category : #rendering }
ERLoginController >> validateLogin [
	| aUser |
	aUser := self validateUserLogin: self user.
	^ aUser
]

{ #category : #rendering }
ERLoginController >> validateUserLogin: anObject [
	| anUser |
	anUser := ERUserAccount findUserByEmail: anObject email.
	(anUser notNil and: [ anUser  password = anObject password ])
		ifTrue: [ ^ anUser ]
		ifFalse: [ ^ nil ]
]
