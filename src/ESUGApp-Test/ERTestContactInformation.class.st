Class {
	#name : #ERTestContactInformation,
	#superclass : #ERTestModel,
	#category : #'ESUGApp-Test-UnitTest'
}

{ #category : #tests }
ERTestContactInformation >> testNonValidOptionOrganizationCountryField [
	| org |
	org := (self class testContactInformation) country: 'Non.Valid.Option'; yourself .
	self assertNonValidField: org
]
