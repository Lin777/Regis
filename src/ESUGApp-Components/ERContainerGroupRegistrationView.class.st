Class {
	#name : #ERContainerGroupRegistrationView,
	#superclass : #ERTabsContainerView,
	#category : #'ESUGApp-Components'
}

{ #category : #rendering }
ERContainerGroupRegistrationView >> initializeTabForms [
	self addTab: ((ERGroupRegistrationSummary on: attendee)content: content ).
	self addTab: ((ERGroupRegistrationMembers on: attendee)content: content).
	(self tabs at: 1) activate
]
