Class {
	#name : #ERAllUsers,
	#superclass : #ERConfiguration,
	#category : #'ESUGApp-Components'
}

{ #category : #rendering }
ERAllUsers >> renderContainer: html [
	html horizontalRule.
]

{ #category : #accessing }
ERAllUsers >> tabId [
	^ 'allUsers'
]

{ #category : #accessing }
ERAllUsers >> tabName [
	^ 'Users'
]

{ #category : #accessing }
ERAllUsers >> title [
	^ 'All User'
]
