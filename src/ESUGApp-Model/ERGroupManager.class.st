"
Description
--------------------

I am a model of Group Manager
"
Class {
	#name : #ERGroupManager,
	#superclass : #Object,
	#instVars : [
		'userAccount'
	],
	#category : #'ESUGApp-Model-Magritte'
}

{ #category : #initialize }
ERGroupManager >> initialize [ 
	super initialize.
	userAccount := ERUserAccount asGroupManager.
]

{ #category : #accessing }
ERGroupManager >> userAccount [
	^ userAccount
]

{ #category : #accessing }
ERGroupManager >> userAccount: anObject [
	userAccount := anObject
]
