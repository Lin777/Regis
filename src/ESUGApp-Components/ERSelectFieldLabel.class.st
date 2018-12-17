Class {
	#name : #ERSelectFieldLabel,
	#superclass : #ERComponentLabel,
	#instVars : [
		'list',
		'callback'
	],
	#category : #'ESUGApp-Components'
}

{ #category : #'as yet unclassified' }
ERSelectFieldLabel class >> label: aString callback: aBlock list: aList [
	| instance |
	instance := self new.
	instance label: aString.
	instance callback: aBlock.
	instance list: aList.
	^ instance
]

{ #category : #'as yet unclassified' }
ERSelectFieldLabel class >> label: aString callback: aBlock list: aList id: anId [
	| instance |
	instance := self new.
	instance label: aString.
	instance callback: aBlock.
	instance list: aList.
	instance id: anId .
	^ instance
]

{ #category : #'as yet unclassified' }
ERSelectFieldLabel class >> label: aString callback: aBlock list: aList id: anId percent: aNumber [
	| instance |
	instance := self new.
	instance label: aString.
	instance callback: aBlock.
	instance list: aList.
	instance id: anId .
	instance percent: aNumber .
	^ instance
]

{ #category : #accessing }
ERSelectFieldLabel >> callback [
	^ callback
]

{ #category : #accessing }
ERSelectFieldLabel >> callback: anObject [
	callback := anObject
]

{ #category : #accessing }
ERSelectFieldLabel >> list [
	^ list
]

{ #category : #accessing }
ERSelectFieldLabel >> list: anObject [
	list := anObject
]

{ #category : #rendering }
ERSelectFieldLabel >> renderContentOn: html [
	html mdlTextFieldContainer
		floatingLabel;
		style: self percent;
		with: [ html mdlTextFieldLabel
				with: self label.
			html select
				class: 'mdl-textfield__input';
				id: self id;
				list: self list;
				callback: self callback. ]
]
