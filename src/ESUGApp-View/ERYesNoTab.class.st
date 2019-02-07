Class {
	#name : #ERYesNoTab,
	#superclass : #ERContentAdminTab,
	#instVars : [
		'name',
		'title',
		'callbackNo',
		'callbackYes'
	],
	#category : #'ESUGApp-View-Tab'
}

{ #category : #accessing }
ERYesNoTab >> callbackNo: anObject [
	callbackNo := anObject
]

{ #category : #accessing }
ERYesNoTab >> callbackYes: anObject [
	callbackYes := anObject
]

{ #category : #accessing }
ERYesNoTab >> name: anObject [
	name := anObject
]

{ #category : #rendering }
ERYesNoTab >> renderContainer: html [
	html horizontalRule.
	self renderYesButton: html.
	self renderNoButton: html
]

{ #category : #rendering }
ERYesNoTab >> renderNoButton: html [
	html mdlAnchorButton
		colored;
		id: 'no-' , tabId;
		callback: [callbackNo value: self];
		with: 'No'
]

{ #category : #rendering }
ERYesNoTab >> renderYesButton: html [
	html mdlAnchorButton
		colored;
		id: 'yes-' , tabId;
		callback: [callbackYes value: self];
		with: 'Yes'
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
	^ title
]

{ #category : #accessing }
ERYesNoTab >> title: anObject [
	title := anObject
]
