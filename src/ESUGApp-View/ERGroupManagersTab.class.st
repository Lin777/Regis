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
			([ :att | (controller amountOfPayToGroup: att listAttends) asString ]
				value: group);
		add: ([ :att :aHtml | [ aHtml mdlCheckbox 
				value: (controller allAttendeesHasPaid: att);
				onTrue: [ controller stateUpdatePaidAttendees: att ] 
				onFalse: [ controller stateUpdateNotPaidAttendees: att ];
				onChange: (html jQuery ajax serializeForm).
				] ] valueWithArguments: {group. html});
		yourself ].
]

{ #category : #rendering }
ERGroupManagersTab >> deleteGroup: user [
]

{ #category : #rendering }
ERGroupManagersTab >> dictToRenderDownloadButton [
	^ Dictionary new 
	at: 'icon' put: 'get_app';
	at: 'id' put: [ :group | group id , '-get_app' ];
	at: 'disabled' put: [:group | ((controller allAttendeesHasPaid: group) and: [ group encodedInvoice isNotNil ]) not ];
	at: 'url' put: [ :group | 'data:text/pdf;base64,', (group encodedInvoice ifNil: [ '' ])];
	at: 'download' put: [ :group | 'RegistrationInvoice_', group id, '.pdf'];
	yourself.
]

{ #category : #rendering }
ERGroupManagersTab >> exportGroups [
	| file |
	file := controller exportGroupManagers: 'groupManagers'.
	encodeCSVFile := controller encodeFileToUTF8: file.
	file ensureDelete.
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
				with: '');
		add:
			(Array
				with: 'description'
				with: [ :user | self generateInvoiceGroup: user ]
				with: [ :user | user id , '-invoice' ]
				with: 'Generate invoice'
				with: '');
		yourself
]

{ #category : #rendering }
ERGroupManagersTab >> renderButtons: html [
	html mdlAnchorButton
		colored;
		id: 'exportGroups';
		callback: [ self exportGroups ];
		with: 'Export'.
	self renderDownloadButton: html.
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

{ #category : #rendering }
ERGroupManagersTab >> renderDownloadButton: html [
	| dictionary |
	dictionary := Dictionary new 
	at: 'id' put: 'downloadDataGroupManagers';
	at: 'disabled' put: encodeCSVFile isNil;
	at: 'encodeFile' put: 'data:text/csv;charset=utf-8,', (encodeCSVFile ifNil: ['']);
	at: 'nameFile' put: 'dataGroupManagers.csv';
	at: 'nameButton' put: 'Download';
	yourself.
	self renderDownloadButton: html with: dictionary.
]

{ #category : #accessing }
ERGroupManagersTab >> renderTableOfGroups: html [
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
