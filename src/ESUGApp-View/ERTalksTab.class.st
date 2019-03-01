Class {
	#name : #ERTalksTab,
	#superclass : #ERConfigurationTab,
	#instVars : [
		'encodeCSVFile'
	],
	#category : #'ESUGApp-View-Tab'
}

{ #category : #accessing }
ERTalksTab >> blockTableToExecute [
	^ [ :talk| 
	OrderedCollection new
		add: ([ :att | att name ] value: talk);
		add: ([ :att | att submitter userAccount email ] value: talk);
		add: ([ :att | att presentation ] value: talk);
		yourself ]
]

{ #category : #rendering }
ERTalksTab >> exportTalks [
	| file |
	file := controller exportTalks: 'talks'.
	self exportFile: file wihtName: 'talks.csv'
]

{ #category : #accessing }
ERTalksTab >> headers [ 	
	^ #('Name'	'Submitted By'	'Uploaded File' '')
]

{ #category : #rendering }
ERTalksTab >> listDataToRenderButton [
	^ OrderedCollection new
]

{ #category : #rendering }
ERTalksTab >> renderButtonOn: html [
	html mdlAnchorButton
		colored;
		id: 'exportTalks';
		callback: [ self exportTalks ];
		with: 'Export'
]

{ #category : #rendering }
ERTalksTab >> renderContainerOn: html [
	self renderButtonOn: html.
	html horizontalRule.
	self renderTableOfTalksOn: html
]

{ #category : #accessing }
ERTalksTab >> renderTableOfTalksOn: html [
	table := ERTable new
		headers: self headers;
		levelTotal: 6;
		listObject: self talks;
		blockToExecute: self blockTableToExecute;
		listToRenderButton: self listDataToRenderButton.
	html render: table
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
	^ controller submittedTalks
]

{ #category : #accessing }
ERTalksTab >> title [
	^ 'Submitted Talks'
]
