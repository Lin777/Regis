Class {
	#name : #ERContainerConfigurationView,
	#superclass : #ERTabsContainerView,
	#instVars : [
		'conference'
	],
	#category : #'ESUGApp-Components'
}

{ #category : #accessing }
ERContainerConfigurationView >> conference [
	^ conference
]

{ #category : #accessing }
ERContainerConfigurationView >> conference: anObject [
	conference := anObject
]

{ #category : #initialization }
ERContainerConfigurationView >> initialize [
	super initialize.
	conference := ERConferenceConfigurationModel
		find: [ :each | each name1 = 'ESUG 2018' ]
]

{ #category : #initialization }
ERContainerConfigurationView >> initializeTabForms [
	self
		addTab: (ERConferenceConfiguration on: attendee withContent: content).
	self addTab: (ERFees on: attendee withContent: content).
	self addTab: (ERReductionTickets on: attendee withContent: content).
	self addTab: (ERAllUsers on: attendee withContent: content).
	self addTab: (ERAttendeeList on: attendee withContent: content).
	self addTab: (ERGroupManagerList on: attendee withContent: content).
	self addTab: (ERTalkList on: attendee withContent: content).
	self addTab: (ERAwardList on: attendee withContent: content).
	self addTab: (ERStatistics on: attendee withContent: content).
	(self tabs at: 1) activate
]
