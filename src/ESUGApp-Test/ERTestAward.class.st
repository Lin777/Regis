Class {
	#name : #ERTestAward,
	#superclass : #ERTestModel,
	#instVars : [
		'attendee'
	],
	#category : #'ESUGApp-Test'
}

{ #category : #tests }
ERTestAward >> setUp [
	super setUp.
	attendee := ERLoggedController new attendeeFromUser: self registerAttendee 
]

{ #category : #tests }
ERTestAward >> testEmptyAffiliationField [
	| errors award |
	award := (self class testAward: attendee) affiliation: nil; yourself .
	errors := award asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: messageInputRequired equals: (errors at:1) messageText.
	
]

{ #category : #tests }
ERTestAward >> testEmptyDownloadUrlField [
	| errors award |
	award := (self class testAward: attendee) downloadUrl: nil; yourself .
	errors := award asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: messageInputRequired equals: (errors at:1) messageText.
	
]

{ #category : #tests }
ERTestAward >> testEmptyNameAwardField [
	| errors award |
	award := (self class testAward: attendee) nameAward: nil; yourself .
	errors := award asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: messageInputRequired equals: (errors at:1) messageText.
	
]

{ #category : #tests }
ERTestAward >> testNonValidOptionCountryField [
	| errors org |
	org := (self class testAward: attendee) country: 'Non.Valid.Option'; yourself .
	errors := org asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: self messageInvalidInput equals: (errors at:1) messageText
]
