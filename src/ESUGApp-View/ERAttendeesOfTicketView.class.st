Class {
	#name : #ERAttendeesOfTicketView,
	#superclass : #ERTittledView,
	#instVars : [
		'ticket',
		'tableComponent'
	],
	#category : #'ESUGApp-View'
}

{ #category : #'as yet unclassified' }
ERAttendeesOfTicketView class >> on: anAttendee withContent: aContent [
	| form |
	form := self new.
	form ticket: anAttendee.
	form content: aContent.
	^ form
]

{ #category : #accessing }
ERAttendeesOfTicketView >> blockTableToExecute [
	^ [ :user | 
	OrderedCollection new
		add: ([ :att | att paymentInformation invoiceNumber ] value: user);
		add: ([ :att | att userAccount firstName ] value: user);
		add: ([ :att | att userAccount email ] value: user);
		add: ([ :att | att affiliationInformation organizationCountry ] value: user);
		add: ([ :att | att affiliationInformation organizationName ] value: user);
		add: ([ :att | att paymentInformation paymentAmount asString
			, ' ', att paymentInformation paymentCurrency, '(s)' ] value: user);
		add: ([ :att | att paymentInformation hasPaid ] value: user);
		yourself ]
]

{ #category : #accessing }
ERAttendeesOfTicketView >> children [ 
	^ Array with: tableComponent
]

{ #category : #accessing }
ERAttendeesOfTicketView >> content: anObject [
	content := anObject
]

{ #category : #accessing }
ERAttendeesOfTicketView >> headers [
	^ #(
'#Invoice'	'Name'	 'Email'	'Country'	'Affiliation	' 'Fee'	'Has Paid?')
]

{ #category : #accessing }
ERAttendeesOfTicketView >> listDataToRenderButton [
	^ OrderedCollection new
]

{ #category : #accessing }
ERAttendeesOfTicketView >> listOfAttendees [
	^ ERController new attendeesForATicket: ticket ticketId
]

{ #category : #accessing }
ERAttendeesOfTicketView >> renderButtonsOn: html [
	html mdlAnchorButton
        colored;
        id: 'accept';
        callback: cancelCallback;
        with: 'Back'
]

{ #category : #accessing }
ERAttendeesOfTicketView >> renderPageOn: html [
	self listOfAttendees isEmpty ifTrue: [ html heading level5 with: 'This ticket is currently not used by any assistant' ]
	ifFalse: [self renderTableOfAttendsOn: html ].
	html horizontalRule .
	self renderButtonsOn: html
]

{ #category : #accessing }
ERAttendeesOfTicketView >> renderTableOfAttendsOn: html [
	tableComponent := ERTable new
		headers: self headers;
		levelTotal: 6;
		listObject: self listOfAttendees ;
		blockToExecute: self blockTableToExecute;
		listToRenderButton: self listDataToRenderButton.
	html render: tableComponent 
	
]

{ #category : #accessing }
ERAttendeesOfTicketView >> ticket [
	^ ticket
]

{ #category : #accessing }
ERAttendeesOfTicketView >> ticket: anObject [
	ticket := anObject 
]

{ #category : #accessing }
ERAttendeesOfTicketView >> title [
	^ 'Attendees of ', ticket ticketId asUppercase 
]
