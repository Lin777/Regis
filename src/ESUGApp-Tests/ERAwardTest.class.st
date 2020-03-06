"
Description
--------------------

A ERTestAward is a test class for testing the behavior of ERAward model
"
Class {
	#name : #ERAwardTest,
	#superclass : #ERModelTest,
	#instVars : [
		'attendee'
	],
	#category : #'ESUGApp-Tests-UnitTest'
}

{ #category : #running }
ERAwardTest >> setUp [

	super setUp.
	attendee := controller conference attendeeFromUser: self registerAttendee
]

{ #category : #tests }
ERAwardTest >> testEmptyAffiliationField [

	| award |
	award := (self class testAward: attendee) affiliation: nil;
		yourself.
	self assertEmptyField: award
]

{ #category : #tests }
ERAwardTest >> testEmptyDownloadUrlField [

	| award |
	award := (self class testAward: attendee) downloadUrl: nil;
		yourself.
	self assertEmptyField: award
]

{ #category : #tests }
ERAwardTest >> testEmptyNameAwardField [

	| award |
	award := (self class testAward: attendee) nameAward: nil;
		yourself.
	self assertEmptyField: award
]

{ #category : #tests }
ERAwardTest >> testNonValidOptionCountryField [

	| award |
	award := (self class testAward: attendee) country: 'Non.Valid.Option'; 
		yourself.
	self assertNonValidField: award
]
