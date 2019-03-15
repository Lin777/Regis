Class {
	#name : #ERTabs,
	#superclass : #ERComponent,
	#instVars : [
		'tabs'
	],
	#category : #'ESUGApp-Component'
}

{ #category : #accessing }
ERTabs class >> tabs: aList [
	| instance |
	instance := self new.
	instance tabs: aList .
	^ instance 
]

{ #category : #rendering }
ERTabs >> renderContentOn: html [
	self renderTabNamesOn: html.
	self renderTabsOn: html
]

{ #category : #rendering }
ERTabs >> renderTabNamesOn: html [
	html div
		class: 'mdl-tabs__tab-bar';
		with: [ self tabs
				do: [ :tab | 
					|activeClass anchor|
					activeClass := ''.
					tab isActive ifTrue: [ activeClass := ' is-active' ].
					anchor := html anchor
						id: 'tab-',tab tabName;
						url: '#' , 'tab-',tab tabId;
						class: 'mdl-tabs__tab', activeClass.
					tab disabled ifTrue: [ anchor disabled ].
					anchor with: [html paragraph: (tab tabName)]]].
]

{ #category : #rendering }
ERTabs >> renderTabsOn: html [
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
ERTabs >> tabs [
	^ tabs
]

{ #category : #accessing }
ERTabs >> tabs: anObject [
	tabs := anObject
]
