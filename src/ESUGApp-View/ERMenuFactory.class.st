"
Description
--------------------

I am factory class to create options for menu
"
Class {
	#name : #ERMenuFactory,
	#superclass : #Object,
	#instVars : [
		'availableItemsOfMenu'
	],
	#category : #'ESUGApp-View-Tab'
}

{ #category : #accessing }
ERMenuFactory class >> availableItemsOfMenu: aList [
	|instance|
	instance := self new.
	instance availableItemsOfMenu: aList .
	^ instance 
]

{ #category : #accessing }
ERMenuFactory >> availableItemsOfMenu: anObject [
	availableItemsOfMenu := anObject
]

{ #category : #factory }
ERMenuFactory >> createAdminItem [
	^ ERItemNav 
		label: 'My Account' 
		icon: 'person' 
		callback: (availableItemsOfMenu at: 'admin')
]

{ #category : #factory }
ERMenuFactory >> createConferenceItem [
	^ ERItemNav 
		label: 'Attendees' 
		icon: 'record_voice_over' 
		callback: (availableItemsOfMenu at: 'conference')
]

{ #category : #factory }
ERMenuFactory >> createConfigurationItem [
	^ ERItemNav
		label: 'Configuration'
		icon: 'settings'
		callback: (availableItemsOfMenu at: 'configuration')
]

{ #category : #factory }
ERMenuFactory >> createContactUsItem [
	^ ERItemNav 
		label: 'Help' 
		icon: 'help' 
		callback: (availableItemsOfMenu at: 'contactUs')
]

{ #category : #factory }
ERMenuFactory >> createGroupManagerItem [
	^ ERItemNav 
		label: 'Group Management' 
		icon: 'group' 
		callback: (availableItemsOfMenu at: 'groupRegistration')
]

{ #category : #factory }
ERMenuFactory >> createHomeItem [
	^ ERItemNav 
		label: 'Home' 
		icon: 'home' 
		callback: (availableItemsOfMenu at: 'home')
]

{ #category : #factory }
ERMenuFactory >> createLogoutItem [
	^ ERItemNav 
		label: 'Logout' 
		icon: 'backspace' 
		callback: (availableItemsOfMenu at: 'logout')
]

{ #category : #factory }
ERMenuFactory >> createMenuWith: aList [
	^ ERNav new
		listOptions: aList;
		yourself
]

{ #category : #factory }
ERMenuFactory >> createMyRegistrationItem [
	^ ERItemNav 
		label: 'My Registration' 
		icon: 'assignment' 
		callback: (availableItemsOfMenu at: 'myRegistration')
]

{ #category : #factory }
ERMenuFactory >> createPaymentItem [
	^ ERItemNav 
		label: 'Invoices' 
		icon: 'monetization_on' 
		callback: (availableItemsOfMenu at: 'payment')
]

{ #category : #factory }
ERMenuFactory >> createProposalsItem [
	^ ERItemNav
		label: 'Proposals'
		icon: 'note'
		callback: (availableItemsOfMenu at: 'proposal')
]

{ #category : #factory }
ERMenuFactory >> createStatisticsItem [
	^ ERItemNav
		label: 'Statistics'
		icon: 'show_chart'
		callback: (availableItemsOfMenu at: 'statistics')
]

{ #category : #factory }
ERMenuFactory >> createStudentVolunterSearch [
	^ ERItemNav 
		label: 'Search' 
		icon: 'search' 
		callback: (availableItemsOfMenu at: 'search')
]

{ #category : #factory }
ERMenuFactory >> createUsersItem [
	^ ERItemNav
		label: 'Users'
		icon: 'group'
		callback: (availableItemsOfMenu at: 'users')
]
