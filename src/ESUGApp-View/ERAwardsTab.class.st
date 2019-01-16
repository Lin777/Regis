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
		add: ([ :att | att name1 ] value: award);
		add: ([ :att | att submittedBy ] value: award);
		yourself ]
]

{ #category : #rendering }
ERAwardsTab >> exportAwards [

			controller exportAwards: 'awards'.
	self updateStateTab: self tabName
]

{ #category : #rendering }
ERAwardsTab >> headers [
	^ #('Name'	'Submitted By')
]

{ #category : #rendering }
ERAwardsTab >> listDataToRenderButton [
	^ OrderedCollection new
]

{ #category : #rendering }
ERAwardsTab >> renderButton: html [
	self
		createColoredAnchorButton: 'Export'
		with: [ self exportAwards ]
		id: 'exportAwards'
		on: html.
]

{ #category : #rendering }
ERAwardsTab >> renderContainer: html [
	self renderButton: html.
	html horizontalRule.
	self renderTableOfAwards: html
]

{ #category : #rendering }
ERAwardsTab >> renderTableOfAwards: html [
	| table |
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
