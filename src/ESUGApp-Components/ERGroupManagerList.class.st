Class {
	#name : #ERGroupManagerList,
	#superclass : #ERConfiguration,
	#category : #'ESUGApp-Components'
}

{ #category : #rendering }
ERGroupManagerList >> renderContainer: html [
	html horizontalRule.
]

{ #category : #accessing }
ERGroupManagerList >> tabId [
	^ 'groupManagerList'
]

{ #category : #accessing }
ERGroupManagerList >> tabName [
	^ 'Group Manager'
]

{ #category : #accessing }
ERGroupManagerList >> title [
	^ 'Group Manager'
]
