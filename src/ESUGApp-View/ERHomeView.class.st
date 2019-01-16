Class {
	#name : #ERHomeView,
	#superclass : #ERTittledView,
	#instVars : [
		'controller'
	],
	#category : #'ESUGApp-View'
}

{ #category : #'as yet unclassified' }
ERHomeView class >> on: anAttendee withContent: aContent withController: aController [
	| form |
	form := self new.
	form attendee: anAttendee.
	form content: aContent.
	form controller: aController.
	^ form
]

{ #category : #accessing }
ERHomeView >> controller: anObject [
	controller := anObject
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
