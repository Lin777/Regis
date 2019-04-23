"
Description
--------------------

A ERTestBillingInformation is a test class for testing the behavior of ERBillingInformation model
"
Class {
	#name : #ERTestBillingInformation,
	#superclass : #ERTestModel,
	#category : #'ESUGApp-Test-UnitTest'
}

{ #category : #tests }
ERTestBillingInformation >> testEmptyOrganizationAddrees1Field [
	| org |
	org := (self class testAffiliationInformation) organizationAddrees1: nil; yourself .
	self assertEmptyField: org
]

{ #category : #tests }
ERTestBillingInformation >> testEmptyOrganizationCityField [
	| org |
	org := (self class testAffiliationInformation) organizationCity: nil; yourself .
	self assertEmptyField: org
]

{ #category : #tests }
ERTestBillingInformation >> testEmptyOrganizationNameField [
	| org |
	org := (self class testAffiliationInformation) organizationName: nil; yourself .
	self assertEmptyField: org
]

{ #category : #tests }
ERTestBillingInformation >> testEmptyOrganizationPostalField [
	| org |
	org := (self class testAffiliationInformation) organizationPostal: nil; yourself .
	self assertEmptyField: org
]

{ #category : #tests }
ERTestBillingInformation >> testNonValidOptionMembershipTypeField [
	| org |
	org := (self class testAffiliationInformation) membershipType: 'Non.Valid.Option'; yourself .
	self assertNonValidField: org
	
]

{ #category : #tests }
ERTestBillingInformation >> testNonValidOptionOrganizationCountryField [
	| org |
	org := (self class testAffiliationInformation) organizationCountry: 'Non.Valid.Option'; yourself .
	self assertNonValidField: org
]
