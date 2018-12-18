Class {
	#name : #ERTabsView,
	#superclass : #ERComponent,
	#instVars : [
		'tabs'
	],
	#category : #'ESUGApp-Components'
}

{ #category : #accessing }
ERTabsView class >> tabs: aList [
	| instance |
	instance := self new.
	instance tabs: aList .
	^ instance 
]

{ #category : #rendering }
ERTabsView >> renderContentOn: html [
			self renderTabNames: html.
			self renderTabs: html
]

{ #category : #rendering }
ERTabsView >> renderTabNames: html [
	html div
		class: 'mdl-tabs__tab-bar';
		with: [ self tabs
				do: [ :tab | 
					|activeClass|
					activeClass := ''.
					tab isActive ifTrue: [ activeClass := ' is-active' ].
					html anchor
						url: ('#' , 'tab-',tab tabId);
						class: 'mdl-tabs__tab', activeClass ;
						with: [html paragraph: (tab tabName) ]] ].
]

{ #category : #rendering }
ERTabsView >> renderTabs: html [
	self tabs
		do: [ :tab | 
			|activeClass |		
			activeClass := ''.
			tab isActive ifTrue: [ activeClass := ' is-active' ].
			
			html div
				class: 'mdl-tabs__panel', activeClass ;
				id: 'tab-',tab tabId;
				with: [ html render: tab ] ].
]

{ #category : #accessing }
ERTabsView >> tabs [
	^ tabs
]

{ #category : #accessing }
ERTabsView >> tabs: anObject [
	tabs := anObject
]
