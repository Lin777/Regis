Class {
	#name : #ERCheckboxFieldLabel,
	#superclass : #ERComponentLabel,
	#instVars : [
		'callback'
	],
	#category : #'ESUGApp-Components'
}

{ #category : #'instance creation' }
ERCheckboxFieldLabel class >> label: aString callback: aBlock [
	| instance |
	instance := self new.
	instance label: aString.
	instance callback: aBlock.
	^ instance
]

{ #category : #'instance creation' }
ERCheckboxFieldLabel class >> label: aString callback: aBlock id: anId [
	| instance |
	instance := self new.
	instance label: aString.
	instance callback: aBlock.
	instance id: anId .
	^ instance
]

{ #category : #accessing }
ERCheckboxFieldLabel >> callback [
	^ callback
]

{ #category : #accessing }
ERCheckboxFieldLabel >> callback: anObject [
	callback := anObject
]

{ #category : #rendering }
ERCheckboxFieldLabel >> renderContentOn: html [
		html mdlCheckboxContainer
		rippleEffect;
		style: self percent;
		for: self id;
		with: [ html mdlCheckbox
				value: true;
				id: self id.
			html mdlCheckboxLabel: self label ]

]
