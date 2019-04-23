"
Description
--------------------

Tab to render all proposal talks in the database of an especific attendee (attendee of session).

I can edit and delete talks
"
Class {
	#name : #ERProposedTalksTab,
	#superclass : #ERMyRegistrationTab,
	#category : #'ESUGApp-View-Tab'
}

{ #category : #adding }
ERProposedTalksTab >> addTalk [
	self initializeFormAddTalk.
	content state: formTalk.
	self updateStateTab: self tabName.
]

{ #category : #rendering }
ERProposedTalksTab >> createTalk: aTalk [
	controller addTalk: aTalk.
	self cancel
]

{ #category : #accessing }
ERProposedTalksTab >> headers [ 	
	^ #('Name'	'Submitted By'	'Presentation Download URL' '')
]

{ #category : #initialization }
ERProposedTalksTab >> initializeFormAddTalk [
	|talk|
	talk := ERTalk submitter: attendee.
	formTalk := (ERTittledFormView 
							on: talk 
							withContent: content) title: 'Talk'; 
							callback: [:aTalk | self createTalk: aTalk];
							cancelCallback: [ self cancel]; 
							initializeForm
]

{ #category : #tableBlock }
ERProposedTalksTab >> listDataToRenderButton [
	|list|
	list := OrderedCollection new.
	self proposalsAreAllowed ifTrue: [ 
		list add:
			(Array
				with: 'edit'
				with: [ :talk | self modifyTalk: talk.
					self updateStateTab: self tabName. ]
				with: [ :talk | talk id , '-modify' ]
				with: 'Modify'
				with: ''
				with: false);
		add:
			(Array
				with: 'delete'
				with: [ :talk | self deleteTalk: talk.
					self updateStateTab: self tabName. ]
				with: [ :talk | talk id , '-delete' ]
				with: 'Delete'
				with: 'return confirm(''Are you sure you want to delete this item?'');'
				with: false)].
		^ list
]

{ #category : #updating }
ERProposedTalksTab >> modifyTalk: aTalk [
	self initializeFormEditTalk: aTalk.
	content state: formTalk.
	self updateStateTab: self tabName.
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
ERProposedTalksTab >> renderContainerOn: html [ 	
	html horizontalRule .
	self proposalsAreAllowed ifTrue: [self renderButtonAddOn: html].
	self renderTableOn: html.
]

{ #category : #rendering }
ERProposedTalksTab >> renderMessageEmptyOn: html [
	html horizontalRule.
	html heading level5; with: 'You do not have any proposed talk yet.'
]

{ #category : #rendering }
ERProposedTalksTab >> renderTableOn: html [
	self submittedTalks isEmpty 
		ifTrue: [ self renderMessageEmptyOn: html ]
		ifFalse: [ self renderTalksTableOn: html ]
]

{ #category : #rendering }
ERProposedTalksTab >> renderTalksTableOn: html [
	table := ERTable new
		headers: self headers;
		levelTotal: 6;
		listObject: self submittedTalks;
		blockToExecute: self blockTableTalksToExecute;
		listToRenderButton: self listDataToRenderButton.
	html render: table
]

{ #category : #accessing }
ERProposedTalksTab >> submittedTalks [ 
	^ controller conference submittedTalksFor: attendee
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
