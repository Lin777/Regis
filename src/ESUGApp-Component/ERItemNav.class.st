Class {
	#name : #ERItemNav,
	#superclass : #ERComponent,
	#instVars : [
		'callback',
		'icon',
		'label'
	],
	#category : #'ESUGApp-Component'
}

{ #category : #'as yet unclassified' }
ERItemNav class >> label: aString icon: anIcon callback: aBlock [
	|instance|
	instance := self new.
	instance label: aString .
	instance icon: anIcon .
	instance callback: aBlock .
	^ instance 
]

{ #category : #accessing }
ERItemNav >> callback: anObject [
	callback := anObject
]

{ #category : #accessing }
ERItemNav >> icon: anObject [
	icon := anObject
]

{ #category : #accessing }
ERItemNav >> label: anObject [
	label := anObject
]

{ #category : #rendering }
ERItemNav >> renderContentOn: html [
	html mdlNavigationLink
		id: label,'-option';
		callback: callback;
		with: [ 
			html mdlIcon
				class: 'mdl-color-text--white';
				with: [ html text: icon ].
				html text:  label . ]
]
