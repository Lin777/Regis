"
Description
--------------------

A ERTestContactInformation is a test class for testing the behavior of ERContactInformation model
"
Class {
	#name : #ERContactInformationTest,
	#superclass : #ERModelTest,
	#category : #'ESUGApp-Tests-UnitTest'
}

{ #category : #tests }
ERContactInformationTest >> testNonValidOptionOrganizationCountryField [

	| org |
	org := (self class testContactInformation) country: 'Non.Valid.Option'; yourself .
	self assertNonValidField: org
]
