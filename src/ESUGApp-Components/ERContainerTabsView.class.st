Class {
	#name : #ERContainerTabsView,
	#superclass : #ERContainerView,
	#instVars : [
		'tabView'
	],
	#category : #'ESUGApp-Components'
}

{ #category : #'as yet unclassified' }
ERContainerTabsView class >> on: anAttendee withContent: aContent [
	| form |
	form := self new.
	form attendee: anAttendee.
	form content: aContent.
	form initializeForm.
	^ form
]

{ #category : #rendering }
ERContainerTabsView >> cancel [
	content state: content lastState
]

{ #category : #accessing }
ERContainerTabsView >> content: anObject [
	content := anObject
]

{ #category : #rendering }
ERContainerTabsView >> renderCancelButton: html [
	html mdlAnchorButton
		colored;
		rippleEffect;
		id: 'cancelRegisterUser';
		callback: [ self cancel ];
		with: 'Cancel'
]

{ #category : #rendering }
ERContainerTabsView >> renderContentPage: html [
	html mdlTabs rippleEffect
		with: [ html div
				style: 'overflow-x:auto;';
				with: [ html mdlGrid noSpacing
						with: [ html form
								method: 'post';
								id: 'formRegister';
								with: [ html render: tabView.
									self renderCancelButton: html ] ] ] ].
	
]

{ #category : #accessing }
ERContainerTabsView >> tabView [
	^ tabView
]

{ #category : #accessing }
ERContainerTabsView >> tabView: anObject [
	tabView := anObject
]
