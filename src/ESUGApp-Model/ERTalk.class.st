Class {
	#name : #ERTalk,
	#superclass : #SDActiveRecord,
	#instVars : [
		'name',
		'submittedBy',
		'uploadFile'
	],
	#category : #'ESUGApp-Model'
}

{ #category : #accessing }
ERTalk >> name1 [
	^ name
]

{ #category : #accessing }
ERTalk >> name: anObject [
	name := anObject
]

{ #category : #accessing }
ERTalk >> submittedBy [
	^ submittedBy
]

{ #category : #accessing }
ERTalk >> submittedBy: anObject [
	submittedBy := anObject
]

{ #category : #accessing }
ERTalk >> uploadFile [
	^ uploadFile
]

{ #category : #accessing }
ERTalk >> uploadFile: anObject [
	uploadFile := anObject
]
