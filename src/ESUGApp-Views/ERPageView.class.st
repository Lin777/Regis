Class {
	#name : #ERPageView,
	#superclass : #ERStateContent,
	#instVars : [
		'pageController',
		'title',
		'icon',
		'id',
		'classContainer'
	],
	#category : #'ESUGApp-Views'
}

{ #category : #'options-generated' }
ERPageView class >> using: aPageController [
	|instance|
	instance := self new.
	instance controller: aPageController.
	^ instance.
	
]

{ #category : #'as yet unclassified' }
ERPageView >> actionsBody: html [
	self subclassResponsibility 
]

{ #category : #accessing }
ERPageView >> classContainer: anObject [
	classContainer := anObject
]

{ #category : #'as yet unclassified' }
ERPageView >> colorIcon [
	^ 'mdl-color--blue-700' 
]

{ #category : #accessing }
ERPageView >> controller [
	^ pageController
]

{ #category : #accessing }
ERPageView >> icon [
	^ icon
]

{ #category : #accessing }
ERPageView >> icon: anObject [
	icon := anObject
]

{ #category : #accessing }
ERPageView >> id: anObject [
	id := anObject
]

{ #category : #initialization }
ERPageView >> initialize [
	super initialize.
	classContainer:= ''
]

{ #category : #accessing }
ERPageView >> pageController: anObject [
	pageController := anObject
]

{ #category : #rendering }
ERPageView >> renderBody: html with: aBlock [
	self subclassResponsibility 
]

{ #category : #rendering }
ERPageView >> renderContentOn: html [
	| block |
	block := [ html
		render:
			((ERCardView
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
ERPageView >> renderPageOn: html [
	self subclassResponsibility.
	
]

{ #category : #accessing }
ERPageView >> title: anObject [
	title := anObject
]
