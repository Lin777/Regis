Class {
	#name : #ERConfigurationViewController,
	#superclass : #ERLoggedController,
	#instVars : [
		'conference'
	],
	#category : #'ESUGApp-Controllers'
}

{ #category : #accessing }
ERConfigurationViewController >> conference [
	^ conference
]

{ #category : #accessing }
ERConfigurationViewController >> conference: anObject [
	conference := anObject
]
