Class {
	#name : #ERTestAffiliationInformation,
	#superclass : #ERTestModel,
	#category : #'ESUGApp-Test-UnitTest'
}

{ #category : #tests }
ERTestAffiliationInformation >> testEmptyOrganizationAddrees1Field [
	| org |
	org := (self class testAffiliationInformation) organizationAddrees1: nil; yourself .
	self assertEmptyField: org
]

{ #category : #tests }
ERTestAffiliationInformation >> testEmptyOrganizationCityField [
	| org |
	org := (self class testAffiliationInformation) organizationCity: nil; yourself .
	self assertEmptyField: org
]

{ #category : #tests }
ERTestAffiliationInformation >> testEmptyOrganizationNameField [
	| org |
	org := (self class testAffiliationInformation) organizationName: nil; yourself .
	self assertEmptyField: org
]

{ #category : #tests }
ERTestAffiliationInformation >> testEmptyOrganizationPostalField [
	| org |
	org := (self class testAffiliationInformation) organizationPostal: nil; yourself .
	self assertEmptyField: org
]

{ #category : #tests }
ERTestAffiliationInformation >> testNonValidOptionMembershipTypeField [
	| org |
	org := (self class testAffiliationInformation) membershipType: 'Non.Valid.Option'; yourself .
	self assertNonValidField: org
	
]

{ #category : #tests }
ERTestAffiliationInformation >> testNonValidOptionOrganizationCountryField [
	| org |
	org := (self class testAffiliationInformation) organizationCountry: 'Non.Valid.Option'; yourself .
	self assertNonValidField: org
]
