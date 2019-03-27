Class {
	#name : #ERTestAward,
	#superclass : #ERTestModel,
	#instVars : [
		'attendee'
	],
	#category : #'ESUGApp-Test-UnitTest'
}

{ #category : #tests }
ERTestAward >> setUp [
	super setUp.
	attendee := controller conference attendeeFromUser: self registerAttendee 
]

{ #category : #tests }
ERTestAward >> testEmptyAffiliationField [
	| award |
	award := (self class testAward: attendee) affiliation: nil; yourself .
	self assertEmptyField: award
]

{ #category : #tests }
ERTestAward >> testEmptyDownloadUrlField [
	| award |
	award := (self class testAward: attendee) downloadUrl: nil; yourself .
	self assertEmptyField: award
]

{ #category : #tests }
ERTestAward >> testEmptyNameAwardField [
	| award |
	award := (self class testAward: attendee) nameAward: nil; yourself .
	self assertEmptyField: award
]

{ #category : #tests }
ERTestAward >> testNonValidOptionCountryField [
	| award |
	award := (self class testAward: attendee) country: 'Non.Valid.Option'; yourself .
	self assertNonValidField: award
]
