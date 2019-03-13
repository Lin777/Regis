Class {
	#name : #ERMenuPage,
	#superclass : #Object,
	#instVars : [
		'availableItemsOfMenu'
	],
	#category : #'ESUGApp-View'
}

{ #category : #accessing }
ERMenuPage class >> availableItemsOfMenu: aList [
	|instance|
	instance := self new.
	instance availableItemsOfMenu: aList .
	^ instance 
]

{ #category : #accessing }
ERMenuPage >> availableItemsOfMenu: anObject [
	availableItemsOfMenu := anObject
]

{ #category : #'as yet unclassified' }
ERMenuPage >> createAdminItem [
	^ ERItemNav label: 'Admin' icon: 'person' callback: (availableItemsOfMenu at: 'admin')
]

{ #category : #'as yet unclassified' }
ERMenuPage >> createConfigurationItem [
	^ ERItemNav
		label: 'Configuration'
		icon: 'settings'
		callback: (availableItemsOfMenu at: 'configuration')
]

{ #category : #'as yet unclassified' }
ERMenuPage >> createGroupManagerItem [
	^ ERItemNav label: 'Group Registration' icon: 'group' callback: (availableItemsOfMenu at: 'groupRegistration')
]

{ #category : #'as yet unclassified' }
ERMenuPage >> createHomeItem [
	^ ERItemNav label: 'Home' icon: 'home' callback: (availableItemsOfMenu at: 'home')
]

{ #category : #'as yet unclassified' }
ERMenuPage >> createLogoutItem [
	^ ERItemNav label: 'Logout' icon: 'backspace' callback: (availableItemsOfMenu at: 'logout')
]

{ #category : #'as yet unclassified' }
ERMenuPage >> createMenuWith: aList [
	^ ERNav new
		listOptions: aList;
		yourself
]

{ #category : #'as yet unclassified' }
ERMenuPage >> createMyRegistrationItem [
	^ ERItemNav label: 'My Registration' icon: 'assignment' callback: (availableItemsOfMenu at: 'myRegistration')
]

{ #category : #'as yet unclassified' }
ERMenuPage >> createProposalsItem [
	^ ERItemNav
		label: 'Proposals'
		icon: 'note'
		callback: (availableItemsOfMenu at: 'proposal')
]

{ #category : #'as yet unclassified' }
ERMenuPage >> createStatisticsItem [
	^ ERItemNav
		label: 'Statistics'
		icon: 'show_chart'
		callback: (availableItemsOfMenu at: 'statistics')
]

{ #category : #'as yet unclassified' }
ERMenuPage >> createUsersItem [
	^ ERItemNav
		label: 'Users'
		icon: 'group'
		callback: (availableItemsOfMenu at: 'users')
]

{ #category : #initialization }
ERMenuPage >> initialize [
	super initialize.
	
]
