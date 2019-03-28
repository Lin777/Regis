Class {
	#name : #ERTabsOfView,
	#superclass : #ERContainer,
	#instVars : [
		'tabs'
	],
	#category : #'ESUGApp-View'
}

{ #category : #accessing }
ERTabsOfView class >> content: aContent tabs: list [
	| instance |
	instance := self new.
	instance content: aContent .
	instance tabs: list.
	^ instance
]

{ #category : #initialization }
ERTabsOfView >> initialize [
	super initialize.
	tabs := OrderedCollection new.
]

{ #category : #initialization }
ERTabsOfView >> renderContentPageOn: html [
	html div
		class: 'mdl-tabs mdl-js-tabs mdl-js-ripple-effect';
		with: [ html render: (ERTabs new tabs: tabs) ]
]

{ #category : #initialization }
ERTabsOfView >> tabs [
	^ tabs
]

{ #category : #initialization }
ERTabsOfView >> tabs: list [
	tabs := list do: [ :each | each container: self ]
]
