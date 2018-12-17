Class {
	#name : #ERContainerMyRegistrationView,
	#superclass : #ERTabsContainerView,
	#category : #'ESUGApp-Components'
}

{ #category : #initialization }
ERContainerMyRegistrationView >> initializeTabForms [
	self
		addTab: (ERTabMyRegistrationSummary on: attendee).
	self
		addTab: (ERTabProposedTalks on: attendee).
	self
		addTab: (ERTabProposedAwards on: attendee).
	(self tabs at: 1) activate
]
