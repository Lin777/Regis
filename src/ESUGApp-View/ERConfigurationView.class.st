Class {
	#name : #ERConfigurationView,
	#superclass : #ERContainer,
	#instVars : [
		'tabs'
	],
	#category : #'ESUGApp-View'
}

{ #category : #accessing }
ERConfigurationView class >> attendee: anAttendee content: aContent [
	| instance |
	instance := self new.
	instance attendee: anAttendee.
	instance content: aContent .
	instance initializeTabForms.
	^ instance
]

{ #category : #initialization }
ERConfigurationView >> initialize [
	super initialize.
	tabs := OrderedCollection new.
]

{ #category : #initialization }
ERConfigurationView >> initializeTabForms [
	tabs add: (ERConferenceForm on: attendee withContent: content container: self);
	add: (ERFeeForm on: attendee withContent: content container: self);
	add: (ERReductionTicketsTab on: attendee withContent: content container: self);
	add: (ERUsersTab on: attendee withContent: content container: self);
	add: (ERAttendeesTab on: attendee withContent: content container: self);
	add: (ERGroupManagersTab on: attendee withContent: content container: self);
	add: (ERInvoicesTab on: attendee withContent: content container: self);
	add: (ERTalksTab on: attendee withContent: content container: self);
	add: (ERAwardsTab on: attendee withContent: content container: self);
	add: (ERStatisticsTab on: attendee withContent: content container: self).
	(tabs at: 1) activate
]

{ #category : #adding }
ERConfigurationView >> renderContentPage: html [
	html div
		class: 'mdl-tabs mdl-js-tabs mdl-js-ripple-effect';
		with: [ html render: (ERTabs new tabs: tabs) ]
]

{ #category : #accessing }
ERConfigurationView >> tabs [
	^ tabs
]
