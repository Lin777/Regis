Class {
	#name : #ERTalksTab,
	#superclass : #ERConfigurationTab,
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

	controller exportTalks: 'talks'.
	self updateStateTab: self tabName
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
ERTalksTab >> renderButton: html [
	html mdlAnchorButton
		colored;
		id: 'exportTalks';
		callback: [ self exportTalks ];
		with: 'Export'
]

{ #category : #rendering }
ERTalksTab >> renderContainer: html [
	self renderButton: html.
	html horizontalRule. 
	self renderTableOfTalks: html
]

{ #category : #accessing }
ERTalksTab >> renderTableOfTalks: html [
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
