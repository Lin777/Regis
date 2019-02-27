Class {
	#name : #ERYesNoTab,
	#superclass : #ERContentAdminTab,
	#instVars : [
		'name',
		'titleTrue',
		'titleFalse',
		'callbackNo',
		'callbackTrue',
		'callbackFalse',
		'stateBlock'
	],
	#category : #'ESUGApp-View-Tab'
}

{ #category : #accessing }
ERYesNoTab >> callbackFalse: anObject [
	callbackFalse := anObject
]

{ #category : #accessing }
ERYesNoTab >> callbackNo: anObject [
	callbackNo := anObject
]

{ #category : #accessing }
ERYesNoTab >> callbackTrue: anObject [
	callbackTrue := anObject
]

{ #category : #accessing }
ERYesNoTab >> callbackYes [
	stateBlock value ifTrue: [^ callbackTrue ].
	^ callbackFalse
]

{ #category : #initialization }
ERYesNoTab >> initialize [ 	
	super initialize .
	stateBlock := [ true ]
]

{ #category : #accessing }
ERYesNoTab >> name: anObject [
	name := anObject
]

{ #category : #rendering }
ERYesNoTab >> renderContainerOn: html [
	html horizontalRule.
	html form 
		method: 'post';
		with:
	[self renderYesButtonYes: html.
	self renderNoButtonOn: html]
]

{ #category : #rendering }
ERYesNoTab >> renderNoButtonOn: html [
	html mdlAnchorButton
		colored;
		id: 'no-' , tabId;
		callback: [callbackNo value: self];
		with: 'No'
]

{ #category : #rendering }
ERYesNoTab >> renderYesButtonYes: html [
	html mdlButton
		colored;
		beSubmit;
		id: 'yes-' , tabId;
		callback: [self callbackYes value: self];
		with: 'Yes'
]

{ #category : #accessing }
ERYesNoTab >> stateBlock: anObject [
	stateBlock := anObject
]

{ #category : #accessing }
ERYesNoTab >> tabId [
	^ tabId 
]

{ #category : #accessing }
ERYesNoTab >> tabId: anId [
	tabId := anId 
]

{ #category : #accessing }
ERYesNoTab >> tabName [
	^ name
]

{ #category : #accessing }
ERYesNoTab >> tabName: aName [
	name := aName
]

{ #category : #accessing }
ERYesNoTab >> title [
	stateBlock value ifTrue: [ ^ titleTrue ].
	^ titleFalse
]

{ #category : #accessing }
ERYesNoTab >> titleFalse: anObject [
	titleFalse := anObject
]

{ #category : #accessing }
ERYesNoTab >> titleTrue: anObject [
	titleTrue := anObject
]
