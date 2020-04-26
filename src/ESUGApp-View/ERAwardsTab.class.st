"
Description
--------------------

Tab to render  all proposal awards of ESUG page in a table.
"
Class {
	#name : #ERAwardsTab,
	#superclass : #ERProposalsTab,
	#category : #'ESUGApp-View-Tab'
}

{ #category : #accessing }
ERAwardsTab >> awards [
	"Return the awards of conference"

	^ controller conference submittedAwards
]

{ #category : #actions }
ERAwardsTab >> exportAwards [
	"Export awards to csv file"
	
	| file |
	file := controller conference exportAwards: 'awards'.
	self exportFile: file withName: 'awards.csv'
]

{ #category : #rendering }
ERAwardsTab >> headers [
	"Return the headers of table"

	^ #('Name'	'Submitted By' 'Download URL' 'Demo URL' '')
]

{ #category : #tableBlock }
ERAwardsTab >> listDataToRenderButton [
	"Return list of rendered buttons"

	^ OrderedCollection new
		add:
			(Array
				with: 'delete'
				with: [ :award | self deleteAward: award.
					self updateStateTab: self tabName. ]
				with: [ :award | award id , '-delete' ]
				with: 'Delete Award'
				with: 'return confirm(''Are you sure you want to delete this award?'');'
				with: false);
		yourself
]

{ #category : #rendering }
ERAwardsTab >> renderButtonOn: html [
	"Render button to export awards"

	html mdlAnchorButton
		colored;
		id: 'exportAwards';
		callback: [ self exportAwards ];
		with: 'Export'
]

{ #category : #rendering }
ERAwardsTab >> renderContainerOn: html [
	"Render container content"

	self renderButtonOn: html.
	html horizontalRule.
	self renderTableOfAwardsOn: html
]

{ #category : #rendering }
ERAwardsTab >> renderTableOfAwardsOn: html [
	"Render table of awards"

	table := ERTable new
		tableId: 'awards-table';
		limitPerPage: 10;
		limitPageShowed: 3;
		validation: self filterAwardsInformation;
		headers: self headers;
		disablePagination: true;
		levelTotal: 6;
		listObject: self awards;
		blockToExecute: self blockTableAwardsToExecute;
		listToRenderButton: self listDataToRenderButton.
	html render: table
]

{ #category : #accessing }
ERAwardsTab >> tabId [

	^ 'awards'
]

{ #category : #accessing }
ERAwardsTab >> tabName [

	^ 'Awards'
]

{ #category : #accessing }
ERAwardsTab >> title [

	^ 'Submitted Awards'
]
