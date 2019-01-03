Class {
	#name : #ERController,
	#superclass : #Object,
	#instVars : [
		'conference'
	],
	#category : #'ESUGApp-Controllers'
}

{ #category : #accessing }
ERController >> conference [
	^ conference
]

{ #category : #accessing }
ERController >> conference: anObject [
	conference := anObject
]

{ #category : #accessing }
ERController >> conferenceIsOpenRegistration [
	^ self conference configuration openRegistration
]

{ #category : #accessing }
ERController >> initialize [
	super initialize .
	conference := ERConference find: [ :each | each active ]
]
