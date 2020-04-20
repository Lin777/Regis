"
I am the principal class to register only one Attendee
"
Class {
	#name : #ERMyRegistrationTab,
	#superclass : #ERContainerTab,
	#category : #'ESUGApp-View-Tab'
}

{ #category : #'as yet unclassified' }
ERMyRegistrationTab class >> on: anAttendee withContent: aContent container: aContainer [
	| form |
	form := self new.
	form attendee: anAttendee.
	form content: aContent.
	form container: aContainer.
	^ form
]

{ #category : #initialization }
ERMyRegistrationTab >> initialize [
	super initialize.
	controller := ERController new.
]

{ #category : #rendering }
ERMyRegistrationTab >> proposalsAreAllowed [
	^ controller conference configuration 
	dateSubmissionDeadline asDate >= Date today 
]

{ #category : #rendering }
ERMyRegistrationTab >> renderContainerOn: html [

	self subclassResponsibility 
]

{ #category : #accessing }
ERMyRegistrationTab >> title [

	self subclassResponsibility 
]
