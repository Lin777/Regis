"
Description
-----------

I am the view to render all attendees with a specific reduction ticket
"
Class {
	#name : #ERAttendeesOfTicketView,
	#superclass : #ERTittledView,
	#instVars : [
		'ticket',
		'tableComponent'
	],
	#category : #'ESUGApp-View-View'
}

{ #category : #'as yet unclassified' }
ERAttendeesOfTicketView class >> on: anAttendee withContent: aContent [
	| form |
	form := self new.
	form ticket: anAttendee.
	form content: aContent.
	^ form
]

{ #category : #rendering }
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
		add: ([ :att | (self paymentToString: att paymentInformation hasPaid) ] value: user);
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

{ #category : #rendering }
ERAttendeesOfTicketView >> filterAttendeesWithTicket [

	^ [ :object :text | 
		((object userAccount firstName) includesSubstring: text caseSensitive: false)
			or: [ ((object userAccount email) includesSubstring: text caseSensitive: false) 
			or: [ ((object affiliationInformation organizationCountry) includesSubstring: text caseSensitive: false) 
			or: [ ((object affiliationInformation organizationName) includesSubstring: text caseSensitive: false) ] ] ] ]
]

{ #category : #accessing }
ERAttendeesOfTicketView >> headers [
	^ #('#Invoice'	'Name'	 'Email'	'Country'	'Affiliation	' 'Fee'	'Has Paid?' '')
]

{ #category : #accessing }
ERAttendeesOfTicketView >> listDataToRenderButton [
	^ OrderedCollection new
]

{ #category : #accessing }
ERAttendeesOfTicketView >> listOfAttendees [
	^ controller conference attendeesForATicket: ticket ticketId
]

{ #category : #accessing }
ERAttendeesOfTicketView >> paymentToString: aBoolean [

	aBoolean
		ifTrue: [ ^ 'Yes' ]
		ifFalse: [ ^ 'No' ]
]

{ #category : #rendering }
ERAttendeesOfTicketView >> renderButtonsOn: html [
	html mdlAnchorButton
        colored;
        id: 'accept';
        callback: cancelCallback;
        with: 'Back'
]

{ #category : #rendering }
ERAttendeesOfTicketView >> renderPageOn: html [
	| list |
	list := self listOfAttendees.
	list isEmpty 
		ifTrue: [ html heading level5 with: 'This ticket is currently not used by any assistant' ]
		ifFalse: [ self renderTableOfAttendsWith: list on: html ].
	html horizontalRule .
	self renderButtonsOn: html
]

{ #category : #rendering }
ERAttendeesOfTicketView >> renderTableOfAttendsWith: aList on: html [
	tableComponent := ERTable new
		tableId: 'attendsInvoice';
		headers: self headers;
		validation: self filterAttendeesWithTicket;
		limitPerPage: 15;
		limitPageShowed: 3;
		levelTotal: 6;
		listObject: aList ;
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
