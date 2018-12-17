Class {
	#name : #ERComponentLabel,
	#superclass : #ERComponent,
	#instVars : [
		'label'
	],
	#category : #'ESUGApp-Components'
}

{ #category : #initialization }
ERComponentLabel >> initialize [
	super initialize.
]

{ #category : #accessing }
ERComponentLabel >> label [
	^ label
]

{ #category : #accessing }
ERComponentLabel >> label: anObject [
	label := anObject
]
