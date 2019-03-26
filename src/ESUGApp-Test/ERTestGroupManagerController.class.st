Class {
	#name : #ERTestGroupManagerController,
	#superclass : #ERTest,
	#category : #'ESUGApp-Test-UnitTest'
}

{ #category : #initialization }
ERTestGroupManagerController >> setUp [
	| anUser |
	super setUp.
	anUser := self registerAsGroupManager.
	controller := ERGroupManagerController new.
	controller attendee: (controller conference attendeeFromUser: anUser)
]
