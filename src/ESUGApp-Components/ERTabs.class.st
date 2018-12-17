Class {
	#name : #ERTabs,
	#superclass : #ERComponent,
	#instVars : [
		'tabs'
	],
	#category : #'ESUGApp-Components'
}

{ #category : #rendering }
ERTabs >> renderContentOn: html [
			self renderTabNames: html.
			self renderTabs: html
]

{ #category : #rendering }
ERTabs >> renderTabNames: html [
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
ERTabs >> renderTabs: html [
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
