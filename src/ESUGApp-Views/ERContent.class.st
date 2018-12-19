Class {
	#name : #ERContent,
	#superclass : #WAComponent,
	#instVars : [
		'state'
	],
	#category : #'ESUGApp-Views'
}

{ #category : #initialization }
ERContent >> initialize [
	super initialize.
	state := nil
]

{ #category : #rendering }
ERContent >> renderContentOn: html [ 
	state ifNotNil: [ 
		html render: state ]
]

{ #category : #accessing }
ERContent >> state [
	^ state
]

{ #category : #accessing }
ERContent >> state: anObject [
	state := anObject
]
