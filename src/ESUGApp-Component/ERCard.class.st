Class {
	#name : #ERCard,
	#superclass : #ERComponent,
	#instVars : [
		'content',
		'title',
		'iconPage',
		'classContainer',
		'classColorIcon',
		'actionsBody'
	],
	#category : #'ESUGApp-Component'
}

{ #category : #'as yet unclassified' }
ERCard class >> title: aString icon: anIcon content: aBlock id: anId colorIcon: anColor actions: aBlockActions [
	| instance |
	instance := self new.
	instance title: aString.
	instance iconPage: anIcon .
	instance content: aBlock .
	instance id: anId .
	instance classColorIcon: anColor.
	instance actionsBody: aBlockActions.
	^ instance
]

{ #category : #accessing }
ERCard >> actionsBody [
	^ actionsBody
]

{ #category : #accessing }
ERCard >> actionsBody: anObject [
	actionsBody := anObject
]

{ #category : #accessing }
ERCard >> classColorIcon [
	^ classColorIcon
]

{ #category : #accessing }
ERCard >> classColorIcon: anObject [
	classColorIcon := anObject
]

{ #category : #accessing }
ERCard >> classContainer [
	^ classContainer
]

{ #category : #accessing }
ERCard >> classContainer: anObject [
	classContainer := anObject
]

{ #category : #accessing }
ERCard >> content [
	^ content
]

{ #category : #accessing }
ERCard >> content: anObject [
	content := anObject
]

{ #category : #accessing }
ERCard >> iconPage [
	^ iconPage
]

{ #category : #accessing }
ERCard >> iconPage: anObject [
	iconPage := anObject
]

{ #category : #initialization }
ERCard >> initialize [
	super initialize.
	classContainer := ''.
	classColorIcon := 'mdl-color--red'.
]

{ #category : #rendering }
ERCard >> renderContentOn: html [
	html mdlCard id: self id;
	class: classContainer, ' mdl-shadow--16dp';
	with: [ 
		html mdlCardTextContainer 
		with: [ 
			self renderIconCard: html.
			html div id: 'card-heading';
			with: self title.
			self content value.
		].	
		self actionsBody value.
	].
]

{ #category : #rendering }
ERCard >> renderIconCard: html [
	html div id: 'login-fab';
	class: self classColorIcon, ' mdl-color-text--white';
	with: [ 
		html icon id: 'lock-icon';
		class: 'material-icons';
		with: self iconPage
	].
]

{ #category : #accessing }
ERCard >> title [
	^ title
]

{ #category : #accessing }
ERCard >> title: anObject [
	title := anObject
]
