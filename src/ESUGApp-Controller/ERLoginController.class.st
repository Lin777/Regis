Class {
	#name : #ERLoginController,
	#superclass : #ERController,
	#category : #'ESUGApp-Controller'
}

{ #category : #accessing }
ERLoginController class >> user: anUser [
	| controller |
	controller := self new.
	controller user: anUser .
	^ controller
]

{ #category : #rendering }
ERLoginController >> validateLoginFor: aString1 password: aString2 [
	| anUser |
	anUser := ERUserAccount1 findUserByEmail: aString1.
	^ anUser
]
