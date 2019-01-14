Class {
	#name : #ERTalksTab,
	#superclass : #ERConfigurationTab,
	#category : #'ESUGApp-View-Tab'
}

{ #category : #accessing }
ERTalksTab >> blockTableToExecute [
	^ [ :talk| 
	OrderedCollection new
		add: ([ :att | att name1 ] value: talk);
		add: ([ :att | att submittedBy ] value: talk);
		add: ([ :att | att uploadFile ] value: talk);
		yourself ]
]

{ #category : #rendering }
ERTalksTab >> exportTalks [
	
	(self fileExists: 'talks.cvs')
		ifFalse: [ controller exportTalks ]
		ifTrue: [ Transcript show: 'File Exist' ]
]

{ #category : #accessing }
ERTalksTab >> headers [ 	
	^ #('Name'	'Submitted By'	'Uploaded File')
]

{ #category : #rendering }
ERTalksTab >> listDataToRenderButton [
	^ OrderedCollection new
]

{ #category : #rendering }
ERTalksTab >> renderButton: html [
	self
		createColoredAnchorButton: 'Export'
		with: [ self exportTalks ]
		id: 'exportTalks'
		on: html.
]

{ #category : #rendering }
ERTalksTab >> renderContainer: html [
	self renderButton: html.
	html horizontalRule.
	self renderTableOfTalks: html
]

{ #category : #accessing }
ERTalksTab >> renderTableOfTalks: html [
	| table |
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
