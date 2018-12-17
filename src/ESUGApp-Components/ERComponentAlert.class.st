Class {
	#name : #ERComponentAlert,
	#superclass : #WAComponent,
	#instVars : [
		'id',
		'message',
		'class',
		'role',
		'wasShown'
	],
	#category : #'ESUGApp-Components'
}

{ #category : #'as yet unclassified' }
ERComponentAlert class >> warningAlert [
	^ self new
		class: 'alert alert-warning';
		role: 'alert';
		yourself .
]

{ #category : #accessing }
ERComponentAlert >> class1 [
	^ class
]

{ #category : #accessing }
ERComponentAlert >> class: anObject [
	class := anObject
]

{ #category : #rendering }
ERComponentAlert >> errorMessage: aString [

 self
  message: aString;
  wasShown: false.
]

{ #category : #accessing }
ERComponentAlert >> id [
	^ id
]

{ #category : #accessing }
ERComponentAlert >> id: anObject [
	id := anObject
]

{ #category : #initialization }
ERComponentAlert >> initialize [

 super initialize.
 self wasShown: true
]

{ #category : #accessing }
ERComponentAlert >> message [
	^ message
]

{ #category : #accessing }
ERComponentAlert >> message: anObject [
	message := anObject
]

{ #category : #rendering }
ERComponentAlert >> renderContentOn: html [
	self wasShown
		ifTrue: [ ^ self ].
	html div
		id: self id;
		class: self class1;
		attributeAt: 'role' put: self role;
		with: self message .
	self wasShown: true
]

{ #category : #accessing }
ERComponentAlert >> role [
	^ role
]

{ #category : #accessing }
ERComponentAlert >> role: anObject [
	role := anObject
]

{ #category : #accessing }
ERComponentAlert >> wasShown [
	^ wasShown
]

{ #category : #accessing }
ERComponentAlert >> wasShown: anObject [
	wasShown := anObject
]
