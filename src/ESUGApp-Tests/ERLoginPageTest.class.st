"
Description
--------------------

A ERLoginPageTest is a test class for testing the behavior of page when the user is in the principal page of the site
"
Class {
	#name : #ERLoginPageTest,
	#superclass : #ERParasolTest,
	#category : #'ESUGApp-Tests-Parasol'
}

{ #category : #accessing }
ERLoginPageTest >> testForgotPassword [
	ERConfigurationController new closeRegistration .
	self clickElementWithID: 'forgot-password'.
	self assert: (self textOfElementWithID: 'card-heading') equals: 'Reset Password'.
]

{ #category : #accessing }
ERLoginPageTest >> testLoginRegisteredUser [
	self selectElementWithID: 'email-login' send: 'admin@esug.org'.
	self selectElementWithID: 'password-login' send: '12345678'.
	self clickElementWithID: 'login-button'.
	self assert: (self textOfTagName: 'h3') equals: controller conference configurationOfHomePage title.
]

{ #category : #accessing }
ERLoginPageTest >> testLoginUnregisteredUser [
	self selectElementWithID: 'email-login' send: 'xxx@xxx.xx'.
	self selectElementWithID: 'password-login' send: 'xxxxxxxx'.
	self clickElementWithID: 'login-button'.
	self assert: (self textOfElementWithID: 'loginAlert') equals: 'Login failed.'.
]

{ #category : #accessing }
ERLoginPageTest >> testRegisterAsGroupManagerButton [
	self clickElementWithID: 'register-button-as-group-manager'.
	self assert: (self textOfElementWithID: 'card-heading') equals: 'Group Registration'
]

{ #category : #accessing }
ERLoginPageTest >> testRegisterAsGroupManagerWhenRegistrationIsClosed [
	ERConfigurationController new closeRegistration .
	self clickElementWithID: 'register-button-as-group-manager'.
	self assert: (self textOfElementWithID: 'loginAlert') equals: 'The registration is not open'.
]

{ #category : #accessing }
ERLoginPageTest >> testRegisterButton [
	self clickElementWithID: 'register-button'.
	self assert: (self textOfElementWithID: 'card-heading') equals: 'Registration'
]

{ #category : #accessing }
ERLoginPageTest >> testRegisterWhenRegistrationIsClosed [
	ERConfigurationController new closeRegistration .
	self clickElementWithID: 'register-button'.
	self assert: (self textOfElementWithID: 'loginAlert') equals: 'The registration is not open'.
]
