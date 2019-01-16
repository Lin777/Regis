Class {
	#name : #ERGroupRegistrationView,
	#superclass : #ERContainer,
	#instVars : [
		'tabs'
	],
	#category : #'ESUGApp-View'
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

{ #category : #rendering }
ERGroupRegistrationView >> initializeTabForms [
	tabs add: (ERGroupRegistrationSummaryTab on: attendee withContent: content container: self);
	add: (ERMembersTab on: attendee withContent: content container: self).
	(tabs at: 1) activate
]

{ #category : #adding }
ERGroupRegistrationView >> renderContentPage: html [
	html div
		class: 'mdl-tabs mdl-js-tabs mdl-js-ripple-effect';
		with: [ html render: (ERTabs new tabs: tabs) ]
]

{ #category : #accessing }
ERGroupRegistrationView >> tabs [
	^ tabs
]
