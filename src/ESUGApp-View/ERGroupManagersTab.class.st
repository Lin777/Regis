Class {
	#name : #ERGroupManagersTab,
	#superclass : #ERConfigurationTab,
	#instVars : [
		'groupManagerForm'
	],
	#category : #'ESUGApp-View-Tab'
}

{ #category : #rendering }
ERGroupManagersTab >> alreadyRegisteredAsGroupManager [
	^ self session user isGroupManager
]

{ #category : #rendering }
ERGroupManagersTab >> blockTableToExecute [
	^ [ :group | 
	OrderedCollection new
		add: ([ :att | att groupManager userAccount firstName ] value: group);
		add: ([ :att | att groupManager userAccount email ] value: group);
		add: ([ :att | att groupManager affiliationInformation organizationName ] value: group);
		add:
			([ :att | (controller amountOfPayToGroup: att listAttends) asString ]
				value: group);
		add: ([ :att | att paymentInformation hasPaid ifTrue: [ 'Yes' ] ifFalse: [ 'No' ] ] value: group);
		yourself ]
]

{ #category : #rendering }
ERGroupManagersTab >> exportGroups [
	controller exportGroupManagers: 'groupManagers'.
	self updateStateTab: self tabName
]

{ #category : #accessing }
ERGroupManagersTab >> groups [
	^ controller groups
]

{ #category : #accessing }
ERGroupManagersTab >> headers [
	^ #('Name' 'Email' 'Organization' 'Remaing Fee' 'Have all Pay?' '')
]

{ #category : #accessing }
ERGroupManagersTab >> initializeFormRegister [
	newAttendee := ERAttendee new.
	formRegister := ERContainerTabs
		formRegisterOn: newAttendee
		withCallback: callback
		content: content
]

{ #category : #accessing }
ERGroupManagersTab >> initializeFormRegisterAdminToGroupManager [
	groupManagerForm := ERContainerTabs
		formAdminToGMRegisterOn: attendee
		withCallback: callback
		content: content.
	content state: groupManagerForm
]

{ #category : #accessing }
ERGroupManagersTab >> initializeFormRegisterForGroupManager: anAttendee [
	groupManagerForm := ERContainerTabs
		formGMRegisterOn: anAttendee
		withCallback: [ self registerGM  ]
		content: content.
	content state: groupManagerForm
]

{ #category : #accessing }
ERGroupManagersTab >> initializeFormRegisterModifyAffiliationGroupManager: aGroupManager [
	groupManagerForm := ERContainerTabs
		formAdminToGMRegisterOn: aGroupManager
		withCallback: [ self registerAdminAsGroupManager ]
		content: content.
	content state: groupManagerForm
]

{ #category : #rendering }
ERGroupManagersTab >> listDataToRenderButton [
	^ OrderedCollection new
		add:
			(Array
				with: 'Modify'
				with: [ :user | self modifyAffiliationGroupManager: user ]
				with: [ :user | user id , '-modify' ]);
		add:
			(Array
				with: 'Delete'
				with: [ :user | self deleteAttendeeFromGroup: user ]
				with: [ :user | user id , '-delete' ]);
		add:
			(Array
				with: 'Modify User'
				with: [ :user | self modifyUserFormGroup: user groupManager ]
				with: [ :user | user id , '-modifyUser' ]);
		add:
			(Array
				with: 'Reset Password'
				with: [ nil ]
				with: [ :user | user id , '-resetPassword' ]);
		add:
			(Array
				with: 'Invoice'
				with: [ nil ]
				with: [ :user | user id , '-invoice' ]);
		yourself
]

{ #category : #rendering }
ERGroupManagersTab >> modifyAffiliationGroupManager: aGroupManager [
	self
		initializeFormRegisterModifyAffiliationGroupManager: aGroupManager groupManager 
]

{ #category : #'as yet unclassified' }
ERGroupManagersTab >> registerAdminAsGroupManager [
	|groupManager|
	(ERRegistrationController attendee: attendee)
		validateRegisterForGroupManager.
	groupManager := controller registerAsGroupManager.
	(ERGroupManagerController new attendee: groupManager)
				groupForGroupManager.
	content state: content lastState
]

{ #category : #accessing }
ERGroupManagersTab >> registerGM [
	(ERRegistrationController attendee: newAttendee)
		validateRegisterForGroupManager;
		saveAsGroupManager.
	content state: content lastState
]

{ #category : #rendering }
ERGroupManagersTab >> registerGroupManager [
	newAttendee := ERAttendee1 new.
	self initializeFormRegisterForGroupManager: newAttendee.
	self updateStateTab: self tabName. 
]

{ #category : #rendering }
ERGroupManagersTab >> registerMyselfAsGroupManager [
	attendee userAccount isGroupManager
		ifFalse: [ callback := [ self registerAdminAsGroupManager ].

			self initializeFormRegisterAdminToGroupManager ]
		ifTrue: [  ].
	self updateStateTab: self tabName
]

{ #category : #rendering }
ERGroupManagersTab >> renderButtons: html [
	self
		createColoredAnchorButton: 'REGISTER GROUP MANAGER'
		with: [ self registerGroupManager ]
		id: 'registerGroupManager'
		on: html.
	self alreadyRegisteredAsGroupManager ifFalse: [
	self
		createColoredAnchorButton: 'REGISTER MYSELF AS GROUP MANAGER'
		with: [ self registerMyselfAsGroupManager ]
		id: 'registerMyselfAsGroupManager'
		on: html].
	self
		createColoredAnchorButton: 'Export'
		with: [ self exportGroups ]
		id: 'exportGroups'
		on: html
]

{ #category : #rendering }
ERGroupManagersTab >> renderContainer: html [
	html form
		method: 'post';
		id: 'formAllGroups';
		with: [
	self renderButtons: html.
	html horizontalRule.
	self renderTableOfGroups: html]
]

{ #category : #accessing }
ERGroupManagersTab >> renderTableOfGroups: html [
	| table |
	table := ERTable new
		headers: self headers;
		levelTotal: 6;
		listObject: self groups;
		blockToExecute: self blockTableToExecute;
		listToRenderButton: self listDataToRenderButton.
	html render: table
]

{ #category : #accessing }
ERGroupManagersTab >> tabId [
	^ 'groupManagerList'
]

{ #category : #accessing }
ERGroupManagersTab >> tabName [
	^ 'Group Manager'
]

{ #category : #accessing }
ERGroupManagersTab >> title [
	^ 'Group Manager'
]
