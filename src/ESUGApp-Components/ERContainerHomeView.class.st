Class {
	#name : #ERContainerHomeView,
	#superclass : #ERContainerView,
	#category : #'ESUGApp-Components'
}

{ #category : #rendering }
ERContainerHomeView >> renderContentPage: html [
	html heading level3 with: 'Welcome to the ESUG Registration System'.
	html horizontalRule.
	html heading level6 with: [ 
		html strong: 'Conference Home Page: '.
		html anchor url: '#';
		with: 'http://exmple.exaomeosmdfsdkfm..xkmdkfm'.
	].
]
