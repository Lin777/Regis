Class {
	#name : #ERContent,
	#superclass : #WAComponent,
	#instVars : [
		'state',
		'lastState'
	],
	#category : #'ESUGApp-Views'
}

{ #category : #initialization }
ERContent >> initialize [
	super initialize.
	state := nil
]

{ #category : #accessing }
ERContent >> lastState [
	^ lastState
]

{ #category : #rendering }
ERContent >> renderContentOn: html [
	state ifNotNil: [ html render: state ]
]

{ #category : #accessing }
ERContent >> state [
	^ state
]

{ #category : #accessing }
ERContent >> state: anObject [
	lastState := state.
	state := anObject
]
