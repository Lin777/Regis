"
Description
--------------------

Tab to render  all proposal awards of ESUG page in a table.
"
Class {
	#name : #ERAwardsTab,
	#superclass : #ERConfigurationTab,
	#category : #'ESUGApp-View-Tab'
}

{ #category : #accessing }
ERAwardsTab >> awards [
	^ controller conference submittedAwards
]

{ #category : #actions }
ERAwardsTab >> exportAwards [
	| file |
	file := controller conference exportAwards: 'awards'.
	self exportFile: file wihtName: 'awards.csv'
]

{ #category : #rendering }
ERAwardsTab >> headers [
	^ #('Name'	'Submitted By' 'Download URL' 'Demo URL' '')
]

{ #category : #tableBlock }
ERAwardsTab >> listDataToRenderButton [
	^ OrderedCollection new
		add:
			(Array
				with: 'delete'
				with: [ :award | self deleteAward: award.
					self updateStateTab: self tabName. ]
				with: [ :award | award id , '-delete' ]
				with: 'Delete'
				with: 'return confirm(''Are you sure you want to delete this item?'');'
				with: false);
		yourself
]

{ #category : #rendering }
ERAwardsTab >> renderButtonOn: html [
	html mdlAnchorButton
		colored;
		id: 'exportAwards';
		callback: [ self exportAwards ];
		with: 'Export'
]

{ #category : #rendering }
ERAwardsTab >> renderContainerOn: html [
	self renderButtonOn: html.
	html horizontalRule.
	self renderTableOfAwardsOn: html
]

{ #category : #rendering }
ERAwardsTab >> renderTableOfAwardsOn: html [
	table := ERTable new
		headers: self headers;
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
