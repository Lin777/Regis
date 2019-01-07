Class {
	#name : #ERAllUsers,
	#superclass : #ERConfiguration,
	#instVars : [
		'formUser',
		'newUser'
	],
	#category : #'ESUGApp-Components'
}

{ #category : #rendering }
ERAllUsers >> addUser [
	self initializeFormAddUser.
	content state: formUser
	
]

{ #category : #rendering }
ERAllUsers >> addUserToConference [
	| result |
	result := controller addUser: newUser.
	result
		ifNil: [ Transcript show: 'This email already registered' ]
		ifNotNil: [ content state: content lastState ]
]

{ #category : #rendering }
ERAllUsers >> blockTableToExecute [
	^ [ :user | 
	OrderedCollection new
		add: ([ :att | att firstName ] value: user);
		add: ([ :att | att rolesAsString ] value: user);
		add: ([ :att | att email ] value: user);
		yourself ]
]

{ #category : #rendering }
ERAllUsers >> deleteUser: user [
]

{ #category : #rendering }
ERAllUsers >> exportUsers [
	(self fileExists: 'users.cvs')
		ifFalse: [ controller exportUsers ]
		ifTrue: [ Transcript show: 'File Exist' ]
]

{ #category : #rendering }
ERAllUsers >> headers [
	^ #('Name' 'Admin Role' 'Email' '')
]

{ #category : #rendering }
ERAllUsers >> initializeFormAddUser [
	newUser := ERAttendee new.
	formUser := ERContainerBasicInformation
		on: newUser
		withContent: content
		withAction: [ self addUserToConference ]
]

{ #category : #rendering }
ERAllUsers >> listDataToRenderButton [
	^ OrderedCollection new
		add:
			(Array
				with: 'Modify'
				with: [ :user | self modifyUserFormGroup: user ]
				with: [ :user | user id , '-modify' ]);
		add:
			(Array
				with: 'Delete'
				with: [ :user | self deleteUser: user ]
				with: [ :user | user id , '-delete' ]);
		add:
			(Array
				with: 'Reset Password'
				with: [ :user | self resetPassword: user ]
				with: [ :user | user id , '-resetPassword' ]);
		yourself
]

{ #category : #rendering }
ERAllUsers >> renderButtons: html [
	self
		createColoredAnchorButton: 'Add'
		with: [ self addUser ]
		id: 'addUser'
		on: html.
	self
		createColoredAnchorButton: 'Export'
		with: [ self exportUsers ]
		id: 'exportUsers'
		on: html
]

{ #category : #rendering }
ERAllUsers >> renderContainer: html [
	html form
		method: 'post';
		id: 'formAllUsers';
		with: [ self renderButtons: html.
			html horizontalRule.
			self renderTableOfUsers: html ]
]

{ #category : #rendering }
ERAllUsers >> renderTableOfUsers: html [
	| table |
	table := ERTableGenericData new
		headers: self headers;
		levelTotal: 6;
		listObject: self users;
		blockToExecute: self blockTableToExecute;
		listToRenderButton: self listDataToRenderButton.
	html render: table
]

{ #category : #rendering }
ERAllUsers >> resetPassword: user [
]

{ #category : #accessing }
ERAllUsers >> tabId [
	^ 'allUsers'
]

{ #category : #accessing }
ERAllUsers >> tabName [
	^ 'Users'
]

{ #category : #accessing }
ERAllUsers >> title [
	^ 'All User'
]

{ #category : #rendering }
ERAllUsers >> users [
	^ controller users
]
