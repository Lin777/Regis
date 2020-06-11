"
I am the view to show the registered Attendees of a group
"
Class {
	#name : #ERMembersView,
	#superclass : #ERGroupRegistrationTab,
	#category : #'ESUGApp-View-View'
}

{ #category : #tableBlock }
ERMembersView >> blockTableToExecute [
	^ [:user :html | OrderedCollection new
		add: ([ :att | (att userAccount firstName, ' ', att userAccount lastName) ] value: user);
		add: ([ :att | att userAccount email ] value: user);
		add: ([ :att | att paymentInformation paymentAmount asString
			, ' €'  ] value: user);
		yourself
	]
]

{ #category : #deleting }
ERMembersView >> deleteAttendeeFromGroup: anAttendee [
	
	anAttendee paymentInformation hasPaid 
		ifFalse:[ controller user: self session user.
	controller deleteAttendee: anAttendee ]
		ifTrue: [messageComponent changeToAlertOfError.
			messageComponent errorMessage: 'You can not delete an attendee after having paid.' ]
]

{ #category : #accessing }
ERMembersView >> filterMemberGroupInformation [

	^ [ :object :text | 
		((object userAccount firstName) includesSubstring: text caseSensitive: false)
			or: [ ((object userAccount lastName) includesSubstring: text caseSensitive: false)
			or: [ ((object userAccount email) includesSubstring: text caseSensitive: false) ] ] ]
]

{ #category : #accessing }
ERMembersView >> headers [
	^ { 'Name(D)' . 'Email' . 'Fee' . PSTableSortableHeaderOptions new cell: '' }
]

{ #category : #accessing }
ERMembersView >> initialize [
	super initialize .
	messageComponent id: 'alertOfMembers'.
	callback := nil.
]

{ #category : #initialization }
ERMembersView >> initializeModifyUserForm [
	mofidyUserForm := (ERTittledFormView on: attendee userAccount 
								withContent: content) title: 'User'.
	content state: mofidyUserForm
]

{ #category : #tableBlock }
ERMembersView >> listDataToRenderButton [
	^ OrderedCollection new
		add:
			(Array
				with: 'edit'
				with: [ :att | self modifyGroupMemberRegistrationOf: att ]
				with: [ :att | att id , '-modify' ]
				with: 'Modify Attendee Information'
				with: ''
				with:  self group isAbleToPay);
		add:
			(Array
				with: 'delete'
				with: [ :att | self deleteAttendeeFromGroup: att ]
				with: [ :att | att id , '-delete' ]
				with: 'Delete user'
				with: 'return confirm(''Are you sure you want to delete this user?'');'
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

{ #category : #rendering }
ERMembersView >> renderButtonsOn: html [
	self renderRegisterAttendee: html.
	self alreadyRegisteredAsAttendee 
		ifFalse:[
			self renderRegisterMyselfAsAttendee: html ]
]

{ #category : #rendering }
ERMembersView >> renderContainerOn: html [

	html form
		method: 'post';
		id: 'formMembers';
		with: [
			html horizontalRule.
			html render: messageComponent ].
	self renderTableOfAttendsOn: html
]

{ #category : #rendering }
ERMembersView >> renderRegisterAttendee: html [
	html mdlAnchorButton
		colored;
		id: 'registerAttendee';
		disabled: (self group isAbleToPay ifTrue: 'disabled');
		callback:  [ self registerAttendee ];
		with: 'Register Attendee'
]

{ #category : #rendering }
ERMembersView >> renderRegisterMyselfAsAttendee: html [
	html mdlAnchorButton
		colored;
		id: 'registerMyselfAsAttendee';
		disabled: (self group isAbleToPay ifTrue: 'disabled');
		callback: [ self registerMyselfAsAttendee ];
		with: 'Register Myself as Attendee'
]

{ #category : #rendering }
ERMembersView >> renderTableOfAttendsOn: html [
	table := ERTable new
		tableId: 'memberGroup-table';
		limitPageShowed: 3;
		validation: self filterMemberGroupInformation;
		header: self headers;
		levelTotal: 6;
		rows: self attends;
		blockToExecute: self blockTableToExecute;
		listToRenderButton: self listDataToRenderButton;
		dictToRenderDownloadButton: Dictionary new;
		sortingMethod: self sortingMethodMembers.
	html render: table
]

{ #category : #accessing }
ERMembersView >> sortingMethodMembers [
	^ { [ :att | (att userAccount firstName, ' ', att userAccount lastName) ] 
		. [ :att | att userAccount email ]
		. [ :att | att paymentInformation paymentAmount asString, ' €' ] }
]

{ #category : #accessing }
ERMembersView >> tabId [
	^ 'members'
]

{ #category : #accessing }
ERMembersView >> tabName [
	^ 'Members'
]

{ #category : #accessing }
ERMembersView >> title [
	^ ''
]
