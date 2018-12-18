Class {
	#name : #ERProposedTalks,
	#superclass : #ERTabContainerPage,
	#category : #'ESUGApp-Components'
}

{ #category : #rendering }
ERProposedTalks >> renderContainer: html [ 	
	html horizontalRule .
	self renderTable: html.
]

{ #category : #rendering }
ERProposedTalks >> renderTable: html [

]

{ #category : #accessing }
ERProposedTalks >> tabId [
	^ 'proposedTalks'

]

{ #category : #accessing }
ERProposedTalks >> tabName [
	^ 'Proposed Awards'
]

{ #category : #accessing }
ERProposedTalks >> title [
	^ 'Submitted Talks'
]
