Class {
	#name : #ERTab,
	#superclass : #ERComponentFactory,
	#instVars : [
		'active',
		'id'
	],
	#category : #'ESUGApp-Components'
}

{ #category : #'instance creation' }
ERTab class >> on: anAttendee [
	| form |
	form := self new.
	form attendee: anAttendee.
	^ form
]

{ #category : #activation }
ERTab >> activate [
	active := true.
]

{ #category : #accessing }
ERTab >> attendee: anObject [
	attendee := anObject
]

{ #category : #building }
ERTab >> createButtonField: aName with: aBlock id: anId [
	^ ERButtonLabel
		label: aName
		callback: aBlock
		id: anId
		type: 'submit'
]

{ #category : #private }
ERTab >> deactivate [
	active := false.
]

{ #category : #building }
ERTab >> idFromSymbol: aSymbol [
	^ (aSymbol substrings: ':') first 
]

{ #category : #initialization }
ERTab >> initialize [
	super initialize.
	active := false.
]

{ #category : #testing }
ERTab >> isActive [
	^ active.
]

{ #category : #rendering }
ERTab >> renderContentOn: html [
	self subclassResponsibility 
]

{ #category : #accessing }
ERTab >> tabId [
	^ self subclassResponsibility.
]

{ #category : #accessing }
ERTab >> tabName [
	^ self subclassResponsibility.
]
