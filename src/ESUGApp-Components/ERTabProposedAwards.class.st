Class {
	#name : #ERTabProposedAwards,
	#superclass : #ERTabContainerPage,
	#category : #'ESUGApp-Components'
}

{ #category : #rendering }
ERTabProposedAwards >> renderContainer: html [ 	
	html horizontalRule .
	self renderTable: html.
]

{ #category : #rendering }
ERTabProposedAwards >> renderTable: html [
]

{ #category : #accessing }
ERTabProposedAwards >> tabId [
	^ 'proposedAwards'

]

{ #category : #accessing }
ERTabProposedAwards >> tabName [
	^ 'Proposed Talks'
]

{ #category : #accessing }
ERTabProposedAwards >> title [
	^ 'Submitted Awards'
]
