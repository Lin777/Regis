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
		add: ([ :att | (controller conferenceFeeFor: att) asString
			, ' ', att paymentInformation paymentCurrency, '(s)'  ] value: user);
		add: ([ :att :aHtml | [ aHtml mdlCheckbox 
				value: att paymentInformation hasPaid;
				onTrue: [ controller stateUpdatePaidAttendee: att with: true ] 
				onFalse: [ controller stateUpdatePaidAttendee: att with: false ];
				onChange: (html jQuery ajax serializeForm).
				] ] valueWithArguments: {user. html});
		yourself ]
]

{ #category : #rendering }
ERAttendeesTab >> children [
	^ OrderedCollection new
		add: table;
		yourself
]

{ #category : #'as yet unclassified' }
ERAttendeesTab >> cleanZip: zip with: zipFile subDir: subDir [
	[ zip close ]
		ensure: [ 
			subDir ensureDeleteAll.
			zipFile ensureDelete.	
		]
]

{ #category : #rendering }
ERAttendeesTab >> deleteAttendee: user [
]

{ #category : #rendering }
ERAttendeesTab >> dictToRenderDownloadButton [
	^ Dictionary new
		at: 'icon' put: 'get_app';
		at: 'id' put: [ :attend | attend id , '-get_app' ];
		at: 'disabled' put: [ :attend | (attend encodedInvoice isNotNil and: [ attend paymentInformation hasPaid ]) not ];
		at: 'download' put: [ :attend | 'RegistrationInvoice_', attend id, '.pdf'];
		at: 'url' put: [ :attend | 'data:text/pdf;base64,', (attend encodedInvoice ifNil: [ '' ]) ];
		yourself
]

{ #category : #'as yet unclassified' }
ERAttendeesTab >> exportAllInvoices [
	| nameFile zip subDir zipFile groupAttendee |
	zip := ZipArchive new.
	nameFile := 'Invoices'.
	subDir := nameFile asFileReference.
	subDir ensureCreateDirectory.
	zip addDirectory: subDir fullName.
	zipFile := nameFile asFileReference, 'zip'.
	self cleanZip: zip with: zipFile subDir: subDir. 
	ERPDFInvoice demoPath: nameFile, '/'.
	self attends select: [ :attend | attend paymentInformation hasPaid ] 
	thenDo: [ :attend | 
		groupAttendee := controller getGroupOfAttendee: attend.
		zip addFile: (groupAttendee ifNil: [ (ERPDFInvoice templateRegistrationInvoice: attend) path pathString ] 
		ifNotNil: [ (ERPDFInvoice templateRegistrationInvoice: groupAttendee) path pathString ])	
	].
	zip writeToFileNamed: zipFile fullName.
	encodeZipFile := self encodeFiletoBase64: zipFile.
	self cleanZip: zip with: zipFile subDir: subDir.

	self updateStateTab: self tabName.
]

{ #category : #rendering }
ERAttendeesTab >> exportAttends [
	| file |
	file := controller exportAttends: 'attends'.
	encodeCSVFile := self encodeFileToUTF8: file.
	file ensureDelete.
	self updateStateTab: self tabName.
]

{ #category : #rendering }
ERAttendeesTab >> headers [
	^ #(
'#Invoice'	'Name'	 'Email'	'Country'	'Affiliation	' 'Fee'	'Has Paid?' '')
]

{ #category : #rendering }
ERAttendeesTab >> listDataToRenderButton [
	^ OrderedCollection new
		add:
			(Array
				with: 'edit'
				with: [ :user | self modifyRegistrationInformation: user ]
				with: [ :user | user id , '-modify' ]
				with: 'Modify');
		add:
			(Array
				with: 'delete'
				with: [ :user | self deleteAttendee: user ]
				with: [ :user | user id , '-delete' ]
				with: 'Delete');
		add:
			(Array
				with: 'person'
				with: [ :user | self modifyUserFormGroup: user userAccount]
				with: [ :user | user id , '-modifyUser' ]
				with: 'Modify User');
		add:
			(Array
				with: 'payment'
				with: [ :user | self applyReductionTicketTo: user ]
				with: [ :user | user id , '-applyReduction' ]
				with: 'Apply reduction');
		add: 
			(Array 
				with: 'description' 
				with: [ :user | self generateInvoice: user ]
				with: [ :user | user id , '-invoice' ]
				with: 'Generate invoice');
		yourself
]

{ #category : #rendering }
ERAttendeesTab >> renderButtons: html [
	html mdlAnchorButton
		colored;
		id: 'exportAttends';
		callback: [ self exportAttends ];
		with: 'EXPORT'.
	self renderDownloadButton: html with:  (Dictionary new 
		at: 'id' put: 'downloadDataAttendees';
		at: 'disabled' put: encodeCSVFile isNil;
		at: 'encodeFile' put: 'data:text/csv;charset=utf-8,', (encodeCSVFile ifNil: ['']);
		at: 'nameFile' put: 'dataAttendees.csv';
		at: 'nameButton' put: 'Download';
		yourself).
	html mdlAnchorButton colored;
		id: 'exportAllInvoices';
		disabled: self attends isEmpty;
		callback: [ self exportAllInvoices ];
		with: 'EXPORT ALL INVOICES'.
	self renderDownloadButton: html with:  (Dictionary new 
		at: 'id' put: 'downloadAllInvoices';
		at: 'disabled' put: encodeZipFile isNil;
		at: 'encodeFile' put: 'data:text/zip;base64,', (encodeZipFile ifNil: ['']);
		at: 'nameFile' put: 'Invoices.zip';
		at: 'nameButton' put: 'Download Invoices';
		yourself).
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
