Class {
	#name : #ERContentTab,
	#superclass : #ERStateContent,
	#instVars : [
		'active',
		'id',
		'container'
	],
	#category : #'ESUGApp-Component'
}

{ #category : #'instance creation' }
ERContentTab class >> on: anAttendee [
	| form |
	form := self new.
	form attendee: anAttendee.
	^ form
]

{ #category : #'instance creation' }
ERContentTab class >> on: anAttendee container: aContainer [
	| form |
	form := self new.
	form attendee: anAttendee.
	form container: aContainer.
	^ form
]

{ #category : #activation }
ERContentTab >> activate [
	active := true.
]

{ #category : #accessing }
ERContentTab >> attendee: anObject [
	attendee := anObject
]

{ #category : #accessing }
ERContentTab >> container: aContainer [
	container := aContainer
]

{ #category : #private }
ERContentTab >> deactivate [
	active := false.
]

{ #category : #initialization }
ERContentTab >> initialize [
	super initialize.
	active := false.
]

{ #category : #testing }
ERContentTab >> isActive [
	^ active.
]

{ #category : #rendering }
ERContentTab >> renderContentOn: html [
	self subclassResponsibility 
]

{ #category : #accessing }
ERContentTab >> tabId [
	^ self subclassResponsibility.
]

{ #category : #accessing }
ERContentTab >> tabName [
	^ self subclassResponsibility.
]

{ #category : #'as yet unclassified' }
ERContentTab >> updateStateTab: aString [
	container tabs detect: [ :tab | (tab tabName = aString) ]
	ifFound: [ :tab | tab activate.
		container tabs reject: [ :aTab | (aTab tabName = aString) ]
		thenDo: [ :aTab | aTab deactivate ]
	]
]
