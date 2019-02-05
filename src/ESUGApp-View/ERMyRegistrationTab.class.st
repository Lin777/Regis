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

{ #category : #rendering }
ERMyRegistrationTab >> proposalsAreAllowed [
	^ ERController new conference configuration 
	dateSubmissionDeadline asDate < Date today 
]
