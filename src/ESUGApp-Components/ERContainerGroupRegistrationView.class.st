Class {
	#name : #ERContainerGroupRegistrationView,
	#superclass : #ERTabsContainerView,
	#category : #'ESUGApp-Components'
}

{ #category : #rendering }
ERContainerGroupRegistrationView >> initializeTabForms [
	self
		addTab: (ERGroupRegistrationSummary on: attendee withContent: content).
	self
		addTab: (ERGroupRegistrationMembers on: attendee withContent: content).
	(self tabs at: 1) activate
]
