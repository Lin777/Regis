Class {
	#name : #ERAttendeesTab,
	#superclass : #ERConfigurationTab,
	#category : #'ESUGApp-View-Tab'
}

{ #category : #rendering }
ERAttendeesTab >> attends [
	^ controller attends
]

{ #category : #rendering }
ERAttendeesTab >> blockTableToExecute [
	^ [ :user | 
	OrderedCollection new
		add: '10';
		add: ([ :att | att firstName ] value: user);
		add: ([ :att | att email ] value: user);
		add: ([ :att | att country ] value: user);
		add: ([ :att | att orgName ] value: user);
		add: ([ :att | (controller conferenceFeeFor: att) asString
			, ' ', att paymentCurrency, '(s)'  ] value: user);
		add: 'Not Paid';
		add: 'Not Checked';
		yourself ]
]

{ #category : #rendering }
ERAttendeesTab >> deleteAttendeeFromGroup: user [
]

{ #category : #rendering }
ERAttendeesTab >> exportAttends [
controller exportAttends: 'attends' .
	self updateStateTab: self tabName.
]

{ #category : #rendering }
ERAttendeesTab >> generateInvoice: user [
]

{ #category : #rendering }
ERAttendeesTab >> headers [
	^ #(
'#Invoice (D)'	'Name'	 'Email'	'Country'	'Affiliation	' 'Fee'	'Has Paid?'	'Checked?' '')
]

{ #category : #rendering }
ERAttendeesTab >> listDataToRenderButton [
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
			(Array with: 'Reset Password' 
			with: [ :user | self resetPassword: user ] 
			with: [ :user | user id , '-resetPassword' ]);
		add:
			(Array
				with: 'Apply Reduction'
				with: [ :user | self applyReductionTicketTo: user ]
				with: [ :user | user id , '-applyReduction' ]);
		add: (Array with: 'Invoice' 
				with: [ :user | self generateInvoice: user ] 
				with: [ :user | user id , '-invoice' ]);
		yourself
]

{ #category : #rendering }
ERAttendeesTab >> registerAdminAsAttendee [
	(ERRegistrationController attendee: attendee) validateRegister .
	controller registerAsAttendee.
	content state: content lastState
]

{ #category : #rendering }
ERAttendeesTab >> registerAttendee [
	callback := [ self registerAttendeeToConference ].
	super registerAttendee.
	self updateStateTab: self tabName. 
]

{ #category : #initialization }
ERAttendeesTab >> registerAttendeeToConference [
	(ERRegistrationController attendee: newAttendee) validateRegister.
	controller addAttendee: newAttendee.
	content state: content lastState
]

{ #category : #rendering }
ERAttendeesTab >> registerMyselfAsAttendee [
	callback := [ self registerAdminAsAttendee ].
			self initializeFormWithoutBasicInformationFor: attendee.
	self updateStateTab: self tabName.
]

{ #category : #rendering }
ERAttendeesTab >> renderButtons: html [
	self
		createColoredAnchorButton: 'REGISTER ATTENDEE'
		with: [ self registerAttendee ]
		id: 'registerAttendee'
		on: html.
	self alreadyRegisteredAsAttendee
		ifFalse: [ self
				createColoredAnchorButton: 'REGISTER MYSELF AS ATTENDEE'
				with: [ self registerMyselfAsAttendee ]
				id: 'registerMyseflAsAttendee'
				on: html ].
	self
		createColoredAnchorButton: 'EXPORT'
		with: [ self exportAttends ]
		id: 'exportAttends'
		on: html
]

{ #category : #rendering }
ERAttendeesTab >> renderContainer: html [
	html form
		method: 'post';
		id: 'formAllAttends';
		with: [ self renderButtons: html.
			html horizontalRule.
			self renderTableOfAttends: html ]
]

{ #category : #rendering }
ERAttendeesTab >> renderTableOfAttends: html [
	| table |
	table := ERTable new
		headers: self headers;
		levelTotal: 6;
		listObject: self attends;
		blockToExecute: self blockTableToExecute;
		listToRenderButton: self listDataToRenderButton.
	html render: table
]

{ #category : #rendering }
ERAttendeesTab >> resetPassword: user [
]

{ #category : #accessing }
ERAttendeesTab >> tabId [
	^ 'attendees'
]

{ #category : #accessing }
ERAttendeesTab >> tabName [
	^ 'Attendees'
]

{ #category : #accessing }
ERAttendeesTab >> title [
	^ 'Attendees'
]
