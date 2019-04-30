"
Description
--------------------

A ERTestUserAccount is a test class for testing the behavior of ERUserAccount model
"
Class {
	#name : #ERTestUserAccount,
	#superclass : #ERTestModel,
	#category : #'ESUGApp-Test-UnitTest'
}

{ #category : #asserting }
ERTestUserAccount >> assertNonTextField: anOnject [
	|errors|
	errors := anOnject asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: self messageTextField equals: (self messageTextOf: errors)
]

{ #category : #tests }
ERTestUserAccount >> testEmailFieldWithoutFormat [
	| errors userAccount |
	userAccount := (self class testUserAccount) email: 'thisIsANotValidEmail'; yourself .
	errors := userAccount asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: 'Please enter a valid email' equals: ((errors at:1) collection at:1) messageText.
	
]

{ #category : #tests }
ERTestUserAccount >> testEmptyConfirmPasswordField [
	| userAccount |
	userAccount := ((self class testUserAccount) as: ERUserAccountForRegister) confirmPassword: nil; yourself .
	self assertEmptyField: userAccount 
]

{ #category : #tests }
ERTestUserAccount >> testEmptyEmailField [
	| userAccount |
	userAccount := (self class testUserAccount) email: nil; yourself .
	self assertEmptyField: userAccount 
]

{ #category : #tests }
ERTestUserAccount >> testEmptyFirstNameField [
	| userAccount |
	userAccount := (self class testUserAccount) firstName: nil; yourself .
	self assertEmptyField: userAccount 
]

{ #category : #tests }
ERTestUserAccount >> testEmptyLastNameField [
	| userAccount |
	userAccount := (self class testUserAccount) lastName: nil; yourself .
	self assertEmptyField: userAccount 
]

{ #category : #tests }
ERTestUserAccount >> testEmptyPasswordField [
	| userAccount |
	userAccount := ((self class testUserAccount) as: ERUserAccountForRegister) password: nil; yourself .
	self assertEmptyField: userAccount 
]

{ #category : #tests }
ERTestUserAccount >> testIsAdmin [
	|user|
	user := ERUserAccount admin.
	self assert: user isAdmin.
	user := ERUserAccount groupManager .
	self deny: user isAdmin .
	user := self class testUserAccount.
	self deny: user isAdmin
]

{ #category : #tests }
ERTestUserAccount >> testIsAttendee [
	|user|
	user := ERUserAccount admin.
	self deny: user isAttendee.
	user := ERUserAccount groupManager .
	self deny: user isAttendee .
	user := self class testUserAccount.
	self assert: user isAttendee
]

{ #category : #tests }
ERTestUserAccount >> testIsGroupManager [
	|user|
	user := ERUserAccount admin.
	self deny: user isGroupManager.
	user := ERUserAccount groupManager .
	self assert: user isGroupManager .
	user := self class testUserAccount.
	self deny: user isGroupManager
]

{ #category : #tests }
ERTestUserAccount >> testValidateUserAccount [
	| errors |
	errors := self class testUserAccount asComponent validate; errors.
	self assert: 0 equals: errors size.
	
]
