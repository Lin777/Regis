Class {
	#name : #ERContainerGroupRegistrationView,
	#superclass : #ERTabsContainerView,
	#category : #'ESUGApp-Components'
}

{ #category : #rendering }
ERContainerGroupRegistrationView >> initializeTabForms [
	self
		addTab: (ERTabGroupRegistrationSummary on: attendee).
	self
		addTab: (ERTabGroupRegistrationMembers on: attendee).
	(self tabs at: 1) activate
]
