Class {
	#name : #ERTabsContainerView,
	#superclass : #ERContainerView,
	#instVars : [
		'tabs'
	],
	#category : #'ESUGApp-Components'
}

{ #category : #accessing }
ERTabsContainerView class >> attendee: anAttendee [
	|instance|
	instance := self new.
	instance attendee: anAttendee .
	instance initializeTabForms .
	^ instance 
]

{ #category : #adding }
ERTabsContainerView >> addTab: aAttendeeTabForm [
	self tabs add: aAttendeeTabForm
]

{ #category : #initialization }
ERTabsContainerView >> initializeTabForms [
	self subclassResponsibility 
]

{ #category : #rendering }
ERTabsContainerView >> renderContentPage: html [ 
	html div class: 'mdl-tabs mdl-js-tabs mdl-js-ripple-effect'; with: [ 
		html render: (ERTabsView new tabs: self tabs ) ]
	  
]

{ #category : #accessing }
ERTabsContainerView >> tabs [
	tabs ifNil: [ tabs:= OrderedCollection new].
	^ tabs.
]
