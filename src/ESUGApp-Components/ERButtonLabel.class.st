Class {
	#name : #ERButtonLabel,
	#superclass : #ERComponentLabel,
	#instVars : [
		'callback',
		'class',
		'type',
		'style'
	],
	#category : #'ESUGApp-Components'
}

{ #category : #'instance creation' }
ERButtonLabel class >> label: aString callback: aBlock [
	| instance |
	instance := self new.
	instance label: aString.
	instance callback: aBlock.
	^ instance
]

{ #category : #'instance creation' }
ERButtonLabel class >> label: aString callback: aBlock id: anId [
	| instance |
	instance := self new.
	instance label: aString.
	instance callback: aBlock.
	instance id: anId.
	^ instance
]

{ #category : #'instance creation' }
ERButtonLabel class >> label: aString callback: aBlock id: anId type: aType [
	| instance |
	instance := self new.
	instance label: aString.
	instance callback: aBlock.
	instance id: anId.
	instance type: aType .
	^ instance
]

{ #category : #accessing }
ERButtonLabel >> callback [
	^ callback
]

{ #category : #accessing }
ERButtonLabel >> callback: anObject [
	callback := anObject
]

{ #category : #accessing }
ERButtonLabel >> class1 [
	^ class
]

{ #category : #accessing }
ERButtonLabel >> class: anObject [
	class := anObject
]

{ #category : #'as yet unclassified' }
ERButtonLabel >> forAcceptButton [
	self class: 'mdl-button mdl-js-button mdl-button--colored'
]

{ #category : #'as yet unclassified' }
ERButtonLabel >> forContentButton [
	self class: 'mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect'
]

{ #category : #'as yet unclassified' }
ERButtonLabel >> forContentButtonAccent [
	self class: 'mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--accent'
]

{ #category : #'as yet unclassified' }
ERButtonLabel >> forContentButtonColored [
	self class: 'mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--colored'
]

{ #category : #'as yet unclassified' }
ERButtonLabel >> forLoginButton [
	self class: 'mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--colored mdl-button--accent mdl-color-text--white'
]

{ #category : #'as yet unclassified' }
ERButtonLabel >> forRegisterAsGroupManagerButton [
	self class: 'mdl-button mdl-js-button mdl-button--primary'
]

{ #category : #'as yet unclassified' }
ERButtonLabel >> forRegisterButton [
	self class: 'mdl-button mdl-js-button mdl-color-text--accent'
]

{ #category : #'as yet unclassified' }
ERButtonLabel >> forTableButton [
	self class: 'mdl-button mdl-js-button mdl-button--colored'
]

{ #category : #rendering }
ERButtonLabel >> initialize [
	super initialize .
	class := ''.
	type := 'submit'.
	style := [  ].
]

{ #category : #rendering }
ERButtonLabel >> renderContentOn: html [
	html mdlButton
		type: self type;
		id: self id;
		class: self class1;
		callback: self callback;
		with: self label.
		
]

{ #category : #accessing }
ERButtonLabel >> type [
	^ type
]

{ #category : #accessing }
ERButtonLabel >> type: anObject [
	type := anObject
]
