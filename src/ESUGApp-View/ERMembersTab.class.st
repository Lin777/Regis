Class {
	#name : #ERMembersTab,
	#superclass : #ERGroupRegistrationTab,
	#category : #'ESUGApp-View-Tab'
}

{ #category : #accessing }
ERMembersTab >> attendeeFrom: aGroupManager [
	^ ERAttendee new 
		userAccount: aGroupManager userAccount; 
		affiliationInformation: aGroupManager affiliationInformation 
]

{ #category : #accessing }
ERMembersTab >> attends [
	^ (ERGroupManagerController new
		groupOfUser: attendee ) listAttends
]

{ #category : #'as yet unclassified' }
ERMembersTab >> blockTableToExecute [
	^ [:user :html | OrderedCollection new
		add: ([ :att | att userAccount firstName ] value: user);
		add: ([ :att | att userAccount email ] value: user);
		add: ([ :att | att paymentInformation paymentAmount asString
			, ' ', att paymentInformation paymentCurrency, '(s)'  ] value: user);
		add: ([ :att :aHtml | [ aHtml mdlCheckbox 
				disabled: true;
				value: att paymentInformation hasPaid;
				onTrue: [ controller stateUpdatePaidAttendee: att with: true ] 
				onFalse: [ controller stateUpdatePaidAttendee: att with: false ];
				onChange: (html jQuery ajax serializeForm).
				] ] valueWithArguments: {user. html});
		yourself
	]
]

{ #category : #accessing }
ERMembersTab >> deleteAttendeeFromGroup: anAttendee [
	controller user: self session user.
	controller deleteAttendee: anAttendee
]

{ #category : #rendering }
ERMembersTab >> dictToRenderDownloadButton [
	^ Dictionary new
		at: 'icon' put: 'get_app';
		at: 'id' put: [ :attend | attend id , '-get_app' ];
		at: 'disabled' put: [ :attend | (attend encodedInvoice isNotNil and: [ attend paymentInformation hasPaid ]) not ];
		at: 'download' put: [ :attend | 'RegistrationInvoice_', attend id, '.pdf'];
		at: 'url' put: [ :attend | 'data:text/pdf;base64,', (attend encodedInvoice ifNil: [ '' ]) ];
		yourself
]

{ #category : #accessing }
ERMembersTab >> headers [
	^ #('Name(D)' 'Email' 'Fee' 'Has Paid?' '')
]

{ #category : #accessing }
ERMembersTab >> initialize [
	super initialize .
	callback := nil
]

{ #category : #initialization }
ERMembersTab >> initializeModifyUserForm [
	mofidyUserForm := (ERTittledFormView on: attendee userAccount 
								withContent: content) title: 'User'.
	content state: mofidyUserForm
]

{ #category : #rendering }
ERMembersTab >> listDataToRenderButton [
	^ OrderedCollection new
		add:
			(Array
				with: 'edit'
				with: [ :user | self modifyRegistrationInformation: user ]
				with: [ :user | user id , '-modify' ]
				with: 'Modify'
				with: '');
		add:
			(Array
				with: 'delete'
				with: [ :user | self deleteAttendeeFromGroup: user ]
				with: [ :user | user id , '-delete' ]
				with: 'Delete'
				with: 'return confirm(''Are you sure you want to delete this item?'');');
		add:
			(Array
				with: 'person'
				with: [ :user | self modifyUserFormGroup: user userAccount ]
				with: [ :user | user id , '-modifyUser' ]
				with: 'Modify user'
				with: '');
		add:
			(Array
				with: 'payment'
				with: [ :user | self applyReductionTicketTo: user  ]
				with: [ :user | user id , '-applyReduction' ]
				with: 'Apply reduction'
				with: '');
		add:
			(Array
				with: 'description'
				with: [ :user | self generateInvoice: user ]
				with: [ :user | user id , '-invoice' ]
				with: 'Generate invoice'
				with: '');
		yourself
]

{ #category : #accessing }
ERMembersTab >> registerMyselfAsAttendee [
	callback := [ :att | controller addGroupManagerAsAttendee: att.
								content state: content lastState ].
	self initializeFormWithoutBasicInformationFor: (self attendeeFrom: self groupManager)
]

{ #category : #accessing }
ERMembersTab >> renderButtons: html [
	self renderRegisterAttendee: html.
	self alreadyRegisteredAsAttendee ifFalse:[
	self renderRegisterMyselfAsAttendee: html]
]

{ #category : #accessing }
ERMembersTab >> renderContainer: html [
	html form
		method: 'post';
		id: 'formMembers';
		with: [
	self renderButtons: html.
	html horizontalRule.
	self renderTableOfAttends: html]
]

{ #category : #accessing }
ERMembersTab >> renderRegisterAttendee: html [
	html mdlAnchorButton
		colored;
		id: 'registerAttendee';
		callback:  [ self registerAttendee ];
		with: 'Register Attendee'
]

{ #category : #accessing }
ERMembersTab >> renderRegisterMyselfAsAttendee: html [
	html mdlAnchorButton
		colored;
		id: 'registerMyselfAsAttendee';
		callback: [ self registerMyselfAsAttendee ];
		with: 'Register Myself as Attendee'
]

{ #category : #rendering }
ERMembersTab >> renderTableOfAttends: html [
	| table |
	table := ERTable new
		headers: self headers;
		levelTotal: 6;
		listObject: self attends;
		blockToExecute: self blockTableToExecute;
		listToRenderButton: self listDataToRenderButton;
		dictToRenderDownloadButton: self dictToRenderDownloadButton.
	html render: table
]

{ #category : #accessing }
ERMembersTab >> tabId [
	^ 'members'
]

{ #category : #accessing }
ERMembersTab >> tabName [
	^ 'Members'
]

{ #category : #rendering }
ERMembersTab >> title [
	^ 'Attends'
]
