Class {
	#name : #ERConferenceOptionsForm,
	#superclass : #ERAttendeeRegistrationForm,
	#category : #'ESUGApp-Components'
}

{ #category : #initialization }
ERConferenceOptionsForm >> initialize [
	super initialize.
]

{ #category : #rendering }
ERConferenceOptionsForm >> renderFormOn: html [
	
	html render: (ERConferenceOptions on: attendee)
]

{ #category : #accessing }
ERConferenceOptionsForm >> tabId [
	^ 'conferenceOptionsForm'
]

{ #category : #accessing }
ERConferenceOptionsForm >> tabName [
	^ 'Conference'
]
