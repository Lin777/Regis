Class {
	#name : #ERMyRegistrationView,
	#superclass : #ERContainer,
	#instVars : [
		'tabs',
		'tabsComponent'
	],
	#category : #'ESUGApp-View-View'
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

{ #category : #accessing }
ERMyRegistrationView >> children [ 	
	^ Array with: tabsComponent 
]

{ #category : #initialization }
ERMyRegistrationView >> initialize [ 
	super initialize.
	tabs := OrderedCollection new.
]

{ #category : #initialization }
ERMyRegistrationView >> initializeTabForms [

	(attendee idGroup)
		ifNil: [ tabs add: (ERMyRegistrationSummaryTab on: attendee withContent: content container: self) ].
	tabs add: (ERProposedTalksTab on: attendee withContent: content container: self);
		add: (ERProposedAwardsTab on: attendee withContent: content container: self).
	(tabs at: 1) activate
]

{ #category : #rendering }
ERMyRegistrationView >> renderContentPageOn: html [
	
	tabsComponent := (ERTabs new tabs: tabs).
	html div
		class: 'mdl-tabs mdl-js-tabs mdl-js-ripple-effect';
		with: [ html render: tabsComponent  ]
]

{ #category : #accessing }
ERMyRegistrationView >> tabs [
	^ tabs
]
