Class {
	#name : #ERContainerAdminView,
	#superclass : #ERTabsContainerView,
	#category : #'ESUGApp-Components'
}

{ #category : #initialization }
ERContainerAdminView >> initializeTabForms [
	self
		addTab: (ERTabAdminUser on: attendee).
	self
		addTab: (ERTabAdminChangePassword on: attendee).
	(self tabs at: 1) activate
]
