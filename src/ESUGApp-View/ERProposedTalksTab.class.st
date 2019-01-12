Class {
	#name : #ERProposedTalksTab,
	#superclass : #ERContainerTab,
	#category : #'ESUGApp-View-Tab'
}

{ #category : #rendering }
ERProposedTalksTab >> renderContainer: html [ 	
	html horizontalRule .
	self renderTable: html.
]

{ #category : #rendering }
ERProposedTalksTab >> renderTable: html [

]

{ #category : #accessing }
ERProposedTalksTab >> tabId [
	^ 'proposedTalks'

]

{ #category : #accessing }
ERProposedTalksTab >> tabName [
	^ 'Proposed Awards'
]

{ #category : #accessing }
ERProposedTalksTab >> title [
	^ 'Submitted Talks'
]
