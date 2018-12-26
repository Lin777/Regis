Class {
	#name : #ERContainerMyRegistrationView,
	#superclass : #ERTabsContainerView,
	#category : #'ESUGApp-Components'
}

{ #category : #initialization }
ERContainerMyRegistrationView >> initializeTabForms [
	self addTab: (ERMyRegistrationSummary on: attendee withContent: content).
	self addTab: (ERProposedTalks on: attendee withContent: content).
	self addTab: (ERProposedAwards on: attendee withContent: content).
	(self tabs at: 1) activate
]
