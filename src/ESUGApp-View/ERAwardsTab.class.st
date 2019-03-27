Class {
	#name : #ERAwardsTab,
	#superclass : #ERConfigurationTab,
	#instVars : [
		'encodeCSVFile'
	],
	#category : #'ESUGApp-View-Tab'
}

{ #category : #rendering }
ERAwardsTab >> awards [
	^ controller conference submittedAwards
]

{ #category : #rendering }
ERAwardsTab >> blockTableToExecute [
	^ [ :award | 
	OrderedCollection new
		add: ([ :att | att nameAward ] value: award);
		add: ([ :att | att submitter userAccount email ] value: award);
		yourself ]
]

{ #category : #'as yet unclassified' }
ERAwardsTab >> exportAwards [
	| file |
	file := controller conference exportAwards: 'awards'.
	self exportFile: file wihtName: 'awards.csv'
]

{ #category : #rendering }
ERAwardsTab >> headers [
	^ #('Name'	'Submitted By' '')
]

{ #category : #rendering }
ERAwardsTab >> listDataToRenderButton [
	^ OrderedCollection new
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
		blockToExecute: self blockTableToExecute;
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
