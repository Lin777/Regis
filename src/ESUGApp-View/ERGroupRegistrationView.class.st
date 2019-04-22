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
	tabs add: (ERGroupRegistrationSummaryTab 
					on: attendee 
					withContent: content
					container: self);
	add: (ERMembersTab 
					on: attendee 
					withContent: content 
					container: self).
	(tabs at: 1) activate
]

{ #category : #adding }
ERGroupRegistrationView >> renderContentPageOn: html [
	html div
		class: 'mdl-tabs mdl-js-tabs mdl-js-ripple-effect';
		with: [ tabs do: [ :each | html render: each ] ]
]

{ #category : #accessing }
ERGroupRegistrationView >> tabs [
	^ tabs
]
