"
Description
--------------------

Tab to render  all group managers of ESUG page in a table.
"
Class {
	#name : #ERGroupManagersTab,
	#superclass : #ERConfigurationTab,
	#instVars : [
		'groupManagerForm'
	],
	#category : #'ESUGApp-View-Tab'
}

{ #category : #tableBlock }
ERGroupManagersTab >> blockTableToExecute [

	^ [ :group :html | 
	OrderedCollection new
		add: ([ :att | att affiliationInformation organizationName ] value: group);
		add: ([ :att | att paymentInformation paymentAmount asString ] value: group);
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
	^ #('Organization' 'Remaing Fee' '')
]

{ #category : #tableBlock }
ERGroupManagersTab >> listDataToRenderButton [
	^ OrderedCollection new
		add:
			(Array
				with: 'edit'
				with: [ :aGroup | self modifyGroupInformation: aGroup ]
				with: [ :aGroup | aGroup id , '-modify' ]
				with: 'Modify group information'
				with: ''
				with: false);
		add:
			(Array
				with: 'delete'
				with: [ :aGroup | self deleteGroup: aGroup ]
				with: [ :aGroup | aGroup id , '-delete' ]
				with: 'Remove group'
				with: 'return confirm(''Are you sure you want to delete this group?'');'
				with:  false);
		yourself
]

{ #category : #tableBlock }
ERGroupManagersTab >> modifyGroupInformation: aGroup [

	(aGroup contactInformation copy) readOnly: false.
	(aGroup affiliationInformation copy) readOnly: false.
	(aGroup paymentInformation copy) readOnly: false.
	self initializeGroupInformationForm: aGroup.
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
	^ 'Group information'
]

{ #category : #accessing }
ERGroupManagersTab >> title [
	^ 'Group information'
]
