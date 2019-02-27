Class {
	#name : #ERContent,
	#superclass : #WAComponent,
	#instVars : [
		'state',
		'states'
	],
	#category : #'ESUGApp-View'
}

{ #category : #rendering }
ERContent >> children [ 	
	^ Array with: state
]

{ #category : #initialization }
ERContent >> initialize [
	super initialize.
	states := OrderedCollection new.
	state := nil
]

{ #category : #accessing }
ERContent >> lastState [
	^ states removeLast
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
	states add: state .
	state := anObject
]
