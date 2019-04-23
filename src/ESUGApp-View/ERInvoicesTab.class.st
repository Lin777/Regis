"
Description
--------------------

Tab to render all Invoices of ESUG page in a table.
"
Class {
	#name : #ERInvoicesTab,
	#superclass : #ERConfigurationTab,
	#instVars : [
		'encodeZipFile'
	],
	#category : #'ESUGApp-View-Tab'
}

{ #category : #tableBlock }
ERInvoicesTab >> blockTableToExecute [
	^ [ :anTicket :html | 
	OrderedCollection new
		add: ([ :att | att invoiceNumber ] value: anTicket);
		add: ([ :att | att firstName , ' ', att lastName ] value: anTicket );
		add: ([ :att | att organizationName ] value: anTicket );
		add: ([ :att | att organizationAddress1 ] value: anTicket);
		add: ([ :att | att paymentInformation paymentAmount ] value: anTicket);
		add: ([ :att :aHtml | [ aHtml mdlCheckbox
				id: att id, '-hasPaid';
				value: att paymentInformation hasPaid;
				onTrue: [ controller stateUpdatePaidAttendee: att with: true ] 
				onFalse: [ controller stateUpdatePaidAttendee: att with: false];
				onChange: (html jQuery ajax serializeForm).
				] ] valueWithArguments: {anTicket. html});
		yourself ]
]

{ #category : #hooks }
ERInvoicesTab >> children [
	^ super children asOrderedCollection copyWithAll: (OrderedCollection new
		add: table;
		yourself) yourself
]

{ #category : #actions }
ERInvoicesTab >> downloadInvoiceOf: user [
	
	self exportInvoiceOf: user
]

{ #category : #actions }
ERInvoicesTab >> exportAllInvoices [
	| nameZipFile subDir |
	nameZipFile := 'Invoices'.
	subDir := 'DirectoryInvoices'.
	ERPDFInvoice demoPath: subDir, '/'.
	self invoices do: [ :anObject | 
		ERPDFInvoice templateRegistrationInvoice: anObject
	].
	encodeZipFile := controller codingZipFile: nameZipFile with: subDir.

	self updateStateTab: self tabName.
]

{ #category : #accessing }
ERInvoicesTab >> headers [
	^ #('Number' 'Fullname' 'Org. Name' 'Org. Address' 'Payment amount' 'Has paid?' '')
]

{ #category : #accessing }
ERInvoicesTab >> invoices [
	^ controller conference invoices 
		sort: [ :a :b | a paymentInformation invoiceNumber <
							 b paymentInformation invoiceNumber ]
]

{ #category : #tableBlock }
ERInvoicesTab >> listDataToRenderButton [
	^ OrderedCollection new 
		add:
			(Array
				with: 'get_app'
				with: [ :invoice | self downloadInvoiceOf: invoice ]
				with: [ :invoice | invoice id , '-export' ]
				with: 'Download invoice'
				with: ''
				with: false);
		yourself
]

{ #category : #rendering }
ERInvoicesTab >> renderButtonsOn: html [
	self renderExportAllInvoicesOn: html.
		
	self renderDownloadButton: html with:  (Dictionary new 
		at: 'id' put: 'downloadAllInvoices';
		at: 'disabled' put: encodeZipFile isNil;
		at: 'encodeFile' put: 'data:text/zip;base64,', (encodeZipFile ifNil: ['']);
		at: 'nameFile' put: 'Invoices.zip';
		at: 'nameButton' put: 'Download Invoices';
		yourself).
]

{ #category : #rendering }
ERInvoicesTab >> renderContainerOn: html [
	html form
		method: 'post';
		id: 'formAllInvoices';
		with: [ self renderButtonsOn: html.
			html horizontalRule.
			self renderTableOfInvoicesOn: html ]
]

{ #category : #rendering }
ERInvoicesTab >> renderExportAllInvoicesOn: html [
	html mdlAnchorButton colored;
		id: 'exportAllInvoices';
		disabled: self invoices isEmpty;
		callback: [ self exportAllInvoices ];
		with: 'EXPORT ALL INVOICES'.
]

{ #category : #rendering }
ERInvoicesTab >> renderTableOfInvoicesOn: html [
	table := ERTable new
		headers: self headers;
		levelTotal: 6;
		listObject: self invoices;
		blockToExecute: self blockTableToExecute;
		listToRenderButton: self listDataToRenderButton.
	html render: table
]

{ #category : #accessing }
ERInvoicesTab >> tabId [
	^ 'invoices'
]

{ #category : #accessing }
ERInvoicesTab >> tabName [
	^ 'Invoices'
]

{ #category : #accessing }
ERInvoicesTab >> title [
	^ 'Invoices'
]
