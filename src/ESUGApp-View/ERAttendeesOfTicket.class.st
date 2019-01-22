Class {
	#name : #ERAttendeesOfTicket,
	#superclass : #ERTittledView,
	#instVars : [
		'ticket'
	],
	#category : #'ESUGApp-View'
}

{ #category : #'as yet unclassified' }
ERAttendeesOfTicket class >> on: anAttendee withContent: aContent [
	| form |
	form := self new.
	form ticket: anAttendee.
	form content: aContent.
	^ form
]

{ #category : #accessing }
ERAttendeesOfTicket >> blockTableToExecute [
	^ [ :user | 
	OrderedCollection new
		add: '10';
		add: ([ :att | att firstName ] value: user);
		add: ([ :att | att email ] value: user);
		add: ([ :att | att country ] value: user);
		add: ([ :att | att orgName ] value: user);
		add: ([ :att | (ERController new conferenceFeeFor: att) asString
			, ' ', att paymentCurrency, '(s)' ] value: user);
		add: ([ :att | att hasPaid ] value: user);
		yourself ]
]

{ #category : #accessing }
ERAttendeesOfTicket >> content: anObject [
	content := anObject
]

{ #category : #accessing }
ERAttendeesOfTicket >> headers [
	^ #(
'#Invoice'	'Name'	 'Email'	'Country'	'Affiliation	' 'Fee'	'Has Paid?')
]

{ #category : #accessing }
ERAttendeesOfTicket >> listDataToRenderButton [
	^ OrderedCollection new
]

{ #category : #accessing }
ERAttendeesOfTicket >> listOfAttendees [
	^ ERController new attendeesForATicket: ticket ticketId
]

{ #category : #accessing }
ERAttendeesOfTicket >> renderButtonsOn: html [
	self
		createColoredAnchorButton: 'Back'
		with: cancelCallback
		id: 'accept'
		on: html.
]

{ #category : #accessing }
ERAttendeesOfTicket >> renderPageOn: html [
	self listOfAttendees isEmpty ifTrue: [ html heading level5 with: 'This ticket is currently not used by any assistant' ]
	ifFalse: [self renderTableOfAttends: html ].
	html horizontalRule .
	self renderButtonsOn: html
]

{ #category : #accessing }
ERAttendeesOfTicket >> renderTableOfAttends: html [
	
	| table |
		table := ERTable new
		headers: self headers ;
		levelTotal: 6;
		listObject: self listOfAttendees ;
		blockToExecute: self blockTableToExecute;
		listToRenderButton: self listDataToRenderButton.
	html render: table 
	
]

{ #category : #accessing }
ERAttendeesOfTicket >> ticket [
	^ ticket
]

{ #category : #accessing }
ERAttendeesOfTicket >> ticket: anObject [
	ticket := anObject 
]

{ #category : #accessing }
ERAttendeesOfTicket >> title [
	^ 'Attendees of ', ticket ticketId asUppercase 
]
