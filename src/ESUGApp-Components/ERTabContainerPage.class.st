Class {
	#name : #ERTabContainerPage,
	#superclass : #ERTab,
	#category : #'ESUGApp-Components'
}

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
