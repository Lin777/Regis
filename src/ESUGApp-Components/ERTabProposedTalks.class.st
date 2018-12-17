Class {
	#name : #ERTabProposedTalks,
	#superclass : #ERTabContainerPage,
	#category : #'ESUGApp-Components'
}

{ #category : #rendering }
ERTabProposedTalks >> renderContainer: html [ 	
	html horizontalRule .
	self renderTable: html.
]

{ #category : #rendering }
ERTabProposedTalks >> renderTable: html [

]

{ #category : #accessing }
ERTabProposedTalks >> tabId [
	^ 'proposedTalks'

]

{ #category : #accessing }
ERTabProposedTalks >> tabName [
	^ 'Proposed Awards'
]

{ #category : #accessing }
ERTabProposedTalks >> title [
	^ 'Submitted Talks'
]
