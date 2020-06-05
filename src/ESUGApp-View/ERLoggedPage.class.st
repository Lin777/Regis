"
Description
--------------------

I am a principal component when user is logged.

Instance Variables
--------------------

pageController: 	 an ERController or ERController subclasses of the page
navbar:            <aComponent> ERNav component
content:
attendee:
configurationTabs: an OrderedCollection with tabs components for configuration option
proposalTabs:      an OrderedCollection with tabs components for proposals option
usersTabs:         an OrderedCollection with tabs components for users option
"
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
		'usersTabs',
		'conferenceTabs',
		'paymentTabs'
	],
	#category : #'ESUGApp-View-Page'
}

{ #category : #hooks }
ERLoggedPage >> children [ 
	^ Array with: navbar with: content
]

{ #category : #accessing }
ERLoggedPage >> conferenceTabs [
	"Return all conference tabs"

	conferenceTabs ifNil: [
		conferenceTabs := OrderedCollection new
			add: (ERAttendeesTab on: attendee withContent: content container: self);
			yourself.
			(conferenceTabs at: 1) activate ].
	^ conferenceTabs
]

{ #category : #accessing }
ERLoggedPage >> configurationTabs [ 
	configurationTabs ifNil: [
		configurationTabs := OrderedCollection new
			add: (ERConferenceForm on: attendee withContent: content container: self);
			add: (ERFeeForm on: attendee withContent: content container: self);
			add: (ERReductionTicketsTab on: attendee withContent: content container: self);
			add: (ERConferenceOnlineTab on: attendee withContent: content container: self);
			add: (ERBackupTab on: attendee withContent: content container: self);
			yourself.
	(configurationTabs at: 1) activate ].
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

{ #category : #initialization }
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

{ #category : #initialization }
ERLoggedPage >> initializeNabvar [
	| menu |
	menu := ERMenuFactory availableItemsOfMenu: self itemList.
	navbar := menu createMenuWith: (self listOptionsFor: menu)
]

{ #category : #initialization }
ERLoggedPage >> itemList [
	^ Dictionary new
		at: 'home'
			put: [ ERHomeView
				withContent: content
				withController: pageController ];
		at: 'contactUs'
			put: [ ERContactUsView
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
				attendee: (pageController conference attendeeFromUser: self session user)
				content: content ];
		at: 'conference'
			put: [ ERTabsOfView
				content: content
				tabs: self conferenceTabs ];
		at: 'payment'
			put: [ ERTabsOfView
				content: content
				tabs: self paymentTabs ];
		at: 'configuration'
			put: [ ERTabsOfView
				content: content
				tabs: self configurationTabs ];
		at: 'proposal'
			put: [ ERTabsOfView
				content: content
				tabs: self proposalTabs ];
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

{ #category : #accessing }
ERLoggedPage >> listOptionsFor: aMenuFactory [
	| list |
	list := OrderedCollection new.
	list add: aMenuFactory createHomeItem.
	list add: aMenuFactory createAdminItem.
	self session user isAttendee
		ifTrue: [ list add: aMenuFactory createMyRegistrationItem ].
	self session user isGroupManager
		ifTrue: [ list add: aMenuFactory createGroupManagerItem ].
	self session user isAdmin
		ifTrue: [ 
			list add: aMenuFactory createConfigurationItem.
			list add: aMenuFactory createUsersItem.
			list add: aMenuFactory createConferenceItem.
			list add: aMenuFactory createPaymentItem.
			list add: aMenuFactory createProposalsItem.
			list add: aMenuFactory createStatisticsItem. ].
	self session user isStudent
		ifTrue: [ list add: aMenuFactory createStudentVolunterSearch ].
	list add: aMenuFactory createContactUsItem.
	list add: aMenuFactory createLogoutItem.
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

{ #category : #accessing }
ERLoggedPage >> paymentTabs [ 
	paymentTabs ifNil: [
		paymentTabs := OrderedCollection new
			add: (ERInvoices on: attendee withContent: content container: self); yourself.
	(paymentTabs at: 1) activate ].
	^ paymentTabs
]

{ #category : #accessing }
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
		usersTabs := OrderedCollection new 
		add: (ERUsersTab on: attendee withContent: content container: self);
		add: (ERGroupTab on: attendee withContent: content container: self); yourself.
	(usersTabs at: 1) activate].
	^ usersTabs
]
