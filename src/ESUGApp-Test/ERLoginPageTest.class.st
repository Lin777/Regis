Class {
	#name : #ERLoginPageTest,
	#superclass : #ERParasolTest,
	#category : #'ESUGApp-Test-Parasol'
}

{ #category : #accessing }
ERLoginPageTest >> testForgotPassword [
	|register|
	ERConfigurationController new closeRegistration .
	register := driver findElementByID: 'forgot-password'.
	register click.
	self assert: (driver findElementByID: 'card-heading') getText = 'Reset Password'.
]

{ #category : #accessing }
ERLoginPageTest >> testLoginRegisteredUser [
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
ERLoginPageTest >> testLoginUnregisteredUser [
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
ERLoginPageTest >> testRegisterAsGroupManagerButton [
	|register|
	register := driver findElementByID: 'register-button-as-group-manager'.
	register click.
	self assert: (driver findElementByID: 'card-heading') getText = 'Group Manager'
]

{ #category : #accessing }
ERLoginPageTest >> testRegisterAsGroupManagerWhenRegistrationIsClosed [
	|register|
	ERConfigurationController new closeRegistration .
	register := driver findElementByID: 'register-button-as-group-manager'.
	register click.
	self assert: (driver findElementByID: 'loginAlert') getText = 'The registration is not open'.
]

{ #category : #accessing }
ERLoginPageTest >> testRegisterButton [
	|register|
	register := driver findElementByID: 'register-button'.
	register click.
	self assert: (driver findElementByID: 'card-heading') getText = 'Registration'
]

{ #category : #accessing }
ERLoginPageTest >> testRegisterWhenRegistrationIsClosed [
	|register|
	ERConfigurationController new closeRegistration .
	register := driver findElementByID: 'register-button'.
	register click.
	self assert: (driver findElementByID: 'loginAlert') getText = 'The registration is not open'.
]
