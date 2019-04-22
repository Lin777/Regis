"
Description
--------------------

Tab to render  all group managers of ESUG page in a table.
"
Class {
	#name : #ERGroupManagersTab,
	#superclass : #ERConfigurationTab,
	#instVars : [
		'groupManagerForm',
		'newAttendee'
	],
	#category : #'ESUGApp-View-Tab'
}

{ #category : #tableBlock }
ERGroupManagersTab >> blockTableToExecute [
	^ [ :group :html | 
	OrderedCollection new
		add: ([ :att | att groupManager userAccount firstName ] value: group);
		add: ([ :att | att groupManager userAccount email ] value: group);
		add: ([ :att | att groupManager affiliationInformation organizationName ] value: group);
		add:
			([ :att | att paymentInformation paymentAmount asString ]
				value: group);
		yourself ].
]

{ #category : #deleting }
ERGroupManagersTab >> deleteGroup: user [
	controller deleteGroup: user
]

{ #category : #actions }
ERGroupManagersTab >> exportGroups [
	| file |
	file := controller conference exportGroupManagers: 'groupManagers'.
	self exportFile: file wihtName: 'groupManagers.csv'
]

{ #category : #accessing }
ERGroupManagersTab >> groups [
	^ controller conference groups
]

{ #category : #accessing }
ERGroupManagersTab >> headers [
	^ #('Name' 'Email' 'Organization' 'Remaing Fee' '')
]

{ #category : #tableBlock }
ERGroupManagersTab >> listDataToRenderButton [
	^ OrderedCollection new
		add:
			(Array
				with: 'edit'
				with: [ :aGroup | self modifyAffiliation: aGroup ]
				with: [ :aGroup | aGroup id , '-modify' ]
				with: 'Modify'
				with: ''
				with: false);
		add:
			(Array
				with: 'delete'
				with: [ :aGroup | self deleteGroup: aGroup ]
				with: [ :aGroup | aGroup id , '-delete' ]
				with: 'Delete'
				with: 'return confirm(''Are you sure you want to delete this item?'');'
				with:  false);
		add:
			(Array
				with: 'person'
				with: [ :aGroup | self modifyUserFormGroup: aGroup groupManager userAccount ]
				with: [ :aGroup | aGroup id , '-modifyUser' ]
				with: 'Modify user'
				with: ''
				with: false);
		yourself
]

{ #category : #rendering }
ERGroupManagersTab >> renderButtonsOn: html [
	html mdlAnchorButton
		colored;
		id: 'exportGroups';
		callback: [ self exportGroups ];
		with: 'Export'
]

{ #category : #rendering }
ERGroupManagersTab >> renderContainerOn: html [
	html form
		method: 'post';
		id: 'formAllGroups';
		with: [
	self renderButtonsOn: html.
	html horizontalRule.
	self renderTableOfGroupsOn: html]
]

{ #category : #accessing }
ERGroupManagersTab >> renderTableOfGroupsOn: html [
	table := ERTable new
		headers: self headers;
		levelTotal: 6;
		listObject: self groups;
		blockToExecute: self blockTableToExecute;
		listToRenderButton: self listDataToRenderButton;
		dictToRenderDownloadButton: Dictionary new.
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
