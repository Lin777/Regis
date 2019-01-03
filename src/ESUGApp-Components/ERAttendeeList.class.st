Class {
	#name : #ERAttendeeList,
	#superclass : #ERConfiguration,
	#category : #'ESUGApp-Components'
}

{ #category : #rendering }
ERAttendeeList >> attends [
	^ controller attends
]

{ #category : #rendering }
ERAttendeeList >> blockTableToExecute [
	^ [ :user | 
	OrderedCollection new
		add: '10';
		add: ([ :att | att firstName ] value: user);
		add: ([ :att | att email ] value: user);
		add: ([ :att | att country ] value: user);
		add: ([ :att | att orgName ] value: user);
		add: '660.00 Euros';
		add: 'Not Paid';
		add: 'Not Checked';
		yourself ]
]

{ #category : #rendering }
ERAttendeeList >> exportAttends [
]

{ #category : #rendering }
ERAttendeeList >> headers [
	^ #(
'#Invoice (D)'	'Name'	 'Email'	'Country'	'Affiliation	' 'Fee'	'Has Paid?'	'Checked?' '')
]

{ #category : #rendering }
ERAttendeeList >> listDataToRenderButton [
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
				with: [ :user | self modifyUserFormGroup: user ]
				with: [ :user | user id , '-modifyUser' ]);
		add:
			(Array with: 'Reset Password' with: [ nil ] with: [ :user | user id , '-resetPassword' ]);
		add:
			(Array
				with: 'Apply Reduction'
				with: [ nil ]
				with: [ :user | user id , '-applyReduction' ]);
		add: (Array with: 'Invoice' with: [ nil ] with: [ :user | user id , '-invoice' ]);
		yourself
]

{ #category : #rendering }
ERAttendeeList >> registerAttendee [
]

{ #category : #rendering }
ERAttendeeList >> registerMyselfAsAttendee [
]

{ #category : #rendering }
ERAttendeeList >> renderButtons: html [
	self
		createColoredAnchorButton: 'REGISTER ATTENDEE'
		with: [ self registerAttendee ]
		id: 'registerAttendee'
		on: html.
	self
		createColoredAnchorButton: 'REGISTER MYSELF AS ATTENDEE'
		with: [ self registerMyselfAsAttendee ]
		id: 'registerMyseflAsAttendee'
		on: html.
	self
		createColoredAnchorButton: 'EXPORT'
		with: [ self exportAttends ]
		id: 'exportAttends'
		on: html
]

{ #category : #rendering }
ERAttendeeList >> renderContainer: html [
	self renderButtons: html.
	html horizontalRule.
	self renderTableOfAttends: html
]

{ #category : #rendering }
ERAttendeeList >> renderTableOfAttends: html [
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
ERAttendeeList >> tabId [
	^ 'attendees'
]

{ #category : #accessing }
ERAttendeeList >> tabName [
	^ 'Attendees'
]

{ #category : #accessing }
ERAttendeeList >> title [
	^ 'Attendees'
]
