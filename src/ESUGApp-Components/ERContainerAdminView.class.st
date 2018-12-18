Class {
	#name : #ERContainerAdminView,
	#superclass : #ERTabsContainerView,
	#category : #'ESUGApp-Components'
}

{ #category : #initialization }
ERContainerAdminView >> initializeTabForms [
	self
		addTab: (ERAdminUser on: attendee).
	self
		addTab: (ERAdminChangePassword on: attendee).
	(self tabs at: 1) activate
]
