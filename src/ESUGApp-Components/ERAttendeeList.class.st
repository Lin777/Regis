Class {
	#name : #ERAttendeeList,
	#superclass : #ERConfiguration,
	#category : #'ESUGApp-Components'
}

{ #category : #rendering }
ERAttendeeList >> renderContainer: html [
	html horizontalRule.
]

{ #category : #accessing }
ERAttendeeList >> tabId [
	^ 'attendees'
]

{ #category : #accessing }
ERAttendeeList >> tabName [
	^ 'Attendees'
]

{ #category : #accessing }
ERAttendeeList >> title [
	^ 'Attendees'
]
