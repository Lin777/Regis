Class {
	#name : #ERTextStrongByValue,
	#superclass : #ERComponentLabel,
	#instVars : [
		'text'
	],
	#category : #'ESUGApp-Components'
}

{ #category : #'as yet unclassified' }
ERTextStrongByValue class >> label: aString text: aText [
	| instance |
	instance := self new.
	instance label: aString.
	instance text: aText.
	^ instance
]

{ #category : #rendering }
ERTextStrongByValue >> renderContentOn: html [
	html paragraph: [ html strong: label. html text: text ].
]

{ #category : #accessing }
ERTextStrongByValue >> text [
	^ text
]

{ #category : #accessing }
ERTextStrongByValue >> text: anObject [
	text := anObject
]
