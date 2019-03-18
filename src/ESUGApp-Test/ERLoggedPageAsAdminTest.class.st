Class {
	#name : #ERLoggedPageAsAdminTest,
	#superclass : #ERParasolTest,
	#instVars : [
		'acceptFormButton'
	],
	#category : #'ESUGApp-Test-Parasol'
}

{ #category : #tests }
ERLoggedPageAsAdminTest >> getNameOfConference [
	^ ERController new conference configuration name 
]

{ #category : #'as yet unclassified' }
ERLoggedPageAsAdminTest >> loginAsAdmin [
	|email password signIn|
	email := driver findElementByID: 'email-login'.
	password := driver findElementByID: 'password-login'.
	signIn := driver findElementByID: 'login-button'.
	email sendKeys: 'admin@esug.org'.
	password sendKeys: '12345678'.
	signIn click.
]

{ #category : #accessing }
ERLoggedPageAsAdminTest >> setUp [
	super setUp.
	self loginAsAdmin .
	ERTest generateDataForTest .
]

{ #category : #tests }
ERLoggedPageAsAdminTest >> testUpdateDateFromConference [
	|itemNav newValue|
	newValue := '10/10/2019'.
	itemNav := driver findElementByID: 'Configuration-option'.
	itemNav click.
	acceptFormButton := 'acceptConferenceConfiguration'.
	self update: 'dateFrom' with: newValue .
	self assert: ERController new conference configuration dateFrom equals: newValue 
]

{ #category : #tests }
ERLoggedPageAsAdminTest >> testUpdateDescriptionConference [
	|itemNav newValue|
	newValue := 'The European Smalltalk User Group (ESUG) is a non-profit users organization that supports all kinds of Smalltalk initiatives, especially free-open source ones that benefit the whole Smalltalk community'.
	itemNav := driver findElementByID: 'Configuration-option'.
	itemNav click.
	acceptFormButton := 'acceptConferenceConfiguration'.
	self update: 'description' with: newValue .
	self assert: ERController new conference configuration description equals: newValue 
]

{ #category : #tests }
ERLoggedPageAsAdminTest >> testUpdateHomePageUrlConference [
	|itemNav newValue|
	newValue := 'http://www.esug.org/wiki/'.
	itemNav := driver findElementByID: 'Configuration-option'.
	itemNav click.
	acceptFormButton := 'acceptConferenceConfiguration'.
	self update: 'homePageUrl' with: newValue .
	self assert: ERController new conference configuration homePageUrl equals: newValue 
]

{ #category : #tests }
ERLoggedPageAsAdminTest >> testUpdateNameConference [
	|itemNav newName|
	newName := 'ESUG 2019'.
	itemNav := driver findElementByID: 'Configuration-option'.
	itemNav click.
	acceptFormButton := 'acceptConferenceConfiguration'.
	self update: 'name' with: newName .
	self assert: self getNameOfConference equals: newName 
]

{ #category : #tests }
ERLoggedPageAsAdminTest >> update: anID with: aString [
	| confName acceptButton |
	confName := driver findElementByID: anID.
	confName clear.
	confName sendKeys: aString.
	acceptButton := driver findElementByID: acceptFormButton.
	acceptButton click.
]
