Class {
	#name : #ERContainerConfigurationView,
	#superclass : #ERTabsContainerView,
	#category : #'ESUGApp-Components'
}

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
