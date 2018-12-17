Class {
	#name : #ERLoggedController,
	#superclass : #Object,
	#instVars : [
		'user'
	],
	#category : #'ESUGApp-Controllers'
}

{ #category : #'as yet unclassified' }
ERLoggedController >> getAttendee [
	^ ERAttendee find: [ :each | each userAccount = user ]
]

{ #category : #accessing }
ERLoggedController >> initialize [
	super initialize .
	user := ERUserAccount new
]

{ #category : #accessing }
ERLoggedController >> user: anUser [
	user := anUser
]
