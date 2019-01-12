Class {
	#name : #ERNav,
	#superclass : #WAComponent,
	#instVars : [
		'title',
		'listOptions'
	],
	#category : #'ESUGApp-Component'
}

{ #category : #initialization }
ERNav >> initialize [
	super initialize.
	title := 'Home'.
	listOptions := OrderedCollection new
]

{ #category : #accessing }
ERNav >> listOptions: anObject [
	listOptions := anObject
]

{ #category : #rendering }
ERNav >> renderContentOn: html [
	self renderHeader: html.
	html div
		class:
			'demo-drawer mdl-layout__drawer mdl-color--blue-grey-900 mdl-color-text--blue-grey-50"';
		with: [ self renderHeaderESUG: html.
			html mdlNavigation
				class: 'demo-navigation mdl-color--blue-grey-800';
				with: [ listOptions do: [ :each | html render: each ] ] ]
]

{ #category : #rendering }
ERNav >> renderHeader: html [
	html header class: 'demo-header mdl-layout__header mdl-color--blue-grey-800 mdl-color-text--white';
	with: [ 
		html mdlLayoutHeaderRow with: [ 
			html span class: 'mdl-layout-title';
			with: title.
			html mdlLayoutSpacer.
		]	
	].
]

{ #category : #rendering }
ERNav >> renderHeaderESUG: html [
	html header class: 'demo-drawer-header';
	with: [ 
			html heading level4 with: 'ESUG'	
	]
]

{ #category : #accessing }
ERNav >> title: aString [
	title := aString
]
