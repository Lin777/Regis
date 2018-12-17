Class {
	#name : #ERGroup,
	#superclass : #SDActiveRecord,
	#instVars : [
		'groupManager',
		'listAttends'
	],
	#category : #'ESUGApp-Models'
}

{ #category : #accessing }
ERGroup class >> groupManager: anObject [
	^ self new
		groupManager: anObject;
		yourself
]

{ #category : #adding }
ERGroup >> addAttendee: anAttendee [
	listAttends add: anAttendee
]

{ #category : #accessing }
ERGroup >> groupManager [
	^ groupManager
]

{ #category : #accessing }
ERGroup >> groupManager: anObject [
	groupManager := anObject
]

{ #category : #accessing }
ERGroup >> initialize [
	listAttends := OrderedCollection new
]

{ #category : #accessing }
ERGroup >> listAttends [
	^ listAttends
]

{ #category : #accessing }
ERGroup >> listAttends: anObject [
	listAttends := anObject
]
