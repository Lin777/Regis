Class {
	#name : #ERMenuPage,
	#superclass : #Object,
	#instVars : [
		'availableItemsOfMenu'
	],
	#category : #'ESUGApp-View-Tab'
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

{ #category : #factory }
ERMenuPage >> createAdminItem [
	^ ERItemNav 
		label: 'Account' 
		icon: 'person' 
		callback: (availableItemsOfMenu at: 'admin')
]

{ #category : #factory }
ERMenuPage >> createConfigurationItem [
	^ ERItemNav
		label: 'Configuration'
		icon: 'settings'
		callback: (availableItemsOfMenu at: 'configuration')
]

{ #category : #factory }
ERMenuPage >> createGroupManagerItem [
	^ ERItemNav 
		label: 'Group Registration' 
		icon: 'group' 
		callback: (availableItemsOfMenu at: 'groupRegistration')
]

{ #category : #factory }
ERMenuPage >> createHomeItem [
	^ ERItemNav 
		label: 'Home' 
		icon: 'home' 
		callback: (availableItemsOfMenu at: 'home')
]

{ #category : #factory }
ERMenuPage >> createLogoutItem [
	^ ERItemNav 
		label: 'Logout' 
		icon: 'backspace' 
		callback: (availableItemsOfMenu at: 'logout')
]

{ #category : #factory }
ERMenuPage >> createMenuWith: aList [
	^ ERNav new
		listOptions: aList;
		yourself
]

{ #category : #factory }
ERMenuPage >> createMyRegistrationItem [
	^ ERItemNav 
		label: 'My Registration' 
		icon: 'assignment' 
		callback: (availableItemsOfMenu at: 'myRegistration')
]

{ #category : #factory }
ERMenuPage >> createProposalsItem [
	^ ERItemNav
		label: 'Proposals'
		icon: 'note'
		callback: (availableItemsOfMenu at: 'proposal')
]

{ #category : #factory }
ERMenuPage >> createStatisticsItem [
	^ ERItemNav
		label: 'Statistics'
		icon: 'show_chart'
		callback: (availableItemsOfMenu at: 'statistics')
]

{ #category : #factory }
ERMenuPage >> createStudentVolunterSearch [
	^ ERItemNav 
		label: 'Search' 
		icon: 'search' 
		callback: (availableItemsOfMenu at: 'search')
]

{ #category : #factory }
ERMenuPage >> createUsersItem [
	^ ERItemNav
		label: 'Users'
		icon: 'group'
		callback: (availableItemsOfMenu at: 'users')
]
