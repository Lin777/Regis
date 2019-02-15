Class {
	#name : #ERInvoicesTab,
	#superclass : #ERConfigurationTab,
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

{ #category : #accessing }
ERInvoicesTab >> headers [
	^ #('Number' 'Fullname' 'Org. Name' 'Org. Address' 'Payment amount' 'Has paid?')
]

{ #category : #rendering }
ERInvoicesTab >> invoices [
	^ controller invoices
]

{ #category : #rendering }
ERInvoicesTab >> listDataToRenderButton [
	^ OrderedCollection new
]

{ #category : #rendering }
ERInvoicesTab >> renderContainer: html [
	html form
		method: 'post';
		id: 'formAllInvoices';
		with: [ html horizontalRule.
			self renderTableOfInvoices: html ]
]

{ #category : #rendering }
ERInvoicesTab >> renderTableOfInvoices: html [
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
