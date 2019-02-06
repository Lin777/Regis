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
	^ [:user | OrderedCollection new
		add: ([ :att | att userAccount firstName ] value: user);
		add: ([ :att | att userAccount email ] value: user);
		add: ([ :att | (controller conferenceFeeFor: att) asString
			, ' ', att paymentInformation paymentCurrency, '(s)'  ] value: user);
		add: ([ :att | att paymentInformation hasPaid ifTrue: [ 'Yes' ] ifFalse: [ 'No' ] ] value: user);
		yourself
	]
]

{ #category : #accessing }
ERMembersTab >> deleteAttendeeFromGroup: anAttendee [
	controller deleteAttendee: anAttendee
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
				with: 'Modify'
				with: [ :user | self modifyRegistrationInformation: user ]
				with: [ :user | user id , '-modify' ]);
		add:
			(Array
				with: 'Delete'
				with: [ :user | self deleteAttendeeFromGroup: user ]
				with: [ :user | user id , '-delete' ]);
		add:
			(Array
				with: 'Modify User'
				with: [ :user | self modifyUserFormGroup: user userAccount ]
				with: [ :user | user id , '-modifyUser' ]);
		add:
			(Array
				with: 'Reset Password'
				with: [ nil ]
				with: [ :user | user id , '-resetPassword' ]);
		add:
			(Array
				with: 'Apply Reduction'
				with: [ :user | self applyReductionTicketTo: user  ]
				with: [ :user | user id , '-applyReduction' ]);
		add:
			(Array
				with: 'Invoice'
				with: [ nil ]
				with: [ :user | user id , '-invoice' ]);
		yourself
]

{ #category : #accessing }
ERMembersTab >> registerGroupManagerAsAttendee [
	"Add function to add attendee role to group manager"
	(ERRegistrationController attendee: attendee) validateRegister.
	controller registerAsAttendee.
	content state: content lastState
]

{ #category : #accessing }
ERMembersTab >> registerMyselfAsAttendee [
	callback := [ :att | controller addGroupManagerAsAttendee: att ].
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
		listToRenderButton: self listDataToRenderButton.
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

{ #category : #accessing }
ERMembersTab >> validateAndRegisterAsAttendee [
	(ERRegistrationController attendee: attendee)
		validateRegister.
	controller registerAsAttendee.
	content state: content lastState
]
