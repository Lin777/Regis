"
A ERLoginPageTest is a test class for testing the behavior of page when the user is in the principal page of the site
"
Class {
	#name : #ERLoginPageTest,
	#superclass : #ERParasolTest,
	#category : #'ESUGApp-Test-Parasol'
}

{ #category : #accessing }
ERLoginPageTest >> testForgotPassword [
	ERConfigurationController new closeRegistration .
	self clickElementWithID: 'forgot-password'.
	self assert: (driver findElementByID: 'card-heading') getText = 'Reset Password'.
]

{ #category : #accessing }
ERLoginPageTest >> testLoginRegisteredUser [
	self selectElementWithID: 'email-login' send: 'admin@esug.org'.
	self selectElementWithID: 'password-login' send: '12345678'.
	self clickElementWithID: 'login-button'.
	self assert: (driver findElementByTagName: 'h3') getText = 'Welcome to this great conference'.
]

{ #category : #accessing }
ERLoginPageTest >> testLoginUnregisteredUser [
	self selectElementWithID: 'email-login' send: 'xxx@xxx.xx'.
	self selectElementWithID: 'password-login' send: 'xxxxxxxx'.
	self clickElementWithID: 'login-button'.
	self assert: (driver findElementByID: 'loginAlert') getText = 'Login failed.'.
]

{ #category : #accessing }
ERLoginPageTest >> testRegisterAsGroupManagerButton [
	self clickElementWithID: 'register-button-as-group-manager'.
	self assert: (driver findElementByID: 'card-heading') getText = 'Group Manager'
]

{ #category : #accessing }
ERLoginPageTest >> testRegisterAsGroupManagerWhenRegistrationIsClosed [
	ERConfigurationController new closeRegistration .
	self clickElementWithID: 'register-button-as-group-manager'.
	self assert: (driver findElementByID: 'loginAlert') getText = 'The registration is not open'.
]

{ #category : #accessing }
ERLoginPageTest >> testRegisterButton [
	self clickElementWithID: 'register-button'.
	self assert: (driver findElementByID: 'card-heading') getText = 'Registration'
]

{ #category : #accessing }
ERLoginPageTest >> testRegisterWhenRegistrationIsClosed [
	ERConfigurationController new closeRegistration .
	self clickElementWithID: 'register-button'.
	self assert: (driver findElementByID: 'loginAlert') getText = 'The registration is not open'.
]
