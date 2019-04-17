Class {
	#name : #ERAdminView,
	#superclass : #ERContainer,
	#instVars : [
		'controller',
		'callbackYes',
		'callbackNo',
		'tabs',
		'tabsComponent'
	],
	#category : #'ESUGApp-View'
}

{ #category : #'as yet unclassified' }
ERAdminView class >> on: anAttendee withContent: aContent withController: aController [
	| form |
	form := self new.
	form attendee: anAttendee.
	form content: aContent.
	form controller: aController.
	form initializeTabForms .
	^ form
]

{ #category : #actions }
ERAdminView >> cancel: aTab [
	aTab updateStateTab: aTab tabName 
]

{ #category : #adding }
ERAdminView >> children [ 
	^ Array with: tabsComponent
]

{ #category : #initialization }
ERAdminView >> closeRegistration [
	controller closeRegistration
	
	
]

{ #category : #accessing }
ERAdminView >> controller: anObject [
	controller := anObject
]

{ #category : #initialization }
ERAdminView >> initialize [
	super initialize.
	tabs := OrderedCollection new.
]

{ #category : #initialization }
ERAdminView >> initializeTabForms [
   tabs add: (ERAdminUserTab on: attendee withContent: content container: self).
   tabs add: (ERChangePasswordForm on: attendee withContent: content container: self).
	(tabs at: 1) activate.
	
]

{ #category : #adding }
ERAdminView >> renderContentPageOn: html [
	tabsComponent := (ERTabs new tabs: tabs).
	html div
		class: 'mdl-tabs mdl-js-tabs mdl-js-ripple-effect';
		with: [ html render: tabsComponent ]
]

{ #category : #accessing }
ERAdminView >> tabs [
	^ tabs
]
