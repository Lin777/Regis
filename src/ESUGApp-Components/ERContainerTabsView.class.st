Class {
	#name : #ERContainerTabsView,
	#superclass : #ERContainerView,
	#instVars : [
		'tabView'
	],
	#category : #'ESUGApp-Components'
}

{ #category : #rendering }
ERContainerTabsView >> renderContentPage: html [
	html render: tabView.
	
]

{ #category : #accessing }
ERContainerTabsView >> tabView [
	^ tabView
]

{ #category : #accessing }
ERContainerTabsView >> tabView: anObject [
	tabView := anObject
]
