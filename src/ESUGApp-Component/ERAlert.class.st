Class {
	#name : #ERAlert,
	#superclass : #ERComponent,
	#instVars : [
		'message',
		'class',
		'role',
		'wasShown'
	],
	#category : #'ESUGApp-Component'
}

{ #category : #'as yet unclassified' }
ERAlert class >> warningAlert [
	^ self new
		class: 'alert alert-warning';
		role: 'alert';
		yourself .
]

{ #category : #accessing }
ERAlert >> class1 [
	^ class
]

{ #category : #accessing }
ERAlert >> class: anObject [
	class := anObject
]

{ #category : #rendering }
ERAlert >> errorMessage: aString [

 self
  message: aString;
  wasShown: false.
]

{ #category : #initialization }
ERAlert >> initialize [

 super initialize.
 self wasShown: true
]

{ #category : #accessing }
ERAlert >> message [
	^ message
]

{ #category : #accessing }
ERAlert >> message: anObject [
	message := anObject
]

{ #category : #rendering }
ERAlert >> renderContentOn: html [
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
ERAlert >> role [
	^ role
]

{ #category : #accessing }
ERAlert >> role: anObject [
	role := anObject
]

{ #category : #accessing }
ERAlert >> wasShown [
	^ wasShown
]

{ #category : #accessing }
ERAlert >> wasShown: anObject [
	wasShown := anObject
]
