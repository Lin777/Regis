Class {
	#name : #ERTextFieldLabel,
	#superclass : #ERComponentLabel,
	#instVars : [
		'textType',
		'callback',
		'value'
	],
	#category : #'ESUGApp-Components'
}

{ #category : #'instance creation' }
ERTextFieldLabel class >> label: aString callback: aBlock [
	| instance |
	instance := self new.
	instance label: aString.
	instance callback: aBlock.
	^ instance
]

{ #category : #'instance creation' }
ERTextFieldLabel class >> label: aString callback: aBlock id: anId [
	| instance |
	instance := self new.
	instance label: aString.
	instance callback: aBlock.
	instance id: anId.
	^ instance
]

{ #category : #'instance creation' }
ERTextFieldLabel class >> label: aString callback: aBlock id: anId percent: aNumber [
	| instance |
	instance := self new.
	instance label: aString.
	instance callback: aBlock.
	instance id: anId.
	instance percent: aNumber .
	^ instance
]

{ #category : #'instance creation' }
ERTextFieldLabel class >> label: aString callback: aBlock id: anId value: aValue [
	| instance |
	instance := self new.
	instance label: aString.
	instance value: aValue .
	instance callback: aBlock.
	instance id: anId.
	^ instance
]

{ #category : #accessing }
ERTextFieldLabel >> callback [
	^ callback
]

{ #category : #accessing }
ERTextFieldLabel >> callback: anObject [
	callback := anObject
]

{ #category : #accessing }
ERTextFieldLabel >> forPassword [
	textType := 'password'
]

{ #category : #initalize }
ERTextFieldLabel >> initialize [
	super initialize.
	textType := 'text'.
]

{ #category : #rendering }
ERTextFieldLabel >> renderContentOn: html [
	html mdlTextFieldContainer
		floatingLabel;
		style: self percent;
		with: [ html mdlTextFieldLabel
				for: self id;
				with: self label.
			html mdlTextFieldInput
				id: self id;
				type: self textType;
				value: self value1 ;
				callback: self callback.]
]

{ #category : #accessing }
ERTextFieldLabel >> textType [
	^ textType
]

{ #category : #accessing }
ERTextFieldLabel >> textType: anObject [
	textType := anObject
]

{ #category : #accessing }
ERTextFieldLabel >> value1 [
	^ value
]

{ #category : #accessing }
ERTextFieldLabel >> value: anObject [
	value := anObject
]
