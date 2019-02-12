Class {
	#name : #ERTestAffiliationInformation,
	#superclass : #ERTestModel,
	#category : #'ESUGApp-Test'
}

{ #category : #tests }
ERTestAffiliationInformation >> testValidateAffiliationWithEmptyOrganizationAddrees1 [
	| conferenceConf org |
	org := (self class testAffiliationInformation) organizationAddrees1: nil; yourself .
	conferenceConf := org asComponent validate; errors.
	self assert: 1 equals: conferenceConf size.
	self assert: messageInputRequired equals: (conferenceConf at:1) messageText
]

{ #category : #tests }
ERTestAffiliationInformation >> testValidateAffiliationWithEmptyOrganizationCity [
	| errors org |
	org := (self class testAffiliationInformation) organizationCity: nil; yourself .
	errors := org asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: messageInputRequired equals: (errors at:1) messageText.
	
]

{ #category : #tests }
ERTestAffiliationInformation >> testValidateAffiliationWithEmptyOrganizationName [
	| errors org |
	org := (self class testAffiliationInformation) organizationName: nil; yourself .
	errors := org asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: messageInputRequired equals: (errors at:1) messageText.
	
]

{ #category : #tests }
ERTestAffiliationInformation >> testValidateAffiliationWithEmptyOrganizationPostal [
	| errors org |
	org := (self class testAffiliationInformation) organizationPostal: nil; yourself .
	errors := org asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: messageInputRequired equals: (errors at:1) messageText
]
