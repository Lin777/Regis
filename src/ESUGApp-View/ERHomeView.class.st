Class {
	#name : #ERHomeView,
	#superclass : #ERTittledView,
	#category : #'ESUGApp-View'
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
	html heading level6
		with: [ html strong: 'Conference Home Page: '.
			html anchor
				url: controller conference configuration homePageUrl;
				with: controller conference configuration homePageUrl ]
]

{ #category : #rendering }
ERHomeView >> title [
	^ controller conference configuration emailConfiguration
		welcomeText
]
