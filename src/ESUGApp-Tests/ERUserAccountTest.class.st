"
Description
--------------------

A ERTestUserAccount is a test class for testing the behavior of ERUserAccount model
"
Class {
	#name : #ERUserAccountTest,
	#superclass : #ERModelTest,
	#category : #'ESUGApp-Tests-UnitTest'
}

{ #category : #asserting }
ERUserAccountTest >> assertNonTextField: anOnject [

	| errors |
	errors := anOnject asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: self messageTextField equals: (self messageTextOf: errors)
]

{ #category : #tests }
ERUserAccountTest >> testEmailFieldWithoutFormat [

	| errors userAccount |
	userAccount := (self class testUserAccount) email: 'thisIsANotValidEmail'; yourself.
	errors := userAccount asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: 'Please enter a valid email' equals: ((errors at:1) collection at:1) messageText.
]

{ #category : #tests }
ERUserAccountTest >> testEmptyConfirmPasswordField [

	| userAccount |
	userAccount := ((self class testUserAccount) as: ERUserAccountForRegister) confirmPassword: nil; yourself.
	self assertEmptyField: userAccount 
]

{ #category : #tests }
ERUserAccountTest >> testEmptyEmailField [

	| userAccount |
	userAccount := (self class testUserAccount) email: nil; yourself.
	self assertEmptyField: userAccount 
]

{ #category : #tests }
ERUserAccountTest >> testEmptyFirstNameField [

	| userAccount |
	userAccount := (self class testUserAccount) firstName: nil; yourself.
	self assertEmptyField: userAccount 
]

{ #category : #tests }
ERUserAccountTest >> testEmptyLastNameField [

	| userAccount |
	userAccount := (self class testUserAccount) lastName: nil; yourself.
	self assertEmptyField: userAccount 
]

{ #category : #tests }
ERUserAccountTest >> testEmptyPasswordField [

	| userAccount |
	userAccount := ((self class testUserAccount) as: ERUserAccountForRegister) password: nil; yourself.
	self assertEmptyField: userAccount 
]

{ #category : #tests }
ERUserAccountTest >> testIsAdmin [

	| user |
	user := ERUserAccount admin.
	self assert: user isAdmin.
	user := ERUserAccount groupManager.
	self deny: user isAdmin .
	user := self class testUserAccount.
	self deny: user isAdmin
]

{ #category : #tests }
ERUserAccountTest >> testIsAttendee [

	| user |
	user := ERUserAccount admin.
	self deny: user isAttendee.
	user := ERUserAccount groupManager.
	self deny: user isAttendee .
	user := self class testUserAccount.
	self assert: user isAttendee
]

{ #category : #tests }
ERUserAccountTest >> testIsGroupManager [

	| user |
	user := ERUserAccount admin.
	self deny: user isGroupManager.
	user := ERUserAccount groupManager.
	self assert: user isGroupManager .
	user := self class testUserAccount.
	self deny: user isGroupManager
]

{ #category : #tests }
ERUserAccountTest >> testValidateUserAccount [

	| errors |
	errors := self class testUserAccount asComponent validate; errors.
	self assert: 0 equals: errors size.
]
