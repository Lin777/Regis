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
	^ [ :user | 
	OrderedCollection new
		add: '10';
		add: ([ :att | att firstName ] value: user);
		add: ([ :att | att email ] value: user);
		add: ([ :att | att country ] value: user);
		add: ([ :att | att orgName ] value: user);
		add: ([ :att | (controller conferenceFeeFor: att) asString
			, ' ', att paymentCurrency, '(s)'  ] value: user);
		add: ([ :att | att hasPaid ] value: user);
		yourself ]
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
ERAttendeesTab >> deleteAttendeeFromGroup: user [
]

{ #category : #'as yet unclassified' }
ERAttendeesTab >> exportAllInvoices [
	| nameFile zip subDir zipFile |
	zip := ZipArchive new.
	nameFile := 'Invoices'.
	subDir := nameFile asFileReference.
	subDir ensureCreateDirectory.
	zip addDirectory: subDir fullName.
	zipFile := nameFile asFileReference, 'zip'.
	self cleanZip: zip with: zipFile subDir: subDir. 
	ERPDFInvoice demoPath: nameFile, '/'.
	self attends do: [ :attend | 
		zip addFile: (ERPDFInvoice templateRegistrationInvoice: attend) path pathString.
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
ERAttendeesTab >> generateInvoice: user [
	| file |
	file := ERPDFInvoice templateRegistrationInvoice: user.
	user encodedInvoice: (self encodeFiletoBase64: file).
	user save.
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
				with: [ :user | user id , '-modify' ]);
		add:
			(Array
				with: 'delete'
				with: [ :user | self deleteAttendeeFromGroup: user ]
				with: [ :user | user id , '-delete' ]);
		add:
			(Array
				with: 'person'
				with: [ :user | self modifyUserFormGroup: user ]
				with: [ :user | user id , '-modifyUser' ]);
		add:
			(Array with: 'replay' 
			with: [ :user | self resetPassword: user ] 
			with: [ :user | user id , '-resetPassword' ]);
		add:
			(Array
				with: 'payment'
				with: [ :user | self applyReductionTicketTo: user ]
				with: [ :user | user id , '-applyReduction' ]);
		add: 
			(Array 
				with: 'description' 
				with: [ :user | self generateInvoice: user ]
				with: [ :user | user id , '-invoice' ]
				with: [ :user | user hasPaid ]);
		yourself
]

{ #category : #rendering }
ERAttendeesTab >> listDataToRenderDownloadButton [
	^ OrderedCollection new
		add: (Array with: 'get_app' 
			with: [ :user | user id , '-get_app' ]
			with: [ :user | 'RegistrationInvoice_', user id, '.pdf']
			with: [ :user | 'data:text/pdf;base64,', (user encodedInvoice ifNil: [ '' ]) ]);
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
		on: html.
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
	"html mdlAnchorButton 
		url:'data:text/pdf;base64,', self encodeBase64; 
		attributeAt: 'download' put: 'RegistrationInvoice.pdf';
		with: 'download me'."
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
		listToRenderButton: self listDataToRenderButton;
		listToRenderDownloadButton: self listDataToRenderDownloadButton.
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
