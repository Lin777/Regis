"
Description
--------------------

Tab to render all proposal awards in the database of an especific attendee (attendee of session).

I can edit and delete awards
"
Class {
	#name : #ERProposedAwardsTab,
	#superclass : #ERMyRegistrationTab,
	#category : #'ESUGApp-View-Tab'
}

{ #category : #adding }
ERProposedAwardsTab >> addAward [
	self initializeFormAddAward.
	content state: formAward.
	self updateStateTab: self tabName.
]

{ #category : #adding }
ERProposedAwardsTab >> createAward: anAward [
	controller addAward: anAward.
	self cancel
]

{ #category : #accessing }
ERProposedAwardsTab >> headers [
	^ { 'Name'	. 'Submitted By' . PSTableSortableHeaderOptions new cell: 'Download URL' . PSTableSortableHeaderOptions new cell: 'Demo URL' . PSTableSortableHeaderOptions new cell:'' }
]

{ #category : #initialization }
ERProposedAwardsTab >> initializeFormAddAward [
	|award|
	award := ERAward submitter: attendee.
	formAward := (ERTittledFormView 
							on: award 
							withContent: content) title: 'Award'; 
							callback: [:anAward | self createAward: anAward];
							cancelCallback: [self cancel]; initializeForm
]

{ #category : #tableBlock }
ERProposedAwardsTab >> listDataToRenderButton [
	|list|
	list := OrderedCollection new.
	self proposalsAreAllowed ifTrue: [
	list
		add:
			(Array
				with: 'edit'
				with: [ :award | self modifyAward: award.
					self updateStateTab: self tabName. ]
				with: [ :award | award id , '-modify' ]
				with: 'Modify'
				with: ''
				with: false);
		add:
			(Array
				with: 'delete'
				with: [ :award | self deleteAward: award.
					self updateStateTab: self tabName. ]
				with: [ :award | award id , '-delete' ]
				with: 'Delete'
				with: 'return confirm(''Are you sure you want to delete this item?'');'
				with: false)].
		
	^ list
]

{ #category : #updating }
ERProposedAwardsTab >> modifyAward: anAward [
	self initializeFormEditAward: anAward.
	content state: formAward.
	self updateStateTab: self tabName.
]

{ #category : #rendering }
ERProposedAwardsTab >> renderAwardsTableOn: html [
	table := ERTable new
		tableId: 'proposedAwards-table';
		validation: self filterAwardsInformation;
		limitPageShowed: 3;
		header: self headers;
		levelTotal: 6;
		rows: self submittedAwards;
		blockToExecute: self blockTableAwardsToExecute;
		listToRenderButton: self listDataToRenderButton;
		sortingMethod: self sortingMethodAwards.
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
ERProposedAwardsTab >> sortingMethodAwards [
	^ { [ :att | att nameAward ] 
		. [ :att | att submitter userAccount email ]
		. [ :att | ]
		. [ :att | ] }
]

{ #category : #accessing }
ERProposedAwardsTab >> submittedAwards [ 
	^ controller conference submittedAwardsFor: attendee
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
