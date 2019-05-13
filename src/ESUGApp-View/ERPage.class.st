"
Description
--------------------

I am an abstract page for all pages of login and register
"
Class {
	#name : #ERPage,
	#superclass : #ERStateContent,
	#instVars : [
		'pageController',
		'title',
		'icon',
		'id',
		'classContainer',
		'block'
	],
	#category : #'ESUGApp-View-Page'
}

{ #category : #rendering }
ERPage >> actionsBody: html [
]

{ #category : #accessing }
ERPage >> classContainer: anObject [
	classContainer := anObject
]

{ #category : #accessing }
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
	pageController := ERController new.
	classContainer:= ''.
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

{ #category : #rendering }
ERPage >> styleBackgound [
	^ 'background-image: url(''/files/CssForLoginMDL/city_profile1.jpg''); background-repeat: repeat-y; background-size: cover; height: 100vh; alt="Credit: Photo by Glenn Carstens-Peters on Unsplash" title="Credit: Photo by Glenn Carstens-Peters on Unsplash"'
]

{ #category : #accessing }
ERPage >> title: anObject [
	title := anObject
]
