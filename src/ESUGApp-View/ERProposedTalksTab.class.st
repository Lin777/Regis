Class {
	#name : #ERProposedTalksTab,
	#superclass : #ERMyRegistrationTab,
	#instVars : [
		'formAddTalk'
	],
	#category : #'ESUGApp-View-Tab'
}

{ #category : #rendering }
ERProposedTalksTab >> addTalk [
	self initializeFormAddTalk.
	content state: formAddTalk.
	self updateStateTab: self tabName.
]

{ #category : #rendering }
ERProposedTalksTab >> blockTableToExecute [
	^ [ :talk | 
	OrderedCollection new
		add: ([ :att | att name ] value: talk);
		add: ([ :att | att description ] value: talk);
		yourself ]
]

{ #category : #rendering }
ERProposedTalksTab >> createTalk: aTalk [
	ERController new addTalk: aTalk.
	self cancel
]

{ #category : #rendering }
ERProposedTalksTab >> headers [
	^ #('Name' 'Description' '')
]

{ #category : #rendering }
ERProposedTalksTab >> initializeFormAddTalk [
	|talk|
	talk := ERTalk1 submitter: attendee.
	formAddTalk := (ERTittledFormView 
							on: talk 
							withContent: content) title: 'Talk'; 
							callback: [:aTalk | self createTalk: aTalk];
							cancelCallback: [ self cancel]; 
							initializeForm
]

{ #category : #rendering }
ERProposedTalksTab >> listDataToRenderButton [
	^ OrderedCollection new
]

{ #category : #rendering }
ERProposedTalksTab >> proposalsAreAllowed [
	^ ERController new conference configuration 
	dateSubmissionDeadline < Date today 
]

{ #category : #rendering }
ERProposedTalksTab >> renderButtonAddOn: html [
	html mdlAnchorButton
		colored;
		id: 'addTalk';
		callback: [self addTalk];
		with: 'Add'
]

{ #category : #rendering }
ERProposedTalksTab >> renderContainer: html [ 	
	html horizontalRule .
	self proposalsAreAllowed ifTrue: [self renderButtonAddOn: html].
	self renderTable: html.
]

{ #category : #rendering }
ERProposedTalksTab >> renderMessageEmptyOn: html [
	html horizontalRule.
	html heading level5; with: 'You do not have any proposed talk yet.'
]

{ #category : #rendering }
ERProposedTalksTab >> renderTable: html [
	self submittedTalks isEmpty 
		ifTrue: [ self renderMessageEmptyOn: html ]
		ifFalse: [ self renderTalksTable: html ]
]

{ #category : #rendering }
ERProposedTalksTab >> renderTalksTable: html [
	| table |
	table := ERTable new
		headers: self headers;
		levelTotal: 6;
		listObject: self submittedTalks;
		blockToExecute: self blockTableToExecute;
		listToRenderButton: self listDataToRenderButton.
	html render: table
]

{ #category : #accessing }
ERProposedTalksTab >> submittedTalks [ 
	^ ERController new submittedTalksFor: attendee
]

{ #category : #accessing }
ERProposedTalksTab >> tabId [
	^ 'proposedTalks'

]

{ #category : #accessing }
ERProposedTalksTab >> tabName [
	^ 'Proposed Talks'
]

{ #category : #accessing }
ERProposedTalksTab >> title [
	^ 'Submitted Talks'
]
