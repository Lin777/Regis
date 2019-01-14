Class {
	#name : #ERProposedAwardsTab,
	#superclass : #ERContainerTab,
	#category : #'ESUGApp-View-Tab'
}

{ #category : #rendering }
ERProposedAwardsTab >> renderContainer: html [ 	
	html horizontalRule .
	self renderTable: html.
]

{ #category : #rendering }
ERProposedAwardsTab >> renderTable: html [
]

{ #category : #accessing }
ERProposedAwardsTab >> tabId [
	^ 'proposedAwards'

]

{ #category : #accessing }
ERProposedAwardsTab >> tabName [
	^ 'Proposed Talks'
]

{ #category : #accessing }
ERProposedAwardsTab >> title [
	^ 'Submitted Awards'
]
