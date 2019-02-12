Class {
	#name : #ERTestUserAccount,
	#superclass : #ERTestModel,
	#category : #'ESUGApp-Test'
}

{ #category : #tests }
ERTestUserAccount >> testValidateUserAccount [
	| errors |
	errors := self class testUserAccount asComponent validate; errors.
	self assert: 0 equals: errors size.
	
]

{ #category : #tests }
ERTestUserAccount >> testValidateUserAccountWithEmailWithoutFormat [
	| errors userAccount |
	userAccount := (self class testUserAccount) email: 'thisIsANotValidEmail'; yourself .
	errors := userAccount asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: 'Please enter a valid email' equals: (errors at:1) messageText.
	
]

{ #category : #tests }
ERTestUserAccount >> testValidateUserAccountWithEmptyConfirmPassword [
	| errors userAccount |
	userAccount := ((self class testUserAccount) as: ERUserAccountForRegister) confirmPassword: nil; yourself .
	errors := userAccount asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: messageInputRequired equals: (errors at:1) messageText.
	
]

{ #category : #tests }
ERTestUserAccount >> testValidateUserAccountWithEmptyEmail [
	| errors userAccount |
	userAccount := (self class testUserAccount) email: nil; yourself .
	errors := userAccount asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: messageInputRequired equals: (errors at:1) messageText.
	
]

{ #category : #tests }
ERTestUserAccount >> testValidateUserAccountWithEmptyFirstName [
	| errors userAccount |
	userAccount := (self class testUserAccount) firstName: nil; yourself .
	errors := userAccount asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: messageInputRequired equals: (errors at:1) messageText.
	
]

{ #category : #tests }
ERTestUserAccount >> testValidateUserAccountWithEmptyLastName [
	| errors userAccount |
	userAccount := (self class testUserAccount) lastName: nil; yourself .
	errors := userAccount asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: messageInputRequired equals: (errors at:1) messageText.
	
]

{ #category : #tests }
ERTestUserAccount >> testValidateUserAccountWithEmptyPassword [
	| errors userAccount |
	userAccount := ((self class testUserAccount) as: ERUserAccountForRegister) password: nil; yourself .
	errors := userAccount asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: messageInputRequired equals: (errors at:1) messageText.
	
]

{ #category : #tests }
ERTestUserAccount >> testValidateUserAccountWithNumberInFirstName [
	| errors userAccount |
	userAccount := (self class testUserAccount) firstName: 'Test1'; yourself .
	errors := userAccount asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: 'This field only accept a text' equals: (errors at:1) messageText.
	
]

{ #category : #tests }
ERTestUserAccount >> testValidateUserAccountWithNumberInLastName [
	| errors userAccount |
	userAccount := (self class testUserAccount) lastName: 'Test1 test'; yourself .
	errors := userAccount asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: 'This field only accept a text' equals: (errors at:1) messageText.
	
]
