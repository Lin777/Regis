Class {
	#name : #ERPageLoggedView,
	#superclass : #WAComponent,
	#instVars : [
		'pageController',
		'navbar',
		'content'
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
ERPageLoggedView >> content: anObject [
	content := anObject
]

{ #category : #hooks }
ERPageLoggedView >> forChildenFuture [
"children
	Array with: navbar; with: content "
]

{ #category : #rendering }
ERPageLoggedView >> initialize [
	super initialize.
	pageController := ERLoggedController new user: (self session user).
	content := ERContainerHomeView attendee: pageController getAttendee .
	self initializeNabvar.
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
	| anAttendee |
	anAttendee := pageController getAttendee.
	^ Dictionary new
		at: 'home'
			put: [ self
				content: ((ERContainerHomeView attendee: anAttendee) content: content) ];
		at: 'admin'
			put: [ self
				content:
					((ERContainerAdminView attendee: anAttendee) content: content) ];
		at: 'logout'
			put: [ self session logout.
			self answer: true ];
		at: 'groupRegistration'
			put: [ self
				content:
					((ERContainerGroupRegistrationView attendee: anAttendee)
						content: content) ];
		at: 'myRegistration'
			put: [ self
				content: ((ERContainerMyRegistrationView attendee: anAttendee)content: content ) ];
		at: 'configuration'
			put: [ self content: ((ERContainerHomeView attendee: anAttendee) content: content )];
		yourself
]

{ #category : #accessing }
ERPageLoggedView >> navbar: anObject [
	navbar := anObject
]

{ #category : #rendering }
ERPageLoggedView >> renderContentOn: html [
	html div class: 'demo-layout mdl-layout mdl-js-layout mdl-layout--fixed-drawer mdl-layout--fixed-header'; with: [ 
		html render: navbar .
		html render: content .
		 ]
]
