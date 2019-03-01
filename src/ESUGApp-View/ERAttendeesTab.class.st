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
		"add: ([ :att :aHtml | [ aHtml mdlCheckbox 
				disabled: att idGroup isNotNil;
				value: att paymentInformation hasPaid;
				onTrue: [ controller stateUpdatePaidAttendee: att with: true ] 
				onFalse: [ controller stateUpdatePaidAttendee: att with: false ];
				onChange: (html jQuery ajax serializeForm).
				] ] valueWithArguments: {user. html});"
		yourself ]
]

{ #category : #rendering }
ERAttendeesTab >> deleteAttendee: anAttendee [
	controller user: self session user.
	controller deleteAttendee: anAttendee
]

{ #category : #rendering }
ERAttendeesTab >> dictToRenderDownloadButton [
	^ Dictionary new"
		at: 'icon' put: 'get_app';
		at: 'id' put: [ :attend | attend id , '-get_app' ];
		at: 'disabled' put: [ :attend | (attend encodedInvoice isNotNil and: [ attend paymentInformation hasPaid ]) not ];
		at: 'download' put: [ :attend | 'RegistrationInvoice_', attend id, '.pdf'];
		at: 'url' put: [ :attend | 'data:text/pdf;base64,', (attend encodedInvoice ifNil: [ '' ]) ];"
		yourself
]

{ #category : #'as yet unclassified' }
ERAttendeesTab >> exportAllInvoices [
	| nameZipFile subDir groupAttendee |
	nameZipFile := 'Invoices'.
	subDir := 'DirectoryInvoices'.
	ERPDFInvoice demoPath: subDir, '/'.
	self attends select: [ :attend | attend paymentInformation hasPaid ] 
	thenDo: [ :attend | 
		groupAttendee := controller getGroupOfAttendee: attend.
		groupAttendee ifNil: [ ERPDFInvoice templateRegistrationInvoice: attend ] 
		ifNotNil: [ ERPDFInvoice templateRegistrationInvoice: groupAttendee ]
	].
	encodeZipFile := controller codingZipFile: nameZipFile with: subDir.

	self updateStateTab: self tabName.
]

{ #category : #rendering }
ERAttendeesTab >> exportAttends [
	| file |
	file := controller exportAttends: 'attends'.
	self exportFile: file wihtName: 'attends.csv'
]

{ #category : #rendering }
ERAttendeesTab >> headers [
	^ #(
'#Invoice'	'Name'	 'Email'	'Country'	'Affiliation	' 'Fee' '')
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
		"add: 
			(Array 
				with: 'description' 
				with: [ :user | self generateInvoice: user ]
				with: [ :user | user id , '-invoice' ]
				with: 'Generate invoice'
				with: '');"
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
