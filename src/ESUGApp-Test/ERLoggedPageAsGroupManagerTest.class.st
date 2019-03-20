Class {
	#name : #ERLoggedPageAsGroupManagerTest,
	#superclass : #ERParasolTest,
	#category : #'ESUGApp-Test-Parasol'
}

{ #category : #'as yet unclassified' }
ERLoggedPageAsGroupManagerTest >> loginAsGroupManager [
	|email password signIn|
	email := driver findElementByID: 'email-login'.
	password := driver findElementByID: 'password-login'.
	signIn := driver findElementByID: 'login-button'.
	email sendKeys: 'lesly@gmail.com'.
	password sendKeys: '12345678'.
	signIn click.
]

{ #category : #accessing }
ERLoggedPageAsGroupManagerTest >> setUp [
	super setUp.
	self loginAsGroupManager .
]
