Class {
	#name : #ERLoggedPage,
	#superclass : #WAComponent,
	#instVars : [
		'pageController',
		'navbar',
		'content',
		'attendee'
	],
	#category : #'ESUGApp-View-Page'
}

{ #category : #accessing }
ERLoggedPage >> content [
	^ content
]

{ #category : #accessing }
ERLoggedPage >> content: anObject [
	content := anObject
]

{ #category : #rendering }
ERLoggedPage >> initialize [
	super initialize.
	pageController := ERLoggedController new user: self session user.
	attendee := pageController attendeeFromUser.
	content := ERContent new.
	(ERHomeView
				on: attendee
				withContent: content
				withController: pageController).
	self initializeNabvar.
]

{ #category : #rendering }
ERLoggedPage >> initializeNabvar [
	| menu |
	menu := ERMenuPage availableItemsOfMenu: self itemList.
	navbar := menu createMenuWith: (self listOptionsFor: menu)
]

{ #category : #rendering }
ERLoggedPage >> itemList [
	^ Dictionary new
		at: 'home'
			put: [ ERHomeView
				on: attendee
				withContent: content
				withController: pageController ];
		at: 'admin'
			put: [ ERAdminView
				on: attendee
				withContent: content
				withController: pageController ];
		at: 'logout'
			put: [ self session logout.
			self requestContext redirectTo: 'http://localhost:8000/ESUG' ];
		at: 'groupRegistration'
			put: [ ERGroupRegistrationView
				attendee: attendee
				content: content ];
		at: 'myRegistration'
			put: [ ERMyRegistrationView
				attendee: attendee
				content: content ];
		at: 'configuration'
			put: [ ERConfigurationView
				attendee: attendee
				content: content ];
		yourself
]

{ #category : #rendering }
ERLoggedPage >> listOptionsFor: aMenuFactory [
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
ERLoggedPage >> navbar: anObject [
	navbar := anObject
]

{ #category : #accessing }
ERLoggedPage >> pageController [
	^ pageController
]

{ #category : #rendering }
ERLoggedPage >> renderContentOn: html [
	html div class: 'demo-layout mdl-layout mdl-js-layout mdl-layout--fixed-drawer mdl-layout--fixed-header'; with: [ 
		html render: navbar .
		html render: content .
		 ]
]

{ #category : #hooks }
ERLoggedPage >> states [
    ^ Array with: self
]
