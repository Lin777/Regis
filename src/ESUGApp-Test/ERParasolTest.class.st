Class {
	#name : #ERParasolTest,
	#superclass : #ERTest,
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
	super setUp.
	driver := BPRemoteWebDriver withCapabilities: BPDesiredCapabilities chrome.
	driver get: self baseURL 
]

{ #category : #accessing }
ERParasolTest >> tearDown [
	super tearDown .
	driver quit
]

{ #category : #accessing }
ERParasolTest >> testForgotPassword [
	|register|
	ERConfigurationController new closeRegistration .
	register := driver findElementByID: 'forgot-password'.
	register click.
	self assert: (driver findElementByID: 'card-heading') getText = 'Reset Password'.
]

{ #category : #accessing }
ERParasolTest >> testLoginRegisteredUser [
	|email password signIn|
	email := driver findElementByID: 'email-login'.
	password := driver findElementByID: 'password-login'.
	signIn := driver findElementByID: 'login-button'.
	email sendKeys: 'admin@esug.org'.
	password sendKeys: '12345678'.
	signIn click.
	self assert: (driver findElementByTagName: 'h3') getText = 'Welcome to this great conference'.
]

{ #category : #accessing }
ERParasolTest >> testLoginUnregisteredUser [
	|email password signIn|
	email := driver findElementByID: 'email-login'.
	password := driver findElementByID: 'password-login'.
	signIn := driver findElementByID: 'login-button'.
	email sendKeys: 'xxx@xxx.xx'.
	password sendKeys: 'xxxxxxxx'.
	signIn click.
	self assert: (driver findElementByID: 'loginAlert') getText = 'Login failed.'.
]

{ #category : #accessing }
ERParasolTest >> testRegisterAsGroupManagerButton [
	|register|
	register := driver findElementByID: 'register-button-as-group-manager'.
	register click.
	self assert: (driver findElementByID: 'card-heading') getText = 'Group Manager'
]

{ #category : #accessing }
ERParasolTest >> testRegisterAsGroupManagerWhenRegistrationIsClosed [
	|register|
	ERConfigurationController new closeRegistration .
	register := driver findElementByID: 'register-button-as-group-manager'.
	register click.
	self assert: (driver findElementByID: 'loginAlert') getText = 'The registration is not open'.
]

{ #category : #accessing }
ERParasolTest >> testRegisterButton [
	|register|
	register := driver findElementByID: 'register-button'.
	register click.
	self assert: (driver findElementByID: 'card-heading') getText = 'Registration'
]

{ #category : #accessing }
ERParasolTest >> testRegisterWhenRegistrationIsClosed [
	|register|
	ERConfigurationController new closeRegistration .
	register := driver findElementByID: 'register-button'.
	register click.
	self assert: (driver findElementByID: 'loginAlert') getText = 'The registration is not open'.
]
