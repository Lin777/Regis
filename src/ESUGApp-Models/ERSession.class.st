Class {
	#name : #ERSession,
	#superclass : #WASession,
	#instVars : [
		'user',
		'account'
	],
	#category : #'ESUGApp-Models'
}

{ #category : #accessing }
ERSession >> account [
	^ account
]

{ #category : #accessing }
ERSession >> account: anObject [
	account := anObject
]

{ #category : #actions }
ERSession >> findUserByEmail: anEmail [

 ^ self database findUserByEmail: anEmail

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
	self account: nil
]

{ #category : #actions }
ERSession >> responseForRequest: aRequest [
	
	^ super responseForRequest: aRequest
]

{ #category : #'parent/child' }
ERSession >> unregistered [
	super unregistered
]

{ #category : #updating }
ERSession >> updateRoot: anHtmlRoot [

 super updateRoot: anHtmlRoot.
 anHtmlRoot title: ERLibrary applicationName.
 anHtmlRoot beHtml5.
]

{ #category : #accessing }
ERSession >> user [
	^ user
]

{ #category : #accessing }
ERSession >> user: anObject [
	user := anObject
]
