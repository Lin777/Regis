Class {
	#name : #ERSession,
	#superclass : #WASession,
	#instVars : [
		'user',
		'account'
	],
	#category : #'ESUGApp-Core'
}

{ #category : #actions }
ERSession >> findUserByEmail: anEmail [

 ^ ERController new findUserByEmail: anEmail

]

{ #category : #actions }
ERSession >> initialize [
	super initialize.
]

{ #category : #actions }
ERSession >> isLoggedIn [

 ^ self user notNil
]

{ #category : #actions }
ERSession >> login: aUser [
	self user: aUser.
]

{ #category : #actions }
ERSession >> logout [
	self user: nil.
	self unregister
]

{ #category : #updating }
ERSession >> updateRoot: anHtmlRoot [
	super updateRoot: anHtmlRoot.
	anHtmlRoot title: ERLibrary applicationName
]

{ #category : #accessing }
ERSession >> user [
	^ user
]

{ #category : #accessing }
ERSession >> user: anObject [
	user := anObject
]
