"
Description
--------------------

A ERTestBillingInformation is a test class for testing the behavior of ERBillingInformation model
"
Class {
	#name : #ERBillingInformationTest,
	#superclass : #ERModelTest,
	#category : #'ESUGApp-Tests-UnitTest'
}

{ #category : #tests }
ERBillingInformationTest >> testEmptyOrganizationAddrees1Field [

	| org |
	org := (self class testAffiliationInformation) organizationAddrees1: nil; yourself .
	self assertEmptyField: org
]

{ #category : #tests }
ERBillingInformationTest >> testEmptyOrganizationCityField [

	| org |
	org := (self class testAffiliationInformation) organizationCity: nil; yourself .
	self assertEmptyField: org
]

{ #category : #tests }
ERBillingInformationTest >> testEmptyOrganizationNameField [

	| org |
	org := (self class testAffiliationInformation) organizationName: nil; yourself .
	self assertEmptyField: org
]

{ #category : #tests }
ERBillingInformationTest >> testEmptyOrganizationPostalField [

	| org |
	org := (self class testAffiliationInformation) organizationPostal: nil; yourself .
	self assertEmptyField: org
]

{ #category : #tests }
ERBillingInformationTest >> testNonValidOptionMembershipTypeField [

	| org |
	org := (self class testAffiliationInformation) membershipType: 'Non.Valid.Option'; yourself .
	self assertNonValidField: org
	
]

{ #category : #tests }
ERBillingInformationTest >> testNonValidOptionOrganizationCountryField [

	| org |
	org := (self class testAffiliationInformation) organizationCountry: 'Non.Valid.Option'; yourself .
	self assertNonValidField: org
]
