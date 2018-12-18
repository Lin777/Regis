Class {
	#name : #ERTestGroupManagerViewController,
	#superclass : #ERTestControllers,
	#category : #'ESUGApp-Test'
}

{ #category : #tests }
ERTestGroupManagerViewController >> testAddAttendeeTo [
	| user1 user2 group |
	user1 := self registerAttendee.
	user2 := self registerAttendee: ERTestControllers testExampleAttendee.
	group := ERGroupManagerViewController new
		addAttendee: user1
		to: user2.
	self deny: group isNil 
]

{ #category : #tests }
ERTestGroupManagerViewController >> testGroupOfAttendee [
	| user group |
	user := self registerAttendee.
	group := ERGroupManagerViewController new
		groupOfAttendee: user.
	self assert: (group isKindOf: ERGroup )
]
