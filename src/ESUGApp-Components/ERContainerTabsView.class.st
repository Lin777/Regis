Class {
	#name : #ERContainerTabsView,
	#superclass : #ERContainerView,
	#instVars : [
		'tabView'
	],
	#category : #'ESUGApp-Components'
}

{ #category : #rendering }
ERContainerTabsView >> renderCancelButton: html [
	html mdlButton
		colored;
		rippleEffect;
		id: 'cancelRegisterUser';
		callback: [ self answer: nil ];
		with: 'Cancel'
]

{ #category : #rendering }
ERContainerTabsView >> renderContentPage: html [
	html mdlTabs rippleEffect 
	with: [ 
		html div style: 'overflow-x:auto;';
		with: [ 
			html mdlGrid noSpacing 
			with: [ 
				html form
				method: 'post';
				id: 'formRegister';
				with: [
					html render: tabView].
			]
		]	
	].
	self renderCancelButton: html
]

{ #category : #accessing }
ERContainerTabsView >> tabView [
	^ tabView
]

{ #category : #accessing }
ERContainerTabsView >> tabView: anObject [
	tabView := anObject
]
