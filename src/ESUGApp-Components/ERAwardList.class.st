Class {
	#name : #ERAwardList,
	#superclass : #ERConfiguration,
	#category : #'ESUGApp-Components'
}

{ #category : #rendering }
ERAwardList >> renderContainer: html [
	html horizontalRule.
]

{ #category : #accessing }
ERAwardList >> tabId [
	^ 'awards'
]

{ #category : #accessing }
ERAwardList >> tabName [
	^ 'Awards'
]

{ #category : #accessing }
ERAwardList >> title [
	^ 'Submitted Awards'
]
