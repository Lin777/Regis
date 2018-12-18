Class {
	#name : #ERTabContainerPage,
	#superclass : #ERTab,
	#instVars : [
		'content'
	],
	#category : #'ESUGApp-Components'
}

{ #category : #accessing }
ERTabContainerPage >> content [
	^ content
]

{ #category : #accessing }
ERTabContainerPage >> content: anObject [
	content := anObject
]

{ #category : #rendering }
ERTabContainerPage >> renderContainer: html [
	self subclassResponsibility 
]

{ #category : #rendering }
ERTabContainerPage >> renderContentOn: html [
	html heading level3; with: self title .
	self renderContainer: html
]

{ #category : #accessing }
ERTabContainerPage >> title [
	self subclassResponsibility 
]
