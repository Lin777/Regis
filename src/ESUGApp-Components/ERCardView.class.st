Class {
	#name : #ERCardView,
	#superclass : #ERComponent,
	#instVars : [
		'content',
		'title',
		'iconPage',
		'classContainer',
		'classColorIcon',
		'actionsBody'
	],
	#category : #'ESUGApp-Components'
}

{ #category : #'as yet unclassified' }
ERCardView class >> title: aString icon: anIcon content: aBlock [
	| instance |
	instance := self new.
	instance title: aString.
	instance iconPage: anIcon .
	instance content: aBlock .
	^ instance
]

{ #category : #'as yet unclassified' }
ERCardView class >> title: aString icon: anIcon content: aBlock id: anId [
	| instance |
	instance := self new.
	instance title: aString.
	instance iconPage: anIcon .
	instance content: aBlock .
	instance id: anId .
	^ instance
]

{ #category : #'as yet unclassified' }
ERCardView class >> title: aString icon: anIcon content: aBlock id: anId colorIcon: anColor [
	| instance |
	instance := self new.
	instance title: aString.
	instance iconPage: anIcon .
	instance content: aBlock .
	instance id: anId .
	instance classColorIcon: anColor.
	^ instance
]

{ #category : #'as yet unclassified' }
ERCardView class >> title: aString icon: anIcon content: aBlock id: anId colorIcon: anColor actions: aBlockActions [
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
ERCardView >> actionsBody [
	^ actionsBody
]

{ #category : #accessing }
ERCardView >> actionsBody: anObject [
	actionsBody := anObject
]

{ #category : #accessing }
ERCardView >> classColorIcon [
	^ classColorIcon
]

{ #category : #accessing }
ERCardView >> classColorIcon: anObject [
	classColorIcon := anObject
]

{ #category : #accessing }
ERCardView >> classContainer [
	^ classContainer
]

{ #category : #accessing }
ERCardView >> classContainer: anObject [
	classContainer := anObject
]

{ #category : #accessing }
ERCardView >> content [
	^ content
]

{ #category : #accessing }
ERCardView >> content: anObject [
	content := anObject
]

{ #category : #accessing }
ERCardView >> iconPage [
	^ iconPage
]

{ #category : #accessing }
ERCardView >> iconPage: anObject [
	iconPage := anObject
]

{ #category : #initialization }
ERCardView >> initialize [
	super initialize.
	classContainer := ''.
	classColorIcon := 'mdl-color--red'.
]

{ #category : #rendering }
ERCardView >> renderContentOn: html [
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
ERCardView >> renderIconCard: html [
	html div id: 'login-fab';
	class: self classColorIcon, ' mdl-color-text--white';
	with: [ 
		html icon id: 'lock-icon';
		class: 'material-icons';
		with: self iconPage
	].
]

{ #category : #accessing }
ERCardView >> title [
	^ title
]

{ #category : #accessing }
ERCardView >> title: anObject [
	title := anObject
]
