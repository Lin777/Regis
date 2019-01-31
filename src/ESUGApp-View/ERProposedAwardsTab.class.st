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

{ #category : #initialization }
ERProposedAwardsTab >> initializeFormAddAward [
	|award|
	award := ERAward1 submitter: attendee.
	formAddAward := (ERTittledFormView 
							on: award 
							withContent: content) title: 'Award'.
	formAddAward callback: [ self saveAward ]
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
ERProposedAwardsTab >> renderContainer: html [ 	
	html horizontalRule .
	self renderButtonAddOn: html.
	self renderTable: html.
]

{ #category : #rendering }
ERProposedAwardsTab >> renderMessageEmptyOn: html [
	html horizontalRule.
	html heading level5; with: 'You do not have any proposed award yet.'
]

{ #category : #rendering }
ERProposedAwardsTab >> renderTable: html [
	self submittedAwards isEmpty 
		ifTrue: [ self renderMessageEmptyOn: html ]
		ifFalse: [  ]
]

{ #category : #initialization }
ERProposedAwardsTab >> saveAward [
]

{ #category : #accessing }
ERProposedAwardsTab >> submittedAwards [ 
	^ ERController new submittedAwardsFor: attendee
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
