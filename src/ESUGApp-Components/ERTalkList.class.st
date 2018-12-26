Class {
	#name : #ERTalkList,
	#superclass : #ERConfiguration,
	#category : #'ESUGApp-Components'
}

{ #category : #rendering }
ERTalkList >> renderContainer: html [
	html horizontalRule.
]

{ #category : #accessing }
ERTalkList >> tabId [
	^ 'talks'
]

{ #category : #accessing }
ERTalkList >> tabName [
	^ 'Talks'
]

{ #category : #accessing }
ERTalkList >> title [
	^ 'Submitted Talks'
]
