Class {
	#name : #ERContainerHomeView,
	#superclass : #ERGeneralContainerView,
	#category : #'ESUGApp-Components'
}

{ #category : #rendering }
ERContainerHomeView >> renderPageOn: html [
	html heading level6
		with: [ html strong: 'Conference Home Page: '.
			html anchor
				url: '#';
				with: 'http://exmple.exaomeosmdfsdkfm..xkmdkfm' ]
]

{ #category : #rendering }
ERContainerHomeView >> title [
	^ 'Welcome to the ESUG Registration System'
]
