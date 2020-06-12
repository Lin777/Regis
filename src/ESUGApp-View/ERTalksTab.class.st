"
Description
--------------------

Tab to render all proposal talks of ESUG page in a table.

I can delete talks, export all talks in the database
"
Class {
	#name : #ERTalksTab,
	#superclass : #ERProposalsTab,
	#category : #'ESUGApp-View-Tab'
}

{ #category : #actions }
ERTalksTab >> exportTalks [
	"Export Talks to csv file"

	| file |
	file := controller conference exportTalks: 'talks'.
	self exportFile: file withName: 'talks.csv'
]

{ #category : #accessing }
ERTalksTab >> headers [
	"Return headers of Talks table"
	
	^ { 'Title' .	'Submitted By' . PSTableSortableHeaderOptions new cell: 'Presentation Download URL' . PSTableSortableHeaderOptions new cell: ''}
]

{ #category : #rendering }
ERTalksTab >> listDataToRenderButton [
	"Render buttons of talks"

	^ OrderedCollection new
		add:
			(Array
				with: 'delete'
				with: [ :talk | self deleteTalk: talk.
					self updateStateTab: self tabName. ]
				with: [ :talk | talk id , '-delete' ]
				with: 'Delete Talk'
				with: 'return confirm(''Are you sure you want to delete this talk?'');'
				with: false);
		yourself
]

{ #category : #rendering }
ERTalksTab >> renderButtonOn: html [
	"Render button to export talks"

	html mdlAnchorButton
		colored;
		id: 'exportTalks';
		callback: [ self exportTalks ];
		with: 'Export'
]

{ #category : #rendering }
ERTalksTab >> renderContainerOn: html [
	"Render content of tab"

	self renderButtonOn: html.
	html horizontalRule.
	self renderTableOfTalksOn: html
]

{ #category : #rendering }
ERTalksTab >> renderTableOfTalksOn: html [
	"Render table of talks"

	table := ERTable new
		tableId: 'talks-table';
		limitPageShowed: 3;
		validation: self filterTalksInformation;
		header: self headers;
		levelTotal: 6;
		rows: self talks;
		blockToExecute: self blockTableTalksToExecute;
		listToRenderButton: self listDataToRenderButton;
		sortingMethod: self sortingMethodTalks.
	html render: table
]

{ #category : #accessing }
ERTalksTab >> sortingMethodTalks [
	
	^ { [ :att | att title ] 
		. [ :att | att submitter userAccount email ]
		. [ :att | ] }
]

{ #category : #accessing }
ERTalksTab >> tabId [

	^ 'talks'
]

{ #category : #accessing }
ERTalksTab >> tabName [

	^ 'Talks'
]

{ #category : #accessing }
ERTalksTab >> talks [

	^ controller conference submittedTalks
]

{ #category : #accessing }
ERTalksTab >> title [

	^ 'Submitted Talks'
]
