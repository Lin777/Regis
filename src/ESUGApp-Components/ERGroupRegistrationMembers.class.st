Class {
	#name : #ERGroupRegistrationMembers,
	#superclass : #ERGroupRegistration,
	#instVars : [
		'mofidyUserForm'
	],
	#category : #'ESUGApp-Components'
}

{ #category : #accessing }
ERGroupRegistrationMembers >> attends [
	^ (ERGroupManagerViewController new
		groupOfAttendee: attendee ) listAttends
]

{ #category : #'as yet unclassified' }
ERGroupRegistrationMembers >> blockTableToExecute [
	^ [:user | OrderedCollection new
		add: ([ :att | att firstName ] value: user);
		add: ([ :att | att userAccount email ] value: user);
		add: '660.00 Euros';
		add: 'No';
		yourself
	]
]

{ #category : #accessing }
ERGroupRegistrationMembers >> deleteAttendeeFromGroup: anAttendee [
	controller deleteAttendeeFromGroup: anAttendee 
]

{ #category : #accessing }
ERGroupRegistrationMembers >> headers [
	^ #('Name(D)' 'Email' 'Fee' 'Has Paid?' '')
]

{ #category : #accessing }
ERGroupRegistrationMembers >> initialize [
	super initialize .
	callback := nil
]

{ #category : #initialization }
ERGroupRegistrationMembers >> initializeModifyUserForm [
	mofidyUserForm := ERContainerModifyUserView
		on: attendee
		withContent: content.
	
	content state: mofidyUserForm
]

{ #category : #'as yet unclassified' }
ERGroupRegistrationMembers >> listDataToRenderButton [
	^ OrderedCollection new 
	add: (Array with: 'Modify' 
	with: [ :user | self modifyRegistrationInformation: user ] 
	with: [:user | user id, '-modify']);
	add: (Array with: 'Delete' 
	with: [ :user | self deleteAttendeeFromGroup: user ] 
	with: [:user | user id, '-delete']);
	add: (Array with: 'Modify User' 
	with: [ :user | self modifyUserFormGroup: user ] 
	with: [:user | user id, '-modifyUser']);
	add: (Array with: 'Reset Password' 
	with: [ nil ] 
	with: [:user | user id, '-resetPassword']);
	add: (Array with: 'Apply Reduction' 
	with: [ nil ] 
	with: [:user | user id, '-applyReduction']);
	add: (Array with: 'Invoice' 
	with: [ nil ] 
	with: [:user | user id, '-invoice']);
	yourself
]

{ #category : #accessing }
ERGroupRegistrationMembers >> registerGroupManagerAsAttendee [
	"Add function to add attendee role to group manager"
	controller registerAsAttendee.
	content state: content lastState
]

{ #category : #accessing }
ERGroupRegistrationMembers >> registerMyselfAsAttendee [
	callback := [ self registerGroupManagerAsAttendee ].
	self initializeFormWithoutBasicInformationFor: attendee
]

{ #category : #accessing }
ERGroupRegistrationMembers >> renderButtons: html [
	self renderRegisterAttendee: html.
	self renderRegisterMyselfAsAttendee: html
]

{ #category : #accessing }
ERGroupRegistrationMembers >> renderContainer: html [
	html form
		method: 'post';
		id: 'formMembers';
		with: [
	self renderButtons: html.
	html horizontalRule.
	self renderTableOfAttends: html]
]

{ #category : #accessing }
ERGroupRegistrationMembers >> renderRegisterAttendee: html [
	self
		createColoredAnchorButton: 'Register Attendee'
		with: [ self registerAttendee ]
		id: 'registerAttendee'
		on: html
]

{ #category : #accessing }
ERGroupRegistrationMembers >> renderRegisterMyselfAsAttendee: html [
	self
		createColoredAnchorButton: 'Register Myself as Attendee'
		with: [ self registerMyselfAsAttendee ]
		id: 'registerMyselfAsAttendee'
		on: html
]

{ #category : #rendering }
ERGroupRegistrationMembers >> renderTableOfAttends: html [
	| table |
	table := ERTableGenericData new
		headers: self headers;
		levelTotal: 6;
		listObject: self attends;
		blockToExecute: self blockTableToExecute;
		listToRenderButton: self listDataToRenderButton.
	html render: table
]

{ #category : #accessing }
ERGroupRegistrationMembers >> tabId [
	^ 'members'
]

{ #category : #accessing }
ERGroupRegistrationMembers >> tabName [
	^ 'Members'
]

{ #category : #rendering }
ERGroupRegistrationMembers >> title [
	^ 'Attends'
]
