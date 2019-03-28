Class {
	#name : #ERLoggedPage,
	#superclass : #WAComponent,
	#instVars : [
		'pageController',
		'navbar',
		'content',
		'attendee',
		'configurationTabs',
		'proposalTabs',
		'usersTabs'
	],
	#category : #'ESUGApp-View-Page'
}

{ #category : #hooks }
ERLoggedPage >> children [ 
	^ Array with: navbar with: content
]

{ #category : #rendering }
ERLoggedPage >> configurationTabs [ 
	configurationTabs ifNil: [
		configurationTabs := OrderedCollection new add: (ERConferenceForm on: attendee withContent: content container: self);
	add: (ERFeeForm on: attendee withContent: content container: self);
	add: (ERReductionTicketsTab on: attendee withContent: content container: self);
	add: (ERInvoicesTab on: attendee withContent: content container: self); yourself.
	(configurationTabs at: 1) activate].
	^ configurationTabs
]

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
	pageController := ERLoggedController user: self session user.
	attendee := pageController attendeeFromUser.
	content := ERContent new.
	(ERHomeView
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
				withContent: content
				withController: pageController ];
		at: 'admin'
			put: [ ERAdminView
				on: self session user
				withContent: content
				withController: pageController ];
		at: 'logout'
			put: [ self session logout.
    ^ self requestContext redirectTo: self application url ];
		at: 'groupRegistration'
			put: [ ERGroupRegistrationView
				attendee: self session user
				content: content ];
		at: 'myRegistration'
			put: [ ERMyRegistrationView
				attendee: (pageController conference attendeeFromUser: self session user )
				content: content ];
		at: 'configuration'
			put: [ ERTabsOfView
				content: content
				tabs: self configurationTabs ];
		at: 'proposal'
			put: [ ERTabsOfView
				content: content
				tabs: self proposalTabs];
		at: 'users'
			put: [ ERTabsOfView
				content: content
				tabs: self usersTabs ];
		at: 'statistics'
			put: [ ERStatisticsView
				withContent: content ];
		at: 'search'
			put: [ ERStudentVolunterView withContent: content ];
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
		ifTrue: [ list add: aMenuFactory createConfigurationItem.
			list add: aMenuFactory createUsersItem .
			list add: aMenuFactory createProposalsItem.
			list add: aMenuFactory createStatisticsItem ].
	self session user isStudent
		ifTrue: [ list add: aMenuFactory createStudentVolunterSearch ].
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
ERLoggedPage >> proposalTabs [ 
	proposalTabs ifNil: [
		proposalTabs := OrderedCollection new add: (ERTalksTab on: attendee withContent: content container: self);
	add: (ERAwardsTab on: attendee withContent: content container: self); yourself.
	(proposalTabs at: 1) activate].
	^ proposalTabs
]

{ #category : #rendering }
ERLoggedPage >> renderContentOn: html [
	self initializeNabvar.
	html mdlLayout
		fixedDrawer;
		fixedHeader;
		class: 'demo-layout';
		with: [ 
			html render: navbar .
			html render: content .
		 ]
]

{ #category : #hooks }
ERLoggedPage >> states [
    ^ Array with: self
]

{ #category : #rendering }
ERLoggedPage >> usersTabs [ 
	usersTabs ifNil: [
		usersTabs := OrderedCollection new add: (ERUsersTab on: attendee withContent: content container: self);
	add: (ERAttendeesTab on: attendee withContent: content container: self);
	add: (ERGroupManagersTab on: attendee withContent: content container: self); yourself.
	(usersTabs at: 1) activate].
	^ usersTabs
]
