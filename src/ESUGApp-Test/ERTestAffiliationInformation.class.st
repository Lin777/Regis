Class {
	#name : #ERTestAffiliationInformation,
	#superclass : #ERTestModel,
	#category : #'ESUGApp-Test'
}

{ #category : #tests }
ERTestAffiliationInformation >> testEmptyOrganizationAddrees1Field [
	| errors org |
	org := (self class testAffiliationInformation) organizationAddrees1: nil; yourself .
	errors := org asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: messageInputRequired equals: (errors at:1) messageText
]

{ #category : #tests }
ERTestAffiliationInformation >> testEmptyOrganizationCityField [
	| errors org |
	org := (self class testAffiliationInformation) organizationCity: nil; yourself .
	errors := org asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: messageInputRequired equals: (errors at:1) messageText.
	
]

{ #category : #tests }
ERTestAffiliationInformation >> testEmptyOrganizationNameField [
	| errors org |
	org := (self class testAffiliationInformation) organizationName: nil; yourself .
	errors := org asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: messageInputRequired equals: (errors at:1) messageText.
	
]

{ #category : #tests }
ERTestAffiliationInformation >> testEmptyOrganizationPostalField [
	| errors org |
	org := (self class testAffiliationInformation) organizationPostal: nil; yourself .
	errors := org asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: messageInputRequired equals: (errors at:1) messageText
]

{ #category : #tests }
ERTestAffiliationInformation >> testNonValidOptionMembershipTypeField [
	| errors org |
	org := (self class testAffiliationInformation) membershipType: 'Non.Valid.Option'; yourself .
	errors := org asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: self messageInvalidInput equals: (errors at:1) messageText
]

{ #category : #tests }
ERTestAffiliationInformation >> testNonValidOptionOrganizationCountryField [
	| errors org |
	org := (self class testAffiliationInformation) organizationCountry: 'Non.Valid.Option'; yourself .
	errors := org asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: self messageInvalidInput equals: (errors at:1) messageText
]
