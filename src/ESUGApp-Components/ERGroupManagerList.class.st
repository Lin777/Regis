Class {
	#name : #ERGroupManagerList,
	#superclass : #ERConfiguration,
	#category : #'ESUGApp-Components'
}

{ #category : #rendering }
ERGroupManagerList >> alreadyRegisteredAsGroupManager [
	^ attendee userAccount isGroupManager
]

{ #category : #rendering }
ERGroupManagerList >> blockTableToExecute [
	^ [ :group | 
	OrderedCollection new
		add: ([ :att | att groupManager firstName ] value: group);
		add: ([ :att | att groupManager email ] value: group);
		add: ([ :att | att groupManager orgName ] value: group);
		add: '660.00 Euros';
		add: 'No';
		yourself ]
]

{ #category : #rendering }
ERGroupManagerList >> exportGroups [
	(self fileExists: 'groupManagers.cvs')
		ifFalse: [ controller exportGroupManagers ]
		ifTrue: [ Transcript show: 'File Exist' ]
]

{ #category : #accessing }
ERGroupManagerList >> groups [
	^ controller groups
]

{ #category : #accessing }
ERGroupManagerList >> headers [
	^ #('Name' 'Email' 'Organization' 'Remaing Fee' 'Have all Pay?' '')
]

{ #category : #rendering }
ERGroupManagerList >> listDataToRenderButton [
	^ OrderedCollection new
		add:
			(Array
				with: 'Modify'
				with: [ :user | self modifyRegistrationInformation: user ]
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

{ #category : #'as yet unclassified' }
ERGroupManagerList >> registerAdminAsGroupManager [
	controller registerAsGroupManager.
	content state: content lastState
]

{ #category : #rendering }
ERGroupManagerList >> registerGroupManager [
]

{ #category : #rendering }
ERGroupManagerList >> registerMyselfAsGroupManager [
	attendee userAccount isGroupManager 
		ifFalse: [ callback := [ self registerAdminAsGroupManager ].
	self initializeFormWithoutBasicInformationFor: attendee ]
		ifTrue: [  ]
	
]

{ #category : #rendering }
ERGroupManagerList >> renderButtons: html [
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
ERGroupManagerList >> renderContainer: html [
	html form
		method: 'post';
		id: 'formAllGroups';
		with: [
	self renderButtons: html.
	html horizontalRule.
	self renderTableOfGroups: html]
]

{ #category : #accessing }
ERGroupManagerList >> renderTableOfGroups: html [
	| table |
	table := ERTableGenericData new
		headers: self headers;
		levelTotal: 6;
		listObject: self groups;
		blockToExecute: self blockTableToExecute;
		listToRenderButton: self listDataToRenderButton.
	html render: table
]

{ #category : #accessing }
ERGroupManagerList >> tabId [
	^ 'groupManagerList'
]

{ #category : #accessing }
ERGroupManagerList >> tabName [
	^ 'Group Manager'
]

{ #category : #accessing }
ERGroupManagerList >> title [
	^ 'Group Manager'
]
