"
Description
--------------------

I am a Subject Class of Observer Pattern

Instance Variables
--------------------
	observers: an OrderedCollection of observers
"
Class {
	#name : #ERSubject,
	#superclass : #Object,
	#instVars : [
		'observers'
	],
	#category : #'ESUGApp-Controller'
}

{ #category : #accessing }
ERSubject >> addObserver: anObserver [
	self observers add: anObserver 
]

{ #category : #accessing }
ERSubject >> notifyAllObservers [
	self observers do: [ :ob | ob update ]
]

{ #category : #accessing }
ERSubject >> observers [
	^ observers ifNil: [ observers := OrderedCollection new ]
]
