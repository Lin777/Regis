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

{ #category : #'as yet unclassified' }
ERAwardsTab >> exportAwards [
	| file |
	file := controller exportAwards: 'awards'.
	encodeCSVFile := controller encodeFileToUTF8: file.
	file ensureDelete.
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
	self renderDownloadButtonOn: html.
	html horizontalRule.
	self renderTableOfAwardsOn: html
]

{ #category : #rendering }
ERAwardsTab >> renderDownloadButtonOn: html [
	| dictionary |
	dictionary := Dictionary new 
	at: 'id' put: 'downloadAwards';
	at: 'disabled' put: encodeCSVFile isNil;
	at: 'encodeFile' put: 'data:text/csv;charset=utf-8,', (encodeCSVFile ifNil: ['']);
	at: 'nameFile' put: 'awards.csv';
	at: 'nameButton' put: 'Download';
	yourself.
	self renderDownloadButton: html with: dictionary.
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
