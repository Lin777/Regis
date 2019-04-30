"
Description
--------------------

Tab to render all attendees of ESUG page in a table.
"
Class {
	#name : #ERAttendeesTab,
	#superclass : #ERConfigurationTab,
	#instVars : [
		'strategy'
	],
	#category : #'ESUGApp-View-Tab'
}

{ #category : #initialization }
ERAttendeesTab >> applyReductionTicketTo: user [
	self initializeApplyReductionTicketForm: user.
	content state: formApplyReductionTicket .
	self updateStateTab: self tabName.
]

{ #category : #accessing }
ERAttendeesTab >> attends [
	self strategyIsByPaidState ifTrue: [ ^ controller conference attendeesWhoPaid ].
	self strategyIsByUnpaidState ifTrue: [ ^ controller conference attendeesWhoDidNotPaid ].
	^ controller conference attends
	
	
]

{ #category : #tableBlock }
ERAttendeesTab >> blockTableToExecute [
	^ [ :user :html | 
	OrderedCollection new
		add: ([ :att | att paymentInformation invoiceNumber ] value: user);
		add: ([ :att | att userAccount firstName ] value: user);
		add: ([ :att | att userAccount email ] value: user);
		add: ([ :att | att affiliationInformation organizationCountry ] value: user);
		add: ([ :att | att affiliationInformation organizationName ] value: user);
		add: ([ :att | att paymentInformation paymentAmount asString
			, ' ', att paymentInformation paymentCurrency, '(s)'  ] value: user);
		add: ([ :att :aHtml | [ aHtml mdlCheckbox
				id: att id, '-isVolunter';
				value: att userAccount isStudent;
				onTrue: [ controller convertToStudentVolunterThis: att ] 
				onFalse: [ controller deleteStudentVolunterRoleFrom: att];
				onChange: (html jQuery ajax serializeForm).
				] ] valueWithArguments: {user. html});
		yourself ]
]

{ #category : #deleting }
ERAttendeesTab >> deleteAttendee: anAttendee [
	controller user: self session user.
	controller deleteAttendee: anAttendee.
	self updateStateTab: self tabName.
]

{ #category : #actions }
ERAttendeesTab >> exportAttends [
	| file fileName|
	fileName := self nameOfExportFile.
	file := controller conference exportAttends: self attends in: fileName.
	self exportFile: file wihtName: fileName, '.csv'
]

{ #category : #accessing }
ERAttendeesTab >> headers [
	^ #('#Invoice'	'Name'	 'Email'	'Country'	'Affiliation	' 'Fee' 'Is Volunter?' '')
]

{ #category : #rendering }
ERAttendeesTab >> initialize [ 	
	super initialize.
	strategy := 'All'.
]

{ #category : #initialization }
ERAttendeesTab >> initializeApplyReductionTicketForm: user [	
	| tickets |
	tickets := controller conference reductionTickets collect: #ticketId.
	tickets addFirst: 'No reduction ticket'.
	formApplyReductionTicket := (ERApplyReductionTicketView
		on: user
		withContent: content) 
		listOfTickets: tickets; 
		updateTicketAttendee: [ :ticket | self updateTicket: ticket from: user ]; 
		cancel: [ self returnToThePreviousState. 
			self updateStateTab: self tabName.]
]

{ #category : #tableBlock }
ERAttendeesTab >> listDataToRenderButton [
	^ OrderedCollection new
		add:
			(Array
				with: 'edit'
				with: [ :att | self modifyRegistrationInformation: att ]
				with: [ :att | att id , '-modify' ]
				with: 'Modify'
				with: ''
				with: false);
		add:
			(Array
				with: 'delete'
				with: [ :att | self deleteAttendee: att ]
				with: [ :att | att id , '-delete' ]
				with: 'Delete'
				with: 'return confirm(''Are you sure you want to delete this item?'');'
				with:  false);
		add:
			(Array
				with: 'person'
				with: [ :att | self modifyUserFormGroup: att userAccount]
				with: [ :att | att id , '-modifyUser' ]
				with: 'Modify User'
				with: ''
				with: false);
		add:
			(Array
				with: 'payment'
				with: [ :att | self applyReductionTicketTo: att ]
				with: [ :att | att id , '-applyReduction' ]
				with: 'Apply reduction'
				with: ''
				with:  false);
		add:
			(Array
				with: 'send'
				with: [ :att | self sendInvoiceTo: att]
				with: [ :att | att id , '-sendInvoice' ]
				with: 'Send invoice'
				with: ''
				with: false);
		yourself
]

{ #category : #actions }
ERAttendeesTab >> nameOfExportFile [
	self strategyIsByPaidState ifTrue: [ ^ 'attendeesWhoPaid' ].
	self strategyIsByUnpaidState ifTrue: [ ^ 'attendeesWhoDidNotPaid' ].
	^ 'attendees'
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
		with: [ 
			self renderSelectorWayToFilterOn: html.
			self renderButtonsOn: html.
			html horizontalRule.
			html render: messageComponent .
			html break.
			self renderTableOfAttendsOn: html ]
]

{ #category : #rendering }
ERAttendeesTab >> renderSelectorWayToFilterOn: html [
	html div class: 'half'; with: [
	html mdlTextFieldContainer
		style: 'display: block';
		floatingLabel;
		with: [ html mdlTextFieldLabel for: 'selectStrategy';
			 with: 'Strategy of Filter'.
			html select
				onChange: 'submit()';
				class: 'mdl-textfield__input';
				id: 'selectStrategy';
				list: #('All' 'Paid' 'Unpaid');
				selected: strategy;
				callback: [ :value | strategy := value.
					self updateStateTab: self tabName. ] ] ]
]

{ #category : #rendering }
ERAttendeesTab >> renderTableOfAttendsOn: html [
	table := ERTable new
		headers: self headers;
		levelTotal: 6;
		listObject: self attends;
		blockToExecute: self blockTableToExecute;
		listToRenderButton: self listDataToRenderButton;
		dictToRenderDownloadButton: Dictionary new.
	html render: table
]

{ #category : #actions }
ERAttendeesTab >> sendInvoiceTo: user [
	[controller sendInvoiceTo: user.
	self updateStateTab: self tabName.
	messageComponent class: 'alert-success'.
	messageComponent errorMessage: 'Sent succesfull']
	on: PMException
	do: [ :exception | 
		messageComponent class: 'errors'.
		messageComponent errorMessage: exception messageText.
		self updateStateTab: self tabName].
]

{ #category : #rendering }
ERAttendeesTab >> strategyIsAll [
	^ strategy = 'All'
]

{ #category : #rendering }
ERAttendeesTab >> strategyIsByPaidState [
	^ strategy = 'Paid'
]

{ #category : #rendering }
ERAttendeesTab >> strategyIsByUnpaidState [
	^ strategy = 'Unpaid'
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
