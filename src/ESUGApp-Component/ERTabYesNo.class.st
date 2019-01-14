Class {
	#name : #ERTabYesNo,
	#superclass : #ERAdmin,
	#instVars : [
		'tabId',
		'name',
		'title',
		'callbackYes',
		'callbackNo'
	],
	#category : #'ESUGApp-Component'
}

{ #category : #accessing }
ERTabYesNo >> callbackNo: anObject [
	callbackNo := anObject
]

{ #category : #accessing }
ERTabYesNo >> callbackYes: anObject [
	callbackYes := anObject
]

{ #category : #accessing }
ERTabYesNo >> name: anObject [
	name := anObject
]

{ #category : #rendering }
ERTabYesNo >> renderContainer: html [
	html horizontalRule.
	self renderYesButton: html.
	self renderNoButton: html
]

{ #category : #rendering }
ERTabYesNo >> renderNoButton: html [
	self
		createColoredAnchorButton: 'No'
		with: callbackNo
		id: 'no-' , tabId
		on: html
]

{ #category : #rendering }
ERTabYesNo >> renderYesButton: html [
	self
		createColoredAnchorButton: 'Yes'
		with: callbackYes
		id: 'yes-' , tabId
		on: html.
	
]

{ #category : #accessing }
ERTabYesNo >> tabId [
	^ tabId 
]

{ #category : #accessing }
ERTabYesNo >> tabId: anId [
	tabId := anId 
]

{ #category : #accessing }
ERTabYesNo >> tabName [
	^ name
]

{ #category : #accessing }
ERTabYesNo >> tabName: aName [
	name := aName
]

{ #category : #accessing }
ERTabYesNo >> title [
	^ title
]

{ #category : #accessing }
ERTabYesNo >> title: anObject [
	title := anObject
]
