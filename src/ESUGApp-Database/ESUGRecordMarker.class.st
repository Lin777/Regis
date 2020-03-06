"
I exist to mark a reference to another object in the serialized file, I'm replaced by a real object when I'm deserialized.  I'm basically a manually invoked proxy being used because getting a real proxy that inherits from ProtoObject to serialize seemed hurculean.
"
Class {
	#name : #ESUGRecordMarker,
	#superclass : #Object,
	#instVars : [
		'id',
		'className'
	],
	#category : #'ESUGApp-Database-Core'
}

{ #category : #converting }
ESUGRecordMarker >> asOriginalObject [
	"this needs to call cachedLoadFrom not findById in order to allow cycles in 
	the serialized graph this allows an object that references an unloaded object 
	during the loadAll to force it's load instead of failing"
	| origClass |
	origClass := Smalltalk at: className.
	"I'm checking inheritsFrom: here so that any classes that used to be 
	activeRecords but aren't anymore that had serialized instances are 
	caught and return nil when resolved rather than blow up.  This happens
	often during development when you're changing your model a lot"
	^ (origClass inheritsFrom: ESUGActiveRecord) 
		ifTrue: [ ESUGActiveRecord store cachedLoadOfClass: (Smalltalk at: className)  from: id ]
		ifFalse: [ nil ]
]

{ #category : #introspection }
ESUGRecordMarker >> className [
	^ className
]

{ #category : #accessing }
ESUGRecordMarker >> className: anObject [
	className := anObject
]

{ #category : #accessing }
ESUGRecordMarker >> id [
	^ id
]

{ #category : #accessing }
ESUGRecordMarker >> id: anObject [
	id := anObject
]

{ #category : #testing }
ESUGRecordMarker >> isMarker [
	^ true
]
