"
Description
--------------------

Tab to render  all group managers of ESUG page in a table.
"
Class {
	#name : #ERGroupTab,
	#superclass : #ERUserOptionsTab,
	#instVars : [
		'groupManagerForm'
	],
	#category : #'ESUGApp-View-Tab'
}

{ #category : #tableBlock }
ERGroupTab >> blockTableToExecute [

	^ [ :group :html | 
	OrderedCollection new
		add: ([ :att | att affiliationInformation organizationName ] value: group);
		add: ([ :att | att paymentInformation paymentAmount asString ] value: group);
		yourself ].
]

{ #category : #deleting }
ERGroupTab >> deleteGroup: user [
	controller deleteGroup: user
]

{ #category : #actions }
ERGroupTab >> exportGroups [
	| file |
	file := controller conference exportGroupManagers: 'groupManagers'.
	self exportFile: file withName: 'groupManagers.csv'
]

{ #category : #rendering }
ERGroupTab >> filterGroupInformation [

	
	^ [ :object :text | 
		((object affiliationInformation organizationName) includesSubstring: text caseSensitive: false)
		or: [ ((object paymentInformation paymentAmount asString) includesSubstring: text caseSensitive: false) ] ]
]

{ #category : #accessing }
ERGroupTab >> groups [
	^ controller conference groups
]

{ #category : #accessing }
ERGroupTab >> headers [
	^ {'Organization' . 'Remaing Fee' .  PSTableSortableHeaderOptions new cell: ''}
]

{ #category : #tableBlock }
ERGroupTab >> listDataToRenderButton [
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
ERGroupTab >> modifyGroupInformation: aGroup [

	(aGroup contactInformation copy) readOnly: false.
	(aGroup affiliationInformation copy) readOnly: false.
	(aGroup paymentInformation copy) readOnly: false.
	self initializeGroupInformationForm: aGroup.
]

{ #category : #rendering }
ERGroupTab >> renderButtonsOn: html [
	html mdlAnchorButton
		colored;
		id: 'exportGroups';
		callback: [ self exportGroups ];
		with: 'Export'
]

{ #category : #rendering }
ERGroupTab >> renderContainerOn: html [
	html form
		method: 'post';
		id: 'formAllGroups';
		with: [
			self renderButtonsOn: html.
			html horizontalRule ].
		self renderTableOfGroupsOn: html
]

{ #category : #accessing }
ERGroupTab >> renderTableOfGroupsOn: html [
	table := ERTable new
		header: self headers;
		tableId: 'group-table';
		levelTotal: 6;
		limitPageShowed: 3;
		rows: self groups;
		blockToExecute: self blockTableToExecute;
		validation: self filterGroupInformation;
		listToRenderButton: self listDataToRenderButton;
		dictToRenderDownloadButton: Dictionary new;
		sortingMethod: self sortingMethodGroup.
	html render: table
]

{ #category : #accessing }
ERGroupTab >> sortingMethodGroup [
	^ { [ :att | att affiliationInformation organizationName ]
		. [ :att | att paymentInformation paymentAmount asString ] }
]

{ #category : #accessing }
ERGroupTab >> tabId [
	^ 'groupManagerList'
]

{ #category : #accessing }
ERGroupTab >> tabName [
	^ 'Group information'
]

{ #category : #accessing }
ERGroupTab >> title [
	^ 'Group information'
]
