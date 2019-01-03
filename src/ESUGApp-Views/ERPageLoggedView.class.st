Class {
	#name : #ERPageLoggedView,
	#superclass : #WAComponent,
	#instVars : [
		'pageController',
		'navbar',
		'content',
		'attendee'
	],
	#category : #'ESUGApp-Views'
}

{ #category : #accessing }
ERPageLoggedView >> content [
	^ content
]

{ #category : #accessing }
ERPageLoggedView >> content: anObject [
	content := anObject
]

{ #category : #rendering }
ERPageLoggedView >> initialize [
	super initialize.
	pageController := ERLoggedController new user: self session user.
	attendee := pageController attendeeFromUser.
	content := ERContent new.
	(ERContainerHomeView
				on: attendee
				withContent: content
				withController: pageController).
	self initializeNabvar
]

{ #category : #rendering }
ERPageLoggedView >> initializeNabvar [
	| menu |
	menu := ERMenuFactory availableItemsOfMenu: self itemList.
	navbar := menu createMenuWith: (self listOptionsFor: menu)
]

{ #category : #rendering }
ERPageLoggedView >> itemList [
	^ Dictionary new
		at: 'home'
			put: [ ERContainerHomeView
				on: attendee
				withContent: content
				withController: pageController ];
		at: 'admin'
			put: [ ERContainerAdminView attendee: attendee content: content ];
		at: 'logout'
			put: [ self session logout.
			self answer: true ];
		at: 'groupRegistration'
			put: [ ERContainerGroupRegistrationView
				attendee: attendee
				content: content ];
		at: 'myRegistration'
			put: [ ERContainerMyRegistrationView
				attendee: attendee
				content: content ];
		at: 'configuration'
			put: [ ERContainerConfigurationView
				attendee: attendee
				content: content ];
		yourself
]

{ #category : #rendering }
ERPageLoggedView >> listOptionsFor: aMenuFactory [
	| list |
	list := OrderedCollection new.
	list add: aMenuFactory createHomeItem.
	self session user isAttendee
		ifTrue: [ list add: aMenuFactory createMyRegistrationItem ].
	self session user isGroupManager
		ifTrue: [ list add: aMenuFactory createGroupManagerItem ].
	self session user isAdmin
		ifTrue: [ list add: aMenuFactory createConfigurationItem ].
	self session user isStudent
		ifTrue: [  ].
	list add: aMenuFactory createAdminItem.
	list add: aMenuFactory createLogoutItem .
	^ list
]

{ #category : #accessing }
ERPageLoggedView >> navbar: anObject [
	navbar := anObject
]

{ #category : #accessing }
ERPageLoggedView >> pageController [
	^ pageController
]

{ #category : #rendering }
ERPageLoggedView >> renderContentOn: html [
	html div class: 'demo-layout mdl-layout mdl-js-layout mdl-layout--fixed-drawer mdl-layout--fixed-header'; with: [ 
		html render: navbar .
		html render: content .
		 ]
]
