Class {
	#name : #ERGroupManagersTab,
	#superclass : #ERConfigurationTab,
	#instVars : [
		'groupManagerForm',
		'newAttendee'
	],
	#category : #'ESUGApp-View-Tab'
}

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
ERGroupManagersTab >> deleteGroup: user [
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

{ #category : #rendering }
ERGroupManagersTab >> listDataToRenderButton [
	^ OrderedCollection new
		add:
			(Array
				with: 'Modify'
				with: [ :user | self modifyAffiliation: user ]
				with: [ :user | user id , '-modify' ]);
		add:
			(Array
				with: 'Delete'
				with: [ :user | self deleteGroup: user ]
				with: [ :user | user id , '-delete' ]);
		add:
			(Array
				with: 'Modify User'
				with: [ :user | self modifyUserFormGroup: user groupManager userAccount ]
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

{ #category : #accessing }
ERGroupManagersTab >> registerAdminAsGroupManager [
	|groupManager|
	groupManager := controller registerAsGroupManager.
	(ERGroupManagerController new attendee: groupManager)
				groupForGroupManager.
	content state: content lastState

]

{ #category : #rendering }
ERGroupManagersTab >> renderButtons: html [
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
