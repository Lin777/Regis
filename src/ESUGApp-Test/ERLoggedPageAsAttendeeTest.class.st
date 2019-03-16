Class {
	#name : #ERLoggedPageAsAttendeeTest,
	#superclass : #ERParasolTest,
	#category : #'ESUGApp-Test-Parasol'
}

{ #category : #'as yet unclassified' }
ERLoggedPageAsAttendeeTest >> loginAsAttendee [
	|email password signIn|
	email := driver findElementByID: 'email-login'.
	password := driver findElementByID: 'password-login'.
	signIn := driver findElementByID: 'login-button'.
	email sendKeys: 'ana@gmail.com'.
	password sendKeys: '12345678'.
	signIn click.
]
