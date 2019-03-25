Class {
	#name : #ERProposedAwardsTab,
	#superclass : #ERMyRegistrationTab,
	#instVars : [
		'formAddAward'
	],
	#category : #'ESUGApp-View-Tab'
}

{ #category : #adding }
ERProposedAwardsTab >> addAward [
	self initializeFormAddAward.
	content state: formAddAward.
	self updateStateTab: self tabName.
]

{ #category : #rendering }
ERProposedAwardsTab >> blockTableToExecute [
	^ [ :award | 
	OrderedCollection new
		add: ([ :att | att nameAward ] value: award);
		add: ([ :att | att affiliation ] value: award);
		add: ([ :att | att downloadUrl ] value: award);
		yourself ]
]

{ #category : #initialization }
ERProposedAwardsTab >> createAward: anAward [
	controller addAward: anAward.
	self cancel
]

{ #category : #accessing }
ERProposedAwardsTab >> headers [
	^ #('Name' 'Affiliation' 'Download Url' '')
]

{ #category : #initialization }
ERProposedAwardsTab >> initializeFormAddAward [
	|award|
	award := ERAward submitter: attendee.
	formAddAward := (ERTittledFormView 
							on: award 
							withContent: content) title: 'Award'; 
							callback: [:anAward | self createAward: anAward];
							cancelCallback: [self cancel]; initializeForm
]

{ #category : #rendering }
ERProposedAwardsTab >> listDataToRenderButton [
	^ OrderedCollection new
]

{ #category : #rendering }
ERProposedAwardsTab >> renderAwardsTableOn: html [
	table := ERTable new
		headers: self headers;
		levelTotal: 6;
		listObject: self submittedAwards;
		blockToExecute: self blockTableToExecute;
		listToRenderButton: self listDataToRenderButton.
	html render: table
]

{ #category : #rendering }
ERProposedAwardsTab >> renderButtonAddOn: html [
	html mdlAnchorButton
		colored;
		id: 'addAward';
		callback: [self addAward];
		with: 'Add'
]

{ #category : #rendering }
ERProposedAwardsTab >> renderContainerOn: html [ 	
	html horizontalRule .
	self proposalsAreAllowed ifTrue: [self renderButtonAddOn: html].
	self renderTableOn: html.
]

{ #category : #rendering }
ERProposedAwardsTab >> renderMessageEmptyOn: html [
	html horizontalRule.
	html heading level5; with: 'You do not have any proposed award yet.'
]

{ #category : #rendering }
ERProposedAwardsTab >> renderTableOn: html [
	self submittedAwards isEmpty 
		ifTrue: [ self renderMessageEmptyOn: html ]
		ifFalse: [ self renderAwardsTableOn: html ]
]

{ #category : #accessing }
ERProposedAwardsTab >> submittedAwards [ 
	^ controller submittedAwardsFor: attendee
]

{ #category : #accessing }
ERProposedAwardsTab >> tabId [
	^ 'proposedAwards'

]

{ #category : #accessing }
ERProposedAwardsTab >> tabName [
	^ 'Proposed Awards'
]

{ #category : #accessing }
ERProposedAwardsTab >> title [
	^ 'Submitted Awards'
]
