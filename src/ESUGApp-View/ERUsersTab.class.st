"
Description
--------------------

Tab to render all users of ESUG page in a table.
"
Class {
	#name : #ERUsersTab,
	#superclass : #ERConfigurationTab,
	#instVars : [
		'formUser',
		'newUser'
	],
	#category : #'ESUGApp-View-Tab'
}

{ #category : #adding }
ERUsersTab >> addUser [
	self initializeFormAddUser.
	content state: formUser.
	self updateStateTab: self tabName
	
]

{ #category : #tableBlock }
ERUsersTab >> blockTableToExecute [
	^ [ :user | 
	OrderedCollection new
		add: ([ :att | att firstName ] value: user);
		add: ([ :att | att rolesAsString ] value: user);
		add: ([ :att | att email ] value: user);
		yourself ]
]

{ #category : #creating }
ERUsersTab >> createUser: anUser [
	controller conference validateIfEmailIsAlreadyRegistered: anUser. 
	controller validateNewPassword: anUser password with: anUser confirmPassword.
	anUser encryptMyPassword.
	anUser role: (Heap new
		add: anUser role;
		yourself).
	controller addUser: (anUser as: ERUserAccount ).
	self cancel
]

{ #category : #deleting }
ERUsersTab >> deleteUser: user [
	[controller deleteUser: user]
	on: ERException 
	do: [ :exception | messageComponent errorMessage: exception messageText ].
	self updateStateTab: self tabName
]

{ #category : #actions }
ERUsersTab >> exportUsers [
	| file |
	file := controller conference exportUsers: 'users'.
	self exportFile: file wihtName: 'users.csv'
]

{ #category : #accessing }
ERUsersTab >> headers [
	^ #('Name' 'Admin Role' 'Email' '')
]

{ #category : #initialization }
ERUsersTab >> initializeFormAddUser [
	newUser := ERUserAccountForAdminRegister new.
	formUser := (ERTittledFormView 
							on: newUser 
							withContent: content) title: 'User'; 
							callback: [:anUser | self createUser: anUser];
							cancelCallback: [self cancel];
							initializeForm
]

{ #category : #tableBlock }
ERUsersTab >> listDataToRenderButton [
	^ OrderedCollection new
		add:
			(Array
				with: 'edit'
				with: [ :user | self modifyUserFormGroup: user ]
				with: [ :user | user id , '-modify' ]
				with: 'Modify'
				with: ''
				with: false);
		add:
			(Array
				with: 'delete'
				with: [ :user | self deleteUser: user ]
				with: [ :user | user id , '-delete' ]
				with: 'Delete'
				with: 'return confirm(''Are you sure you want to delete this item?'');'
				with: false);
		yourself
]

{ #category : #rendering }
ERUsersTab >> renderButtonAddOn: html [
	html mdlAnchorButton
		colored;
		id: 'addUser';
		callback: [ self addUser ];
		with: 'Add'
]

{ #category : #rendering }
ERUsersTab >> renderButtonExportOn: html [
	html mdlAnchorButton
		colored;
		id: 'exportUsers';
		callback: [ self exportUsers ];
		with: 'Export'.
]

{ #category : #rendering }
ERUsersTab >> renderButtonsOn: html [
	self renderButtonAddOn: html.
	self renderButtonExportOn: html
]

{ #category : #rendering }
ERUsersTab >> renderContainerOn: html [
	html form
		method: 'post';
		id: 'formAllUsers';
		with: [ self renderButtonsOn: html.
			html horizontalRule.
			html render: messageComponent .
			self renderTableOfUsersOn: html ]
]

{ #category : #rendering }
ERUsersTab >> renderTableOfUsersOn: html [
	table := ERTable new
		headers: self headers;
		levelTotal: 6;
		listObject: self users;
		blockToExecute: self blockTableToExecute;
		listToRenderButton: self listDataToRenderButton.
	html render: table
]

{ #category : #accessing }
ERUsersTab >> tabId [
	^ 'allUsers'
]

{ #category : #accessing }
ERUsersTab >> tabName [
	^ 'Users'
]

{ #category : #accessing }
ERUsersTab >> title [
	^ 'All User'
]

{ #category : #rendering }
ERUsersTab >> users [
	^ controller conference users
]
