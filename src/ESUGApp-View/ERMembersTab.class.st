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

{ #category : #'as yet unclassified' }
ERMembersTab >> blockTableToExecute [
	^ [:user :html | OrderedCollection new
		add: ([ :att | att userAccount firstName ] value: user);
		add: ([ :att | att userAccount email ] value: user);
		add: ([ :att | att paymentInformation paymentAmount asString
			, ' ', att paymentInformation paymentCurrency, '(s)'  ] value: user);
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
	^ Dictionary new yourself
]

{ #category : #accessing }
ERMembersTab >> headers [
	^ #('Name(D)' 'Email' 'Fee' '')
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
				with: [ :att | self modifyRegistrationInformation: att ]
				with: [ :att | att id , '-modify' ]
				with: 'Modify'
				with: ''
				with:  self group isAbleToPay );
		add:
			(Array
				with: 'delete'
				with: [ :att | self deleteAttendeeFromGroup: att ]
				with: [ :att | att id , '-delete' ]
				with: 'Delete'
				with: 'return confirm(''Are you sure you want to delete this item?'');'
				with:  self group isAbleToPay);
		add:
			(Array
				with: 'person'
				with: [ :att | self modifyUserFormGroup: att userAccount ]
				with: [ :att | att id , '-modifyUser' ]
				with: 'Modify user'
				with: ''
				with: false);
		yourself
]

{ #category : #accessing }
ERMembersTab >> renderButtonsOn: html [
	self renderRegisterAttendee: html.
	self alreadyRegisteredAsAttendee ifFalse:[
	self renderRegisterMyselfAsAttendee: html]
]

{ #category : #accessing }
ERMembersTab >> renderContainerOn: html [
	html form
		method: 'post';
		id: 'formMembers';
		with: [
	"self renderButtonsOn: html."
	html horizontalRule.
	self renderTableOfAttendsOn: html]
]

{ #category : #accessing }
ERMembersTab >> renderRegisterAttendee: html [
	html mdlAnchorButton
		colored;
		id: 'registerAttendee';
		disabled: (self group isAbleToPay ifTrue: 'disabled');
		callback:  [ self registerAttendee ];
		with: 'Register Attendee'
]

{ #category : #accessing }
ERMembersTab >> renderRegisterMyselfAsAttendee: html [
	html mdlAnchorButton
		colored;
		id: 'registerMyselfAsAttendee';
		disabled: (self group isAbleToPay ifTrue: 'disabled');
		callback: [ self registerMyselfAsAttendee ];
		with: 'Register Myself as Attendee'
]

{ #category : #rendering }
ERMembersTab >> renderTableOfAttendsOn: html [
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
	^ ''
]
