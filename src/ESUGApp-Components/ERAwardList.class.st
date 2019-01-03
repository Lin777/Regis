Class {
	#name : #ERAwardList,
	#superclass : #ERConfiguration,
	#category : #'ESUGApp-Components'
}

{ #category : #rendering }
ERAwardList >> awards [
	^ controller submittedAwards
]

{ #category : #rendering }
ERAwardList >> blockTableToExecute [
	^ [ :award | 
	OrderedCollection new
		add: ([ :att | att name1 ] value: award);
		add: ([ :att | att submittedBy ] value: award);
		yourself ]
]

{ #category : #rendering }
ERAwardList >> exportAwards [
]

{ #category : #rendering }
ERAwardList >> headers [
	^ #('Name'	'Submitted By')
]

{ #category : #rendering }
ERAwardList >> listDataToRenderButton [
	^ OrderedCollection new
]

{ #category : #rendering }
ERAwardList >> renderButton: html [
	self
		createColoredAnchorButton: 'Export'
		with: [ self exportAwards ]
		id: 'exportAwards'
		on: html.
]

{ #category : #rendering }
ERAwardList >> renderContainer: html [
	self renderButton: html.
	html horizontalRule.
	self renderTableOfAwards: html
]

{ #category : #rendering }
ERAwardList >> renderTableOfAwards: html [
	| table |
	table := ERTableGenericData new
		headers: self headers;
		levelTotal: 6;
		listObject: self awards;
		blockToExecute: self blockTableToExecute;
		listToRenderButton: self listDataToRenderButton.
	html render: table
]

{ #category : #accessing }
ERAwardList >> tabId [
	^ 'awards'
]

{ #category : #accessing }
ERAwardList >> tabName [
	^ 'Awards'
]

{ #category : #accessing }
ERAwardList >> title [
	^ 'Submitted Awards'
]
