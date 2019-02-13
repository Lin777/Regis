Class {
	#name : #ERTestContactInformation,
	#superclass : #ERTestModel,
	#category : #'ESUGApp-Test'
}

{ #category : #tests }
ERTestContactInformation >> testNonValidOptionOrganizationCountryField [
	| org |
	org := (self class testContactInformation) country: 'Non.Valid.Option'; yourself .
	self assertNonValidField: org
]
