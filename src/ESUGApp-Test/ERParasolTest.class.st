Class {
	#name : #ERParasolTest,
	#superclass : #TestCase,
	#instVars : [
		'driver'
	],
	#category : #'ESUGApp-Test-Parasol'
}

{ #category : #accessing }
ERParasolTest >> baseURL [
	^ 'http://localhost:8000/ESUG/'
]

{ #category : #accessing }
ERParasolTest >> setUp [
	driver := BPRemoteWebDriver withCapabilities: BPDesiredCapabilities chrome.
	driver get: self baseURL 
]

{ #category : #accessing }
ERParasolTest >> tearDown [
	driver quit
]

{ #category : #accessing }
ERParasolTest >> testLoginRegisteredUser [
	"|email password signIn|
	email := driver findElementByID: 'email-login'.
	password := driver findElementByID: 'password-login'.
	signIn := driver findElementByName: 'login-button'.
	email sendKeys: 'admin@esug.org'.
	password sendKeys: '12345678'.
	signIn click."
	"self assert: (driver findElementByTagName: 'h3') getText = 'Welcome to this great conference'."
]
