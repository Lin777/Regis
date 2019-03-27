"
Description
--------------------

Abstract superclass of all ESUG components. 

"
Class {
	#name : #ERComponent,
	#superclass : #WAComponent,
	#instVars : [
		'id'
	],
	#category : #'ESUGApp-Component'
}

{ #category : #accessing }
ERComponent >> id [
	^ id
]

{ #category : #accessing }
ERComponent >> id: anObject [
	id := anObject
]
