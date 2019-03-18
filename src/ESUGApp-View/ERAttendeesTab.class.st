Class {
	#name : #ERAttendeesTab,
	#superclass : #ERConfigurationTab,
	#instVars : [
		'encodeCSVFile',
		'encodeZipFile'
	],
	#category : #'ESUGApp-View-Tab'
}

{ #category : #rendering }
ERAttendeesTab >> attends [
	^ controller attends
]

{ #category : #rendering }
ERAttendeesTab >> blockTableToExecute [
	^ [ :user :html | 
	OrderedCollection new
		add: ([ :att | att paymentInformation invoiceNumber ] value: user);
		add: ([ :att | att userAccount firstName ] value: user);
		add: ([ :att | att userAccount email ] value: user);
		add: ([ :att | att contactInformation country ] value: user);
		add: ([ :att | att affiliationInformation organizationName ] value: user);
		add: ([ :att | att paymentInformation paymentAmount asString
			, ' ', att paymentInformation paymentCurrency, '(s)'  ] value: user);
		add: ([ :att :aHtml | [ aHtml mdlCheckbox
				value: att userAccount isStudent;
				onTrue: [ controller convertToStudentVolunterThis: att ] 
				onFalse: [ controller deleteStudentVolunterRoleFrom: att];
				onChange: (html jQuery ajax serializeForm).
				] ] valueWithArguments: {user. html});
		yourself ]
]

{ #category : #rendering }
ERAttendeesTab >> deleteAttendee: anAttendee [
	controller user: self session user.
	controller deleteAttendee: anAttendee.
	self updateStateTab: self tabName.
]

{ #category : #rendering }
ERAttendeesTab >> dictToRenderDownloadButton [
	^ Dictionary new	yourself
]

{ #category : #rendering }
ERAttendeesTab >> exportAttends [
	| file |
	file := controller exportAttends: 'attends'.
	self exportFile: file wihtName: 'attends.csv'
]

{ #category : #rendering }
ERAttendeesTab >> headers [
	^ #('#Invoice'	'Name'	 'Email'	'Country'	'Affiliation	' 'Fee' 'Is Volunter?' '')
]

{ #category : #rendering }
ERAttendeesTab >> listDataToRenderButton [
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
				with: [ :user | self deleteAttendee: user ]
				with: [ :user | user id , '-delete' ]
				with: 'Delete'
				with: 'return confirm(''Are you sure you want to delete this item?'');');
		add:
			(Array
				with: 'person'
				with: [ :user | self modifyUserFormGroup: user userAccount]
				with: [ :user | user id , '-modifyUser' ]
				with: 'Modify User'
				with: '');
		add:
			(Array
				with: 'payment'
				with: [ :user | self applyReductionTicketTo: user ]
				with: [ :user | user id , '-applyReduction' ]
				with: 'Apply reduction'
				with: '');
		add:
			(Array
				with: 'send'
				with: [ :user | self sendInvoiceTo: user ]
				with: [ :user | user id , '-sendInvoice' ]
				with: 'Send invoice'
				with: '');
		yourself
]

{ #category : #rendering }
ERAttendeesTab >> renderButtonsOn: html [
	html mdlAnchorButton
		colored;
		id: 'exportAttends';
		callback: [ self exportAttends ];
		with: 'EXPORT'
]

{ #category : #rendering }
ERAttendeesTab >> renderContainerOn: html [
	html form
		method: 'post';
		id: 'formAllAttends';
		with: [ self renderButtonsOn: html.
			html horizontalRule.
			html render: messageComponent .
			self renderTableOfAttendsOn: html ]
]

{ #category : #rendering }
ERAttendeesTab >> renderTableOfAttendsOn: html [
	table := ERTable new
		headers: self headers;
		levelTotal: 6;
		listObject: self attends;
		blockToExecute: self blockTableToExecute;
		listToRenderButton: self listDataToRenderButton;
		dictToRenderDownloadButton: self dictToRenderDownloadButton.
	html render: table
]

{ #category : #rendering }
ERAttendeesTab >> sendInvoiceTo: user [
	[controller sendInvoiceTo: user.
	self updateStateTab: self tabName.]
	on: Exception
	do: [ :exception | messageComponent errorMessage: exception messageText.
		self updateStateTab: self tabName]
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
