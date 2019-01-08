Class {
	#name : #ERContainerHomeView,
	#superclass : #ERGeneralContainerView,
	#instVars : [
		'controller'
	],
	#category : #'ESUGApp-Components'
}

{ #category : #'as yet unclassified' }
ERContainerHomeView class >> on: anAttendee withContent: aContent withController: aController [
	| form |
	form := self new.
	form attendee: anAttendee.
	form content: aContent.
	form controller: aController.
	^ form
]

{ #category : #accessing }
ERContainerHomeView >> controller: anObject [
	controller := anObject
]

{ #category : #rendering }
ERContainerHomeView >> renderPageOn: html [
	html heading level6
		with: [ html strong: 'Conference Home Page: '.
			html anchor
				url: '#';
				with: controller conference configuration homePageUrl ]
]

{ #category : #rendering }
ERContainerHomeView >> title [
	^ controller conference configuration emailConfiguration
		welcomeText
]
