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

{ #category : #converting }
ERPageLoggedView class >> asAdmin [
]

{ #category : #converting }
ERPageLoggedView class >> asAttendee [
]

{ #category : #converting }
ERPageLoggedView class >> asGroupManager [
	^ self new 
]

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
	(ERContainerHomeView attendee: attendee) content: content.
	self initializeNabvar
]

{ #category : #rendering }
ERPageLoggedView >> initializeNabvar [
	| menu |
	menu := ERMenuFactory availableItemsOfMenu: self itemList.
	self session user isAttendee
		ifTrue: [ navbar := menu createMenuForAttendee ].
	self session user isGroupManager
		ifTrue: [ navbar := menu createMenuForGroupManager ].
	self session user isAdmin
		ifTrue: [ navbar := menu createMenuForAdmin ].
	self session user isStudent 
		ifTrue: [ navbar := menu createMenuForAdmin  ].
	
]

{ #category : #rendering }
ERPageLoggedView >> itemList [
	^ Dictionary new
		at: 'home'
			put: [ (ERContainerHomeView attendee: attendee)
				content: content ];
		at: 'admin'
			put:
				[ ERContainerAdminView attendee: attendee content: content ];
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
			put: [ (ERContainerConfigurationView attendee: attendee)
				content: content ];
		yourself
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
