Class {
	#name : #ERMenuFactory,
	#superclass : #Object,
	#instVars : [
		'availableItemsOfMenu'
	],
	#category : #'ESUGApp-Views'
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

{ #category : #'as yet unclassified' }
ERMenuFactory >> createAdminItem [
	^ ERItemNav label: 'Admin' icon: 'person' callback: (availableItemsOfMenu at: 'admin')
]

{ #category : #'as yet unclassified' }
ERMenuFactory >> createConfigurationItem [
	^ ERItemNav label: 'Configuration' icon: 'home' callback: (availableItemsOfMenu at: 'configuration')
]

{ #category : #'as yet unclassified' }
ERMenuFactory >> createGroupManagerItem [
	^ ERItemNav label: 'Group Registration' icon: 'group' callback: (availableItemsOfMenu at: 'groupRegistration')
]

{ #category : #'as yet unclassified' }
ERMenuFactory >> createHomeItem [
	^ ERItemNav label: 'Home' icon: 'home' callback: (availableItemsOfMenu at: 'home')
]

{ #category : #'as yet unclassified' }
ERMenuFactory >> createLogoutItem [
	^ ERItemNav label: 'Logout' icon: 'backspace' callback: (availableItemsOfMenu at: 'logout')
]

{ #category : #'as yet unclassified' }
ERMenuFactory >> createMenuForAdmin [
	^ ERNavView new
		listOptions:
			(OrderedCollection new
				add: self createHomeItem;
				add: self createConfigurationItem ;
				add: self createAdminItem;
				add: self createLogoutItem;
				yourself);
		yourself
]

{ #category : #'as yet unclassified' }
ERMenuFactory >> createMenuForAttendee [
	^ ERNavView new
		listOptions:
			(OrderedCollection new
				add: self createHomeItem;
				add: self createMyRegistrationItem;
				add: self createAdminItem;
				add: self createLogoutItem;
				yourself);
		yourself
]

{ #category : #'as yet unclassified' }
ERMenuFactory >> createMenuForGroupManager [
	^ ERNavView new
		listOptions:
			(OrderedCollection new
				add: self createHomeItem;
				add: self createGroupManagerItem;
				add: self createAdminItem;
				add: self createLogoutItem;
				yourself); yourself
]

{ #category : #'as yet unclassified' }
ERMenuFactory >> createMyRegistrationItem [
	^ ERItemNav label: 'My Registration' icon: 'assignment' callback: (availableItemsOfMenu at: 'myRegistration')
]

{ #category : #initialization }
ERMenuFactory >> initialize [
	super initialize.
	
]
