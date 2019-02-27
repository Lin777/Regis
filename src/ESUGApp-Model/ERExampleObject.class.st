Class {
	#name : #ERExampleObject,
	#superclass : #SDMemoryStore,
	#instVars : [
		'firstName',
		'lastName'
	],
	#category : #'ESUGApp-Model'
}

{ #category : #accessing }
ERExampleObject >> firstName [
	^ firstName
]

{ #category : #accessing }
ERExampleObject >> firstName: anObject [
	firstName := anObject
]

{ #category : #accessing }
ERExampleObject >> lastName [
	^ lastName
]

{ #category : #accessing }
ERExampleObject >> lastName: anObject [
	lastName := anObject
]
