Class {
	#name : #ERTestModel,
	#superclass : #ERTestControllers,
	#instVars : [
		'messageInputRequired'
	],
	#category : #'ESUGApp-Test'
}

{ #category : #tests }
ERTestModel class >> testUserExampleAccount [
	^ ERUserAccount new
		email: 'example@gmail.com';
		firstName: 'Example';
		lastName: 'Example';
		password: (ERUserAccount hashPassword: '12345678') asString;
		yourself
]

{ #category : #tests }
ERTestModel >> setUp [
	super setUp.
	messageInputRequired := 'Input is required but no input given'
]

{ #category : #tests }
ERTestModel >> testValidateAffiliationWithEmptyOrganizationAddrees1 [
	| errors org |
	org := (self class testAffiliationInformation) organizationAddrees1: nil; yourself .
	errors := org asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: messageInputRequired equals: (errors at:1) messageText
]

{ #category : #tests }
ERTestModel >> testValidateAffiliationWithEmptyOrganizationCity [
	| errors org |
	org := (self class testAffiliationInformation) organizationCity: nil; yourself .
	errors := org asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: messageInputRequired equals: (errors at:1) messageText.
	
]

{ #category : #tests }
ERTestModel >> testValidateAffiliationWithEmptyOrganizationName [
	| errors org |
	org := (self class testAffiliationInformation) organizationName: nil; yourself .
	errors := org asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: messageInputRequired equals: (errors at:1) messageText.
	
]

{ #category : #tests }
ERTestModel >> testValidateAffiliationWithEmptyOrganizationPostal [
	| errors org |
	org := (self class testAffiliationInformation) organizationPostal: nil; yourself .
	errors := org asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: messageInputRequired equals: (errors at:1) messageText
]

{ #category : #tests }
ERTestModel >> testValidateUserAccount [
	| errors |
	errors := self class testUserAccount asComponent validate; errors.
	self assert: 0 equals: errors size.
	
]

{ #category : #tests }
ERTestModel >> testValidateUserAccountWithEmailWithoutFormat [
	| errors userAccount |
	userAccount := (self class testUserAccount) email: 'thisIsANotValidEmail'; yourself .
	errors := userAccount asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: 'Please enter a valid email' equals: (errors at:1) messageText.
	
]

{ #category : #tests }
ERTestModel >> testValidateUserAccountWithEmptyConfirmPassword [
	| errors userAccount |
	userAccount := ((self class testUserAccount) as: ERUserAccountForRegister) confirmPassword: nil; yourself .
	errors := userAccount asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: messageInputRequired equals: (errors at:1) messageText.
	
]

{ #category : #tests }
ERTestModel >> testValidateUserAccountWithEmptyEmail [
	| errors userAccount |
	userAccount := (self class testUserAccount) email: nil; yourself .
	errors := userAccount asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: messageInputRequired equals: (errors at:1) messageText.
	
]

{ #category : #tests }
ERTestModel >> testValidateUserAccountWithEmptyFirstName [
	| errors userAccount |
	userAccount := (self class testUserAccount) firstName: nil; yourself .
	errors := userAccount asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: messageInputRequired equals: (errors at:1) messageText.
	
]

{ #category : #tests }
ERTestModel >> testValidateUserAccountWithEmptyLastName [
	| errors userAccount |
	userAccount := (self class testUserAccount) lastName: nil; yourself .
	errors := userAccount asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: messageInputRequired equals: (errors at:1) messageText.
	
]

{ #category : #tests }
ERTestModel >> testValidateUserAccountWithEmptyPassword [
	| errors userAccount |
	userAccount := ((self class testUserAccount) as: ERUserAccountForRegister) password: nil; yourself .
	errors := userAccount asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: messageInputRequired equals: (errors at:1) messageText.
	
]

{ #category : #tests }
ERTestModel >> testValidateUserAccountWithNumberInFirstName [
	| errors userAccount |
	userAccount := (self class testUserAccount) firstName: 'Test1'; yourself .
	errors := userAccount asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: 'This field only accept a text' equals: (errors at:1) messageText.
	
]

{ #category : #tests }
ERTestModel >> testValidateUserAccountWithNumberInLastName [
	| errors userAccount |
	userAccount := (self class testUserAccount) lastName: 'Test1 test'; yourself .
	errors := userAccount asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: 'This field only accept a text' equals: (errors at:1) messageText.
	
]
