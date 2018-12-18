Class {
	#name : #ERProposedAwards,
	#superclass : #ERTabContainerPage,
	#category : #'ESUGApp-Components'
}

{ #category : #rendering }
ERProposedAwards >> renderContainer: html [ 	
	html horizontalRule .
	self renderTable: html.
]

{ #category : #rendering }
ERProposedAwards >> renderTable: html [
]

{ #category : #accessing }
ERProposedAwards >> tabId [
	^ 'proposedAwards'

]

{ #category : #accessing }
ERProposedAwards >> tabName [
	^ 'Proposed Talks'
]

{ #category : #accessing }
ERProposedAwards >> title [
	^ 'Submitted Awards'
]
