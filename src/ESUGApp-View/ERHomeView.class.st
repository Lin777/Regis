"
Description
-----------


I am the principal view when you enter into your account on ESUG
"
Class {
	#name : #ERHomeView,
	#superclass : #ERTittledView,
	#category : #'ESUGApp-View-View'
}

{ #category : #'as yet unclassified' }
ERHomeView class >> withContent: aContent withController: aController [
	| form |
	form := self new.
	form content: aContent.
	form controller: aController.
	^ form
]

{ #category : #rendering }
ERHomeView >> renderPageOn: html [
	html html: controller conference configurationOfHomePage htmlContent
]

{ #category : #rendering }
ERHomeView >> title [
	^ controller conference configurationOfHomePage title
]
