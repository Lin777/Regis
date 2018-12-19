Class {
	#name : #ERTabsContainerView,
	#superclass : #ERContainerView,
	#instVars : [
		'tabs'
	],
	#category : #'ESUGApp-Components'
}

{ #category : #accessing }
ERTabsContainerView class >> attendee: anAttendee [
	| instance |
	instance := self new.
	instance attendee: anAttendee.
	instance initializeTabForms.
	^ instance
]

{ #category : #accessing }
ERTabsContainerView class >> attendee: anAttendee content: aContent [
	| instance |
	instance := self new.
	instance attendee: anAttendee.
	instance content: aContent .
	instance initializeTabForms.
	^ instance
]

{ #category : #adding }
ERTabsContainerView >> addTab: aAttendeeTabForm [
	self tabs add: aAttendeeTabForm
	
]

{ #category : #adding }
ERTabsContainerView >> initializeTabForms [
	self subclassResponsibility
]

{ #category : #adding }
ERTabsContainerView >> renderContentPage: html [
	html div
		class: 'mdl-tabs mdl-js-tabs mdl-js-ripple-effect';
		with: [ html render: (ERTabsView new tabs: self tabs) ]
]

{ #category : #adding }
ERTabsContainerView >> tabs [
	tabs ifNil: [ tabs := OrderedCollection new ].
	^ tabs
]
