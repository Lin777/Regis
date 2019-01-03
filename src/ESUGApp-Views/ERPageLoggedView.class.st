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

{ #category : #converting }
ERPageLoggedView class >> initialize [
	|email organizer conferenceConfiguration conference|

	super initialize.
email := ERConferenceEmailConfiguration new 
senderEmailAddress: 'registration@esug.org';
		smptServerAddress: 'localhost';
		smptClient: 'PatSmtpToPostMarkClientAdapter';
		welcomeText: 'Welcome to this great conference'; save.
organizer := ERConferenceOrganizer new 
		name: 'ESUG 2018' ;
		fisicalSituation: 'Association Loi 1901 n°W751167780 (not subjected to  V.A.T.)';
		webPageUrl: 'http://www.esug.org';
		addressString: 'c/o Mr. Stéphane Ducasse - 1 rue Cesar Franck 59800 Lille - France'; save.
	conferenceConfiguration := ERConferenceConfigurationModel new name: 'ESUG'; description: 'ESUG International Smalltalk Conference'; homePageUrl: 'http://www.esug.org/wiki/pier/Conferences/2018/'; earlyRegistrationDeadline: '01/01/2018';
	dateSubmissionDeadline: '01/01/2018';
	emailConfiguration: email ; organizer: organizer; save.
	conference := ERConference new configuration: conferenceConfiguration; save

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
	navbar := menu createMenuWith: (self listOptionsFor: menu).
]

{ #category : #rendering }
ERPageLoggedView >> itemList [
	^ Dictionary new
		at: 'home'
			put: [(ERContainerHomeView attendee: attendee) content: content.
			];
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
			put: [ ERContainerConfigurationView attendee: attendee
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
