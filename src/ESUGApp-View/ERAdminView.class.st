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

{ #category : #initialization }
ERAdminView >> addTabsForAdmin [
	controller := ERConfigurationController new.
	self renderBackupTab.
	self renderRestoreTab.
	self renderOpenCloseRegistration.
]

{ #category : #initialization }
ERAdminView >> backup [
	[ ERBackupRestore uniqueInstance backup] 
		on: ERException 
		do: [ :exc | exc  ]
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
	self attendee isAdmin ifTrue: [ self addTabsForAdmin ].
	(tabs at: 1) activate.
	
]

{ #category : #initialization }
ERAdminView >> openRegistration [
	controller openRegistration
]

{ #category : #initialization }
ERAdminView >> renderBackupTab [
	tabs add:
			((ERYesNoTab on: attendee withContent: content container: self)
				tabId: 'tabBackup';
				tabName: 'Backup';
				titleTrue: self titleBackup ;
				callbackTrue: callbackYes;
				callbackNo: callbackNo).
]

{ #category : #adding }
ERAdminView >> renderContentPageOn: html [
	tabsComponent := (ERTabs new tabs: tabs).
	html div
		class: 'mdl-tabs mdl-js-tabs mdl-js-ripple-effect';
		with: [ html render: tabsComponent ]
]

{ #category : #initialization }
ERAdminView >> renderOpenCloseRegistration [
	tabs add:((ERYesNoTab on: attendee withContent: content container: self)
				tabId: 'tabOpenClose';
				tabName: 'Open / Close registration';
				stateBlock: [ controller conference conferenceIsOpenRegistration ];
				titleTrue: 'Registration is opened. Are you sure you want close it?';
				titleFalse:  'Registration is closed. Are you sure you want open it?';
				callbackTrue: [ :aTab | self closeRegistration. self cancel: aTab ];
				callbackFalse: [ :aTab | self openRegistration. self cancel: aTab ];
				callbackNo: [ :aTab | self cancel: aTab ])
]

{ #category : #initialization }
ERAdminView >> renderRestoreTab [
	tabs add:
			((ERYesNoTab on: attendee withContent: content container: self)
				tabId: 'tabRestore';
				tabName: 'Restore';
				titleTrue: self titleRestore;
				callbackTrue: callbackYes ;
				callbackNo: callbackNo )
]

{ #category : #initialization }
ERAdminView >> restoreToLastBackup [
]

{ #category : #accessing }
ERAdminView >> tabs [
	^ tabs
]

{ #category : #initialization }
ERAdminView >> titleBackup [
	callbackYes := [ :aTab | self backup. self cancel: aTab ].
	callbackNo := [ :aTab | self cancel: aTab ].
	^ 'Are you sure want to do a backup?'
]

{ #category : #initialization }
ERAdminView >> titleOpenClose [
	
	callbackNo := [ :aTab | self cancel: aTab ].
	controller conference conferenceIsOpenRegistration
		ifTrue:
			[ callbackYes := [ :aTab | self closeRegistration. self cancel: aTab ].
			 ^ 'Registration is opened. Are you sure you want close it?' ]
		ifFalse: [ callbackYes := [ :aTab | self openRegistration. self cancel: aTab ].
			 ^ 'Registration is closed. Are you sure you want open it?' ]
]

{ #category : #initialization }
ERAdminView >> titleRestore [
	callbackYes := [:aTab | self restoreToLastBackup. self cancel: aTab ].
	callbackNo := [:aTab | self cancel: aTab ].
	^ 'Are you sure you want to restore the last backup? The current ata will be lost'
]
