Class {
	#name : #ERContainerAdminView,
	#superclass : #ERTabsContainerView,
	#category : #'ESUGApp-Components'
}

{ #category : #initialization }
ERContainerAdminView >> initializeTabForms [
	self addTab: (ERAdminUser on: attendee withContent: content).
	self addTab: (ERAdminChangePassword on: attendee withContent: content).
	(self tabs at: 1) activate
]
