Class {
	#name : #ERMyRegistrationView,
	#superclass : #ERContainer,
	#instVars : [
		'tabs'
	],
	#category : #'ESUGApp-View'
}

{ #category : #accessing }
ERMyRegistrationView class >> attendee: anAttendee content: aContent [
	| instance |
	instance := self new.
	instance attendee: anAttendee.
	instance content: aContent .
	instance initializeTabForms.
	^ instance
]

{ #category : #initialization }
ERMyRegistrationView >> initialize [ 
	super initialize.
	tabs := OrderedCollection new.
]

{ #category : #initialization }
ERMyRegistrationView >> initializeTabForms [
	tabs add: (ERMyRegistrationSummaryTab on: attendee withContent: content);
	add: (ERProposedTalksTab on: attendee withContent: content);
	add: (ERProposedAwardsTab on: attendee withContent: content).
	(tabs at: 1) activate
]

{ #category : #adding }
ERMyRegistrationView >> renderContentPage: html [
	html div
		class: 'mdl-tabs mdl-js-tabs mdl-js-ripple-effect';
		with: [ html render: (ERTabs new tabs: self tabs) ]
]
