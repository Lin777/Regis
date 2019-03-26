Class {
	#name : #ERUsersTab,
	#superclass : #ERConfigurationTab,
	#instVars : [
		'formUser',
		'newUser',
		'fileId',
		'encodeCSVFile'
	],
	#category : #'ESUGApp-View-Tab'
}

{ #category : #rendering }
ERUsersTab >> addUser [
	self initializeFormAddUser.
	content state: formUser.
	self updateStateTab: self tabName
	
]

{ #category : #rendering }
ERUsersTab >> blockTableToExecute [
	^ [ :user | 
	OrderedCollection new
		add: ([ :att | att firstName ] value: user);
		add: ([ :att | att rolesAsString ] value: user);
		add: ([ :att | att email ] value: user);
		yourself ]
]

{ #category : #'as yet unclassified' }
ERUsersTab >> createUser: anUser [
	controller validateIfEmailIsAlreadyRegistered: anUser; 
			validateNewPassword: anUser password with: anUser confirmPassword.
	anUser password: (ERUserAccount hashPassword: anUser password) asString.
	anUser role: (Heap new
		add: anUser role;
		yourself).
	ERController new addUser: anUser.
	self cancel
]

{ #category : #rendering }
ERUsersTab >> deleteUser: user [
	[controller deleteUser: user]
	on: ERException 
	do: [ :exception | messageComponent errorMessage: exception messageText ].
	self updateStateTab: self tabName
]

{ #category : #rendering }
ERUsersTab >> exportUsers [
	| file |
	file := controller conference exportUsers: 'users'.
	self exportFile: file wihtName: 'users.csv'
]

{ #category : #rendering }
ERUsersTab >> fileIdUsers [
	fileId isNil
		ifTrue: [ fileId := 0 ].
	fileId := fileId + 1.
	^ fileId
]

{ #category : #rendering }
ERUsersTab >> headers [
	^ #('Name' 'Admin Role' 'Email' '')
]

{ #category : #rendering }
ERUsersTab >> initializeFormAddUser [
	newUser := ERUserAccountForAdminRegister new.
	formUser := (ERTittledFormView 
							on: newUser 
							withContent: content) title: 'User'; 
							callback: [:anUser | self createUser: anUser];
							cancelCallback: [self cancel];
							initializeForm
]

{ #category : #rendering }
ERUsersTab >> listDataToRenderButton [
	^ OrderedCollection new
		add:
			(Array
				with: 'edit'
				with: [ :user | self modifyUserFormGroup: user ]
				with: [ :user | user id , '-modify' ]
				with: 'Modify'
				with: '');
		add:
			(Array
				with: 'delete'
				with: [ :user | self deleteUser: user ]
				with: [ :user | user id , '-delete' ]
				with: 'Delete'
				with: 'return confirm(''Are you sure you want to delete this item?'');');
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

{ #category : #rendering }
ERUsersTab >> resetPassword: user [
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
