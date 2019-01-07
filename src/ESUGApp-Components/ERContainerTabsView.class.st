Class {
	#name : #ERContainerTabsView,
	#superclass : #ERContainerView,
	#instVars : [
		'tabView',
		'dialog'
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

{ #category : #initialization }
ERContainerTabsView >> initializeDialog [
	dialog := ERDialog new
		title: 'Cancel Register Attendee';
		message: 'Are you sure you want to cancel?';
		idClose: 'buttonClose';
		idOpen: 'cancel-register-attendee';
		okCallback: [ self cancel ]
]

{ #category : #rendering }
ERContainerTabsView >> renderCancelButton: html [
	self initializeDialog .
	self
		createColoredAnchorButton: 'Cancel'
		id: 'cancel-register-attendee'
		on: html
]

{ #category : #rendering }
ERContainerTabsView >> renderContentPage: html [
	html mdlTabs rippleEffect
		with:
			[ html div
				style: 'overflow-x:auto;';
				with: [ html mdlGrid noSpacing
						with: [ html form
								method: 'post';
								id: 'formRegisterInTabs';
								with: [ html render: tabView.
									self renderCancelButton: html ] ] ] ].
	html render: dialog
]

{ #category : #accessing }
ERContainerTabsView >> tabView [
	^ tabView
]

{ #category : #accessing }
ERContainerTabsView >> tabView: anObject [
	tabView := anObject
]
