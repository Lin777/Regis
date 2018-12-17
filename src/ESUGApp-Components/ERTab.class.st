Class {
	#name : #ERTab,
	#superclass : #WAComponent,
	#instVars : [
		'attendee',
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
	^  ERButtonLabel label: aName callback: aBlock id: anId type: 'submit'
]

{ #category : #building }
ERTab >> createTextField: aName [
	^ ERTextFieldLabel label: aName callback: [ :value |  ] 
]

{ #category : #building }
ERTab >> createTextField: aName callback: aBlock [
	^ ERTextFieldLabel label: aName callback: aBlock
]

{ #category : #building }
ERTab >> createTextField: aName for: aSymbol [
	^  ERTextFieldLabel label: aName callback: [ :value | attendee perform: aSymbol with: value asString . ] id: (self idFromSymbol: aSymbol )
]

{ #category : #building }
ERTab >> createTextField: aName for: aSymbol percent: aNumber [
	^  ERTextFieldLabel label: aName callback: [ :value | attendee perform: aSymbol with: value asString .] id: (self idFromSymbol: aSymbol ) percent: aNumber 
]

{ #category : #building }
ERTab >> createTextField: aName for: aSymbol withValue: aString [
	^  ERTextFieldLabel label: aName callback: [ :value | attendee perform: aSymbol with: value asString . ] id: (self idFromSymbol: aSymbol ) value: aString 
]

{ #category : #building }
ERTab >> createTextStrong: aString text: aText [
	^  ERTextStrongByValue label: aString text: aText 
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
