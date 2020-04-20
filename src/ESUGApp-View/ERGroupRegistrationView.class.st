"
Description
------------
I am the group registration principal view
"
Class {
	#name : #ERGroupRegistrationView,
	#superclass : #ERContainer,
	#instVars : [
		'tabs'
	],
	#category : #'ESUGApp-View-View'
}

{ #category : #accessing }
ERGroupRegistrationView class >> attendee: anAttendee content: aContent [
	| instance |
	instance := self new.
	instance attendee: anAttendee.
	instance content: aContent .
	instance initializeTabForms.
	^ instance
]

{ #category : #initialization }
ERGroupRegistrationView >> initialize [ 
	super initialize.
	tabs := OrderedCollection new.
]

{ #category : #initialization }
ERGroupRegistrationView >> initializeTabForms [
	tabs add: (ERGroupRegistrationSummaryView 
					on: attendee 
					withContent: content
					container: self);
	add: (ERMembersView 
					on: attendee 
					withContent: content 
					container: self);
	add: (ERMembersRegistrationView 
					on: attendee 
					withContent: content 
					container: self).
	(tabs at: 1) activate
]

{ #category : #rendering }
ERGroupRegistrationView >> renderContentPageOn: html [
	html div
		class: 'mdl-tabs mdl-js-tabs mdl-js-ripple-effect';
		with: [ tabs do: [ :each | html render: each ] ]
]

{ #category : #accessing }
ERGroupRegistrationView >> tabs [
	^ tabs
]
