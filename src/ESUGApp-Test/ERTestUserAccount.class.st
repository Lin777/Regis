Class {
	#name : #ERTestUserAccount,
	#superclass : #ERTestModel,
	#category : #'ESUGApp-Test'
}

{ #category : #tests }
ERTestUserAccount >> testEmailFieldWithoutFormat [
	| errors userAccount |
	userAccount := (self class testUserAccount) email: 'thisIsANotValidEmail'; yourself .
	errors := userAccount asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: 'Please enter a valid email' equals: (errors at:1) messageText.
	
]

{ #category : #tests }
ERTestUserAccount >> testEmptyConfirmPasswordField [
	| errors userAccount |
	userAccount := ((self class testUserAccount) as: ERUserAccountForRegister) confirmPassword: nil; yourself .
	errors := userAccount asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: messageInputRequired equals: (errors at:1) messageText.
	
]

{ #category : #tests }
ERTestUserAccount >> testEmptyEmailField [
	| errors userAccount |
	userAccount := (self class testUserAccount) email: nil; yourself .
	errors := userAccount asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: messageInputRequired equals: (errors at:1) messageText.
	
]

{ #category : #tests }
ERTestUserAccount >> testEmptyFirstNameField [
	| errors userAccount |
	userAccount := (self class testUserAccount) firstName: nil; yourself .
	errors := userAccount asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: messageInputRequired equals: (errors at:1) messageText.
	
]

{ #category : #tests }
ERTestUserAccount >> testEmptyLastNameField [
	| errors userAccount |
	userAccount := (self class testUserAccount) lastName: nil; yourself .
	errors := userAccount asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: messageInputRequired equals: (errors at:1) messageText.
	
]

{ #category : #tests }
ERTestUserAccount >> testEmptyPasswordField [
	| errors userAccount |
	userAccount := ((self class testUserAccount) as: ERUserAccountForRegister) password: nil; yourself .
	errors := userAccount asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: messageInputRequired equals: (errors at:1) messageText.
	
]

{ #category : #tests }
ERTestUserAccount >> testNumericValueFirstNameField [
	| errors userAccount |
	userAccount := (self class testUserAccount) firstName: 'Test1'; yourself .
	errors := userAccount asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: self messageTextField equals: (errors at:1) messageText.
	
]

{ #category : #tests }
ERTestUserAccount >> testNumericalValueLastNameField [
	| errors userAccount |
	userAccount := (self class testUserAccount) lastName: 'Test1 test'; yourself .
	errors := userAccount asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: self messageTextField equals: (errors at:1) messageText.
	
]

{ #category : #tests }
ERTestUserAccount >> testValidateUserAccount [
	| errors |
	errors := self class testUserAccount asComponent validate; errors.
	self assert: 0 equals: errors size.
	
]
