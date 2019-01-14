Class {
	#name : #ERPage,
	#superclass : #ERStateContent,
	#instVars : [
		'pageController',
		'title',
		'icon',
		'id',
		'classContainer'
	],
	#category : #'ESUGApp-View-Page'
}

{ #category : #'as yet unclassified' }
ERPage >> actionsBody: html [
	self subclassResponsibility 
]

{ #category : #accessing }
ERPage >> classContainer: anObject [
	classContainer := anObject
]

{ #category : #'as yet unclassified' }
ERPage >> colorIcon [
	^ 'mdl-color--blue-700' 
]

{ #category : #accessing }
ERPage >> controller [
	^ pageController
]

{ #category : #accessing }
ERPage >> icon [
	^ icon
]

{ #category : #accessing }
ERPage >> icon: anObject [
	icon := anObject
]

{ #category : #accessing }
ERPage >> id: anObject [
	id := anObject
]

{ #category : #initialization }
ERPage >> initialize [
	super initialize.
	classContainer:= ''
]

{ #category : #accessing }
ERPage >> pageController: anObject [
	pageController := anObject
]

{ #category : #rendering }
ERPage >> renderBody: html with: aBlock [
	self subclassResponsibility 
]

{ #category : #rendering }
ERPage >> renderContentOn: html [
	| block |
	block := [ html
		render:
			((ERCard
				title: title
				icon: icon
				content: [ self renderPageOn: html ]
				id: id
				colorIcon: self colorIcon
				actions: (self actionsBody: html))
				classContainer: classContainer)].
	self renderBody: html with: block
]

{ #category : #rendering }
ERPage >> renderPageOn: html [
	self subclassResponsibility.
	
]

{ #category : #accessing }
ERPage >> title: anObject [
	title := anObject
]
