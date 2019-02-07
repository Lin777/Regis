Class {
	#name : #ERAwardsTab,
	#superclass : #ERConfigurationTab,
	#category : #'ESUGApp-View-Tab'
}

{ #category : #rendering }
ERAwardsTab >> awards [
	^ controller submittedAwards
]

{ #category : #rendering }
ERAwardsTab >> blockTableToExecute [
	^ [ :award | 
	OrderedCollection new
		add: ([ :att | att nameAward ] value: award);
		add: ([ :att | att submitter userAccount email ] value: award);
		yourself ]
]

{ #category : #rendering }
ERAwardsTab >> children [
	^ OrderedCollection new
		add: table;
		yourself
]

{ #category : #rendering }
ERAwardsTab >> exportAwards [
	controller exportAwards: 'awards'.
	self updateStateTab: self tabName
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
ERAwardsTab >> renderButton: html [
	html mdlAnchorButton
		colored;
		id: 'exportAwards';
		callback: [ self exportAwards ];
		with: 'Export'
]

{ #category : #rendering }
ERAwardsTab >> renderContainer: html [
	self renderButton: html.
	html horizontalRule.
	self renderTableOfAwards: html
]

{ #category : #rendering }
ERAwardsTab >> renderTableOfAwards: html [
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
