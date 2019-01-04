Class {
	#name : #ERTalkList,
	#superclass : #ERConfiguration,
	#category : #'ESUGApp-Components'
}

{ #category : #accessing }
ERTalkList >> blockTableToExecute [
	^ [ :talk| 
	OrderedCollection new
		add: ([ :att | att name1 ] value: talk);
		add: ([ :att | att submittedBy ] value: talk);
		add: ([ :att | att uploadFile ] value: talk);
		yourself ]
]

{ #category : #rendering }
ERTalkList >> exportTalks [
	(File named: 'talks') exists
		ifFalse: [ controller exportTalks ]
		ifTrue: [ Transcript show: 'File Exist' ]
	
]

{ #category : #accessing }
ERTalkList >> headers [ 	
	^ #('Name'	'Submitted By'	'Uploaded File')
]

{ #category : #rendering }
ERTalkList >> listDataToRenderButton [
	^ OrderedCollection new
]

{ #category : #rendering }
ERTalkList >> renderButton: html [
	self
		createColoredAnchorButton: 'Export'
		with: [ self exportTalks ]
		id: 'exportTalks'
		on: html.
]

{ #category : #rendering }
ERTalkList >> renderContainer: html [
	self renderButton: html.
	html horizontalRule.
	self renderTableOfTalks: html
]

{ #category : #accessing }
ERTalkList >> renderTableOfTalks: html [
	| table |
	table := ERTableGenericData new
		headers: self headers;
		levelTotal: 6;
		listObject: self talks;
		blockToExecute: self blockTableToExecute;
		listToRenderButton: self listDataToRenderButton.
	html render: table
]

{ #category : #accessing }
ERTalkList >> tabId [
	^ 'talks'
]

{ #category : #accessing }
ERTalkList >> tabName [
	^ 'Talks'
]

{ #category : #accessing }
ERTalkList >> talks [
	^ controller submittedTalks
]

{ #category : #accessing }
ERTalkList >> title [
	^ 'Submitted Talks'
]
