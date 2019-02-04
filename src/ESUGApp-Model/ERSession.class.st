Class {
	#name : #ERSession,
	#superclass : #WAExpirySession,
	#instVars : [
		'user',
		'account'
	],
	#category : #'ESUGApp-Model'
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
	self unregistered
]

{ #category : #actions }
ERSession >> responseForRequest: aRequest [
	
	^ super responseForRequest: aRequest
]

{ #category : #actions }
ERSession >> unregistered [
	super unregistered.
	user := nil.
]

{ #category : #updating }
ERSession >> updateRoot: anHtmlRoot [
	super updateRoot: anHtmlRoot.
	anHtmlRoot title: ERLibrary applicationName.
	"anHtmlRoot beHtml5"
]

{ #category : #accessing }
ERSession >> user [
	^ user
]

{ #category : #accessing }
ERSession >> user: anObject [
	user := anObject
]
