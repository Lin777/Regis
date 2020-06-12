"
Description
--------------------

Tab to render all Invoices of ESUG page in a table.
"
Class {
	#name : #ERInvoices,
	#superclass : #ERInvoicesTab,
	#instVars : [
		'encodeZipFile'
	],
	#category : #'ESUGApp-View-Tab'
}

{ #category : #tableBlock }
ERInvoices >> blockTableToExecute [
	"Render table information"
	
	^ [ :anTicket :html | 
	OrderedCollection new
		add: ([ :att | att invoiceNumber ] value: anTicket);
		add: ([ :att | att firstName , ' ', att lastName ] value: anTicket);
		add: ([ :att | att organizationName ] value: anTicket);
		add: ([ :att | att organizationAddress1 ] value: anTicket);
		add: ([ :att | att paymentInformation paymentAmount asString, ' €' ] value: anTicket);
		add: ([ :att :aHtml | [ 
					html form: [
						aHtml mdlCheckbox
							id: att id, '-hasPaid';
							value: att paymentInformation hasPaid;
							onTrue: [ controller stateUpdatePaidAttendee: att with: true ]
							onFalse: [ controller stateUpdatePaidAttendee: att with: false ];
							onChange: (html jQuery ajax serializeForm) ] ] ] 
					valueWithArguments: { anTicket. html });
		yourself ]
]

{ #category : #hooks }
ERInvoices >> children [
	"Render children elements"

	^ super children 
		asOrderedCollection 
		copyWithAll: (OrderedCollection new
							add: table;
							yourself) yourself
]

{ #category : #actions }
ERInvoices >> downloadInvoiceOf: user [
	
	self exportInvoiceOf: user
]

{ #category : #actions }
ERInvoices >> exportAllInvoices [
	"Export all invoices"
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
ERInvoices >> filterInvoicesInformation [

	^ [ :object :text | 
		((object invoiceNumber asString) includesSubstring: text caseSensitive: false)
			or: [ ((object firstName) includesSubstring: text caseSensitive: false)
			or: [ ((object lastName) includesSubstring: text caseSensitive: false)
			or: [ ((object organizationName) includesSubstring: text caseSensitive: false) 
			or: [ ((object organizationAddress1) includesSubstring: text caseSensitive: false) ] ] ] ] ]
]

{ #category : #accessing }
ERInvoices >> headers [
	^ { 'Number' . 'Fullname' . 'Org. Name' . 'Org. Address' . 'Fee' . PSTableSortableHeaderOptions new cell: 'Has paid' . PSTableSortableHeaderOptions new cell: '' }
]

{ #category : #accessing }
ERInvoices >> invoices [

	^ controller conference invoices 
		sort: [ :a :b | a paymentInformation invoiceNumber <
							 b paymentInformation invoiceNumber ]
]

{ #category : #tableBlock }
ERInvoices >> listDataToRenderButton [
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
ERInvoices >> renderButtonsOn: html [
	"Render buttons of invoice section"

	self renderExportAllInvoicesOn: html.
	self renderDownloadButton: html with:  (Dictionary new 
		at: 'id' put: 'downloadAllInvoices';
		at: 'disabled' put: (encodeZipFile isNil or: [ self invoices isEmpty ]);
		at: 'encodeFile' put: 'data:text/zip;base64,', (encodeZipFile ifNil: [ '' ]);
		at: 'nameFile' put: 'Invoices.zip';
		at: 'nameButton' put: 'Download Invoices';
		yourself).
]

{ #category : #rendering }
ERInvoices >> renderContainerOn: html [
	html form
		method: 'post';
		id: 'formAllInvoices';
		with: [ self renderButtonsOn: html.
			html horizontalRule ].
		self renderTableOfInvoicesOn: html
]

{ #category : #rendering }
ERInvoices >> renderExportAllInvoicesOn: html [

	html mdlAnchorButton colored;
		id: 'exportAllInvoices';
		disabled: self invoices isEmpty;
		callback: [ self exportAllInvoices ];
		with: 'EXPORT ALL INVOICES'.
]

{ #category : #rendering }
ERInvoices >> renderTableOfInvoicesOn: html [

	table := ERTable new
		tableId: 'invoices-table';
		header: self headers;
		limitPageShowed: 3;
		levelTotal: 6;
		validation: self filterInvoicesInformation;
		rows: self invoices;
		blockToExecute: self blockTableToExecute;
		listToRenderButton: self listDataToRenderButton;
		sortingMethod: self sortingMethodInvoices.
	html render: table
]

{ #category : #accessing }
ERInvoices >> sortingMethodInvoices [
	^ { [ :att | att invoiceNumber ] 
		. [ :att | att firstName , ' ', att lastName ]
		. [ :att | att organizationName ]
		. [ :att | att organizationAddress1 ]
		. [ :att | att paymentInformation paymentAmount asString, ' €' ]
		. [ :att |  ] }
]

{ #category : #accessing }
ERInvoices >> tabId [

	^ 'invoices'
]

{ #category : #accessing }
ERInvoices >> tabName [

	^ 'Invoices'
]

{ #category : #accessing }
ERInvoices >> title [

	^ 'Invoices'
]
