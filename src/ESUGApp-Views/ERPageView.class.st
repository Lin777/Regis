Class {
	#name : #ERPageView,
	#superclass : #ERFactoryComponent,
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

{ #category : #accessing }
ERPageView >> classContainer: anObject [
	classContainer := anObject
]

{ #category : #'as yet unclassified' }
ERPageView >> colorIcon [
	^ 'mdl-color--red' 
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
ERPageView >> renderContentOn: html [
	html
		render:
			((ERCardView
				title: title
				icon: icon
				content: [ self renderPageOn: html ]
				id: id
				colorIcon: self colorIcon) classContainer: classContainer)
	"html render: ERFooterView new"
]

{ #category : #rendering }
ERPageView >> renderPageOn: html [
	self subclassResponsibility.
	
]

{ #category : #accessing }
ERPageView >> title: anObject [
	title := anObject
]
