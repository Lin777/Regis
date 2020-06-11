"
Description
--------------------

Tab to render all users of ESUG page in a table.
"
Class {
	#name : #ERUsersTab,
	#superclass : #ERUserOptionsTab,
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
		add: ([ :att | (att firstName, ' ', att lastName) ] value: user);
		add: ([ :att | self roleStringFrom: (att rolesAsString) ] value: user);
		add: ([ :att | att email ] value: user);
		yourself ]
]

{ #category : #accessing }
ERUsersTab >> changeRoleToSaveUser: aString [

	(aString = 'Group Manager')
		ifTrue: [ ^ 'groupManager' ].
	(aString = 'Administrator')
		ifTrue: [ ^ 'admin' ].
	(aString = 'Attendee')
		ifTrue: [ ^ 'attendee' ].
	(aString = 'Student Volunteer')
		ifTrue: [ ^ 'studentVolunter' ].
	(aString = 'Attendee and Group Manager')
		ifTrue: [ ^ 'attendeegroupManager' ].
	(aString = 'Attendee and Student Volunteer')
		ifTrue: [ ^ 'attendeestudentVolunter' ]
		ifFalse: [ ^ aString ]
]

{ #category : #creating }
ERUsersTab >> createUser: anUser [
	anUser role: (self changeRoleToSaveUser: anUser role).
	controller conference validateIfEmailIsAlreadyRegistered: anUser. 
	controller validateNewPassword: anUser password with: anUser confirmPassword.
	anUser encryptMyPassword.
	anUser role: (Heap new
		add: anUser role;
		yourself).
	controller addUser: (anUser as: ERUserAccount).
	self cancel
]

{ #category : #deleting }
ERUsersTab >> deleteUser: user [
	[ controller deleteUser: user ]
		on: ERException 
		do: [ :exception | messageComponent errorMessage: exception messageText ].
	self updateStateTab: self tabName
]

{ #category : #actions }
ERUsersTab >> exportUsers [
	| file |
	file := controller conference exportUsers: 'users'.
	self exportFile: file withName: 'users.csv'
]

{ #category : #tableBlock }
ERUsersTab >> filterUserInformation [

	^ [ :object :text | 
		((object firstName) includesSubstring: text caseSensitive: false)
			or: [ ((object lastName) includesSubstring: text caseSensitive: false)
			or: [ ((object email) includesSubstring: text caseSensitive: false)
			or: [ ((self roleStringFrom: (object rolesAsString)) includesSubstring: text caseSensitive: false) ] ] ] ]
]

{ #category : #accessing }
ERUsersTab >> headers [
	^ {'Name' . 'User Role' . 'Email' .  PSTableSortableHeaderOptions new cell: ''}
]

{ #category : #initialization }
ERUsersTab >> initializeFormAddUser [
	newUser := ERUserAccountForAdminRegister new.
	formUser := (ERTittledFormView 
							on: newUser 
							withContent: content) title: 'User'; 
							callback: [ :anUser | self createUser: anUser ];
							cancelCallback: [ self cancel ];
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
				with: 'Modify user'
				with: ''
				with: false);
		add:
			(Array
				with: 'delete'
				with: [ :user | self deleteUser: user ]
				with: [ :user | user id , '-delete' ]
				with: 'Delete user'
				with: 'return confirm(''Are you sure you want to delete this user?'');'
				with: false);
		yourself
]

{ #category : #rendering }
ERUsersTab >> renderButtonAddOn: html [

	html mdlAnchorButton
		colored;
		id: 'addUser';
		callback: [ self addUser ];
		with: 'Add user'
]

{ #category : #rendering }
ERUsersTab >> renderButtonExportOn: html [
	"Render export users button"
	
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
			html render: messageComponent ].
		self renderTableOfUsersOn: html
]

{ #category : #rendering }
ERUsersTab >> renderTableOfUsersOn: html [
	table := ERTable new
		header: self headers;
		tableId: 'users-table';
		levelTotal: 6;
		limitPageShowed: 3;
		validation: self filterUserInformation;
		rows: self users;
		blockToExecute: self blockTableToExecute;
		listToRenderButton: self listDataToRenderButton;
		sortingMethod: self sortingMethodUsers.
	html render: table
]

{ #category : #actions }
ERUsersTab >> roleStringFrom: aString [

	(aString = 'groupManager')
		ifTrue: [ ^ 'Group Manager' ].
	(aString = 'admin')
		ifTrue: [ ^ 'Administrator' ].
	(aString = 'attendee')
		ifTrue: [ ^ 'Attendee' ].
	(aString = 'studentVolunter')
		ifTrue: [ ^ 'Student Volunteer' ].
	(aString = 'attendeegroupManager')
		ifTrue: [ ^ 'Attendee and Group Manager' ].
	(aString = 'attendeestudentVolunter')
		ifTrue: [ ^ 'Attendee and Student Volunteer' ]
		ifFalse: [ ^ aString ]
]

{ #category : #accessing }
ERUsersTab >> sortingMethodUsers [
	^ { [ :att | (att firstName, ' ', att lastName) ]
		. [ :att | self roleStringFrom: (att rolesAsString) ]
		. [ :att | att email ] }
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
	^ 'All users'
]

{ #category : #rendering }
ERUsersTab >> users [
	^ controller conference users
]
