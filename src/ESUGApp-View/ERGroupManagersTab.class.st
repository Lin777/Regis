Class {
	#name : #ERGroupManagersTab,
	#superclass : #ERConfigurationTab,
	#instVars : [
		'groupManagerForm',
		'newAttendee',
		'encodeCSVFile'
	],
	#category : #'ESUGApp-View-Tab'
}

{ #category : #rendering }
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

{ #category : #rendering }
ERGroupManagersTab >> deleteGroup: user [
	controller deleteGroup: user
]

{ #category : #rendering }
ERGroupManagersTab >> dictToRenderDownloadButton [
	^ Dictionary new 
	"at: 'icon' put: 'get_app';
	at: 'id' put: [ :group | group id , '-get_app' ];
	at: 'disabled' put: [:group | ((controller allAttendeesHasPaid: group) and: [ group encodedInvoice isNotNil ]) not ];
	at: 'url' put: [ :group | 'data:text/pdf;base64,', (group encodedInvoice ifNil: [ '' ])];
	at: 'download' put: [ :group | 'RegistrationInvoice_', group id, '.pdf'];
	"yourself.
]

{ #category : #rendering }
ERGroupManagersTab >> exportGroups [
	| file |
	file := controller exportGroupManagers: 'groupManagers'.
	self exportFile: file wihtName: 'groupManagers.csv'
]

{ #category : #accessing }
ERGroupManagersTab >> groups [
	^ controller groups
]

{ #category : #accessing }
ERGroupManagersTab >> headers [
	^ #('Name' 'Email' 'Organization' 'Remaing Fee' '')
]

{ #category : #rendering }
ERGroupManagersTab >> listDataToRenderButton [
	^ OrderedCollection new
		add:
			(Array
				with: 'edit'
				with: [ :user | self modifyAffiliation: user ]
				with: [ :user | user id , '-modify' ]
				with: 'Modify'
				with: '');
		add:
			(Array
				with: 'delete'
				with: [ :user | self deleteGroup: user ]
				with: [ :user | user id , '-delete' ]
				with: 'Delete'
				with: 'return confirm(''Are you sure you want to delete this item?'');');
		add:
			(Array
				with: 'person'
				with: [ :user | self modifyUserFormGroup: user groupManager userAccount ]
				with: [ :user | user id , '-modifyUser' ]
				with: 'Modify user'
				with: '');"
		add:
			(Array
				with: 'description'
				with: [ :user | self generateInvoiceGroup: user ]
				with: [ :user | user id , '-invoice' ]
				with: 'Generate invoice'
				with: '');"
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
		dictToRenderDownloadButton: self dictToRenderDownloadButton.
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
