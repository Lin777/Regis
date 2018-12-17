Class {
	#name : #ERItemNav,
	#superclass : #ERComponent,
	#instVars : [
		'callback',
		'icon',
		'label'
	],
	#category : #'ESUGApp-Components'
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
		callback: callback;
		with: [ 
			html icon
				class: 'mdl-color-text--white material-icons';
				with: [ html text: icon ].
				html text:  label . ]
]
