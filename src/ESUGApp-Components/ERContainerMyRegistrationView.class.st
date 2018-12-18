Class {
	#name : #ERContainerMyRegistrationView,
	#superclass : #ERTabsContainerView,
	#category : #'ESUGApp-Components'
}

{ #category : #initialization }
ERContainerMyRegistrationView >> initializeTabForms [
	self
		addTab: (ERMyRegistrationSummary on: attendee).
	self
		addTab: (ERProposedTalks on: attendee).
	self
		addTab: (ERProposedAwards on: attendee).
	(self tabs at: 1) activate
]
