Class {
	#name : #ERInvoicesTab,
	#superclass : #ERConfigurationTab,
	#instVars : [
		'encodeZipFile'
	],
	#category : #'ESUGApp-View-Tab'
}

{ #category : #rendering }
ERInvoicesTab >> blockTableToExecute [
	^ [ :anTicket :html | 
	OrderedCollection new
		add: ([ :att | att invoiceNumber ] value: anTicket);
		add: ([ :att | att firstName , ' ', att lastName ] value: anTicket );
		add: ([ :att | att organizationName ] value: anTicket );
		add: ([ :att | att organizationAddress1 ] value: anTicket);
		add: ([ :att | att paymentInformation paymentAmount ] value: anTicket);
		add: ([ :att :aHtml | [ aHtml mdlCheckbox
				value: att paymentInformation hasPaid;
				onTrue: [ controller stateUpdatePaidAttendee: att with: true ] 
				onFalse: [ controller stateUpdatePaidAttendee: att with: false ];
				onChange: (html jQuery ajax serializeForm).
				] ] valueWithArguments: {anTicket. html});
		yourself ]
]

{ #category : #hooks }
ERInvoicesTab >> children [
	^ OrderedCollection new
		add: table;
		yourself
]

{ #category : #rendering }
ERInvoicesTab >> dictToRenderDownloadButton [
	^ Dictionary new
		at: 'icon' put: 'get_app';
		at: 'id' put: [ :attend | attend id , '-get_invoice' ];	
		at: 'download' put: [ :attend | 'RegistrationInvoice_', attend id, '.pdf'];
		at: 'url' put: [ :attend | 'data:text/pdf;base64,', (attend encodedInvoice ifNil: [ '' ]) ];
		yourself
]

{ #category : #accessing }
ERInvoicesTab >> headers [
	^ #('Number' 'Fullname' 'Org. Name' 'Org. Address' 'Payment amount' 'Has paid?')
]

{ #category : #rendering }
ERInvoicesTab >> invoices [
	^ controller invoices 
		sort: [ :a :b | a paymentInformation invoiceNumber <
							 b paymentInformation invoiceNumber ]
]

{ #category : #rendering }
ERInvoicesTab >> listDataToRenderButton [
	^ OrderedCollection new yourself
]

{ #category : #rendering }
ERInvoicesTab >> renderButtonsOn: html [
	html mdlAnchorButton colored;
		id: 'exportAllInvoices';
		disabled: self invoices isEmpty;
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
ERInvoicesTab >> renderContainer: html [
	html form
		method: 'post';
		id: 'formAllInvoices';
		with: [ self renderButtonsOn: html.
			html horizontalRule.
			self renderTableOfInvoices: html ]
]

{ #category : #rendering }
ERInvoicesTab >> renderTableOfInvoices: html [
	table := ERTable new
		headers: self headers;
		levelTotal: 6;
		listObject: self invoices;
		blockToExecute: self blockTableToExecute;
		listToRenderButton: self listDataToRenderButton;
		dictToRenderDownloadButton: self dictToRenderDownloadButton.
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
