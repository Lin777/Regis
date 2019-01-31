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
ERProposedTalksTab >> initializeFormAddTalk [
	|talk|
	talk := ERTalk1 submitter: attendee.
	formAddTalk := (ERTittledFormView 
							on: talk 
							withContent: content) title: 'Talk'.
	formAddTalk callback: [ self saveTalk ]
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
	self renderButtonAddOn: html.
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
		ifFalse: [  ]
]

{ #category : #rendering }
ERProposedTalksTab >> saveTalk [
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
