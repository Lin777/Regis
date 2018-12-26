Class {
	#name : #ERStatistics,
	#superclass : #ERConfiguration,
	#category : #'ESUGApp-Components'
}

{ #category : #rendering }
ERStatistics >> renderContainer: html [
	html horizontalRule.
]

{ #category : #accessing }
ERStatistics >> tabId [
	^ 'statistics'
]

{ #category : #accessing }
ERStatistics >> tabName [
	^ 'statistics'
]

{ #category : #accessing }
ERStatistics >> title [
	^ 'Registrations'
]
