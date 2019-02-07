Class {
	#name : #ERGroupManagersTab,
	#superclass : #ERConfigurationTab,
	#instVars : [
		'groupManagerForm',
		'encodeCSVFile'
	],
	#category : #'ESUGApp-View-Tab'
}

{ #category : #rendering }
ERGroupManagersTab >> alreadyRegisteredAsGroupManager [
	^ attendee userAccount isGroupManager
]

{ #category : #rendering }
ERGroupManagersTab >> blockTableToExecute [
	^ [ :group :html | 
	OrderedCollection new
		add: ([ :att | att groupManager firstName ] value: group);
		add: ([ :att | att groupManager email ] value: group);
		add: ([ :att | att groupManager orgName ] value: group);
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
	encodeCSVFile := self encodeFileToUTF8: file.
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

{ #category : #accessing }
ERGroupManagersTab >> initializeFormRegister [
	newAttendee := ERAttendee new.
	formRegister := ERContainerTabs
		formRegisterOn: newAttendee
		withCallback: callback
		content: content
]

{ #category : #accessing }
ERGroupManagersTab >> initializeFormRegisterAdminToGroupManager [
	groupManagerForm := ERContainerTabs
		formAdminToGMRegisterOn: attendee
		withCallback: callback
		content: content.
	content state: groupManagerForm
]

{ #category : #accessing }
ERGroupManagersTab >> initializeFormRegisterForGroupManager: anAttendee [
	groupManagerForm := ERContainerTabs
		formGMRegisterOn: anAttendee
		withCallback: [ self registerGM  ]
		content: content.
	content state: groupManagerForm
]

{ #category : #accessing }
ERGroupManagersTab >> initializeFormRegisterModifyAffiliationGroupManager: aGroupManager [
	groupManagerForm := ERContainerTabs
		formAdminToGMRegisterOn: aGroupManager
		withCallback: [ self registerAdminAsGroupManager ]
		content: content.
	content state: groupManagerForm
]

{ #category : #rendering }
ERGroupManagersTab >> listDataToRenderButton [
	^ OrderedCollection new
		add:
			(Array
				with: 'edit'
				with: [ :user | self modifyAffiliationGroupManager: user ]
				with: [ :user | user id , '-modify' ]);
		add:
			(Array
				with: 'delete'
				with: [ :user | self deleteAttendeeFromGroup: user ]
				with: [ :user | user id , '-delete' ]);
		add:
			(Array
				with: 'person'
				with: [ :user | self modifyUserFormGroup: user groupManager ]
				with: [ :user | user id , '-modifyUser' ]);
		add:
			(Array
				with: 'replay'
				with: [ nil ]
				with: [ :user | user id , '-resetPassword' ]);
		add:
			(Array
				with: 'description'
				with: [ :user | self generateInvoiceGroup: user ]
				with: [ :user | user id , '-invoice' ]);
		yourself
]

{ #category : #rendering }
ERGroupManagersTab >> modifyAffiliationGroupManager: aGroupManager [
	self
		initializeFormRegisterModifyAffiliationGroupManager: aGroupManager groupManager 
]

{ #category : #'as yet unclassified' }
ERGroupManagersTab >> registerAdminAsGroupManager [
	|groupManager|
	(ERRegistrationController attendee: attendee)
		validateRegisterForGroupManager.
	groupManager := controller registerAsGroupManager.
	(ERGroupManagerController new attendee: groupManager)
				groupForGroupManager.
	content state: content lastState
]

{ #category : #accessing }
ERGroupManagersTab >> registerGM [
	(ERRegistrationController attendee: newAttendee)
		validateRegisterForGroupManager;
		saveAsGroupManager.
	content state: content lastState
]

{ #category : #rendering }
ERGroupManagersTab >> registerGroupManager [
	newAttendee := ERAttendee new.
	self initializeFormRegisterForGroupManager: newAttendee.
	self updateStateTab: self tabName. 
]

{ #category : #rendering }
ERGroupManagersTab >> registerMyselfAsGroupManager [
	attendee userAccount isGroupManager
		ifFalse: [ callback := [ self registerAdminAsGroupManager ].

			self initializeFormRegisterAdminToGroupManager ]
		ifTrue: [  ].
	self updateStateTab: self tabName
]

{ #category : #rendering }
ERGroupManagersTab >> renderButtons: html [
	self
		createColoredAnchorButton: 'REGISTER GROUP MANAGER'
		with: [ self registerGroupManager ]
		id: 'registerGroupManager'
		on: html.
	self alreadyRegisteredAsGroupManager ifFalse: [
	self
		createColoredAnchorButton: 'REGISTER MYSELF AS GROUP MANAGER'
		with: [ self registerMyselfAsGroupManager ]
		id: 'registerMyselfAsGroupManager'
		on: html].
	self
		createColoredAnchorButton: 'Export'
		with: [ self exportGroups ]
		id: 'exportGroups'
		on: html.
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
	| table |
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
