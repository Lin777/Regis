Class {
	#name : #ERAward,
	#superclass : #SDActiveRecord,
	#instVars : [
		'name',
		'submittedBy'
	],
	#category : #'ESUGApp-Models'
}

{ #category : #accessing }
ERAward >> name1 [
	^ name
]

{ #category : #accessing }
ERAward >> name: anObject [
	name := anObject
]

{ #category : #accessing }
ERAward >> submittedBy [
	^ submittedBy
]

{ #category : #accessing }
ERAward >> submittedBy: anObject [
	submittedBy := anObject
]
