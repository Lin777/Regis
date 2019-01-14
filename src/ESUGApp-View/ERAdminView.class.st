Class {
	#name : #ERAdminView,
	#superclass : #ERContainer,
	#instVars : [
		'controller',
		'callbackYes',
		'callbackNo',
		'tabs'
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
	self renderBackupTab.
	self renderRestoreTab.
	self renderOpenCloseRegistration.
]

{ #category : #initialization }
ERAdminView >> backUp [
]

{ #category : #actions }
ERAdminView >> cancel [
]

{ #category : #initialization }
ERAdminView >> closeRegistration [
	controller conference configuration openRegistration: false; save.
	
	
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
   tabs add: (ERAdminUserTab on: attendee withContent: content).
   tabs add: (ERChangePasswordForm on: attendee withContent: content).
	self attendee userAccount isAdmin ifTrue: [ self addTabsForAdmin ].
	(tabs at: 1) activate.
	
]

{ #category : #initialization }
ERAdminView >> openRegistration [
	controller conference configuration
		openRegistration: true;
		save
]

{ #category : #initialization }
ERAdminView >> renderBackupTab [
	tabs add:
			((ERYesNoTab on: attendee withContent: content)
				tabId: 'tabBackup';
				tabName: 'Backup';
				title: self titleBackup;
				callbackYes: callbackYes;
				callbackNo: callbackNo)
]

{ #category : #adding }
ERAdminView >> renderContentPage: html [
	html div
		class: 'mdl-tabs mdl-js-tabs mdl-js-ripple-effect';
		with: [ html render: (ERTabs new tabs: tabs) ]
]

{ #category : #initialization }
ERAdminView >> renderOpenCloseRegistration [
	tabs add:((ERYesNoTab on: attendee withContent: content)
				tabId: 'tabOpenClose';
				tabName: 'Open / Close registration';
				title: self titleOpenClose;
				callbackYes: callbackYes;
				callbackNo: callbackNo)
]

{ #category : #initialization }
ERAdminView >> renderRestoreTab [
	tabs add:
			((ERYesNoTab on: attendee withContent: content)
				tabId: 'tabRestore';
				tabName: 'Restore';
				title: self titleRestore;
				callbackYes: callbackYes ;
				callbackNo: callbackNo )
]

{ #category : #initialization }
ERAdminView >> restoreToLastBackup [
]

{ #category : #initialization }
ERAdminView >> titleBackup [
	callbackYes := [ self backUp ].
	callbackNo := [ self cancel ].
	^ 'Are you sure want to do a backup?'
]

{ #category : #initialization }
ERAdminView >> titleOpenClose [
	
	callbackNo := [ self cancel ].
	controller conferenceIsOpenRegistration
		ifTrue:
			[ callbackYes := [ self closeRegistration ].
			 ^ 'Registration is opened. Are you sure you want close it?' ]
		ifFalse: [ callbackYes := [ self openRegistration ].
			 ^ 'Registration is closed. Are you sure you want open it?' ]
]

{ #category : #initialization }
ERAdminView >> titleRestore [
	callbackYes := [ self restoreToLastBackup ].
	callbackNo := [ self cancel ].
	^ 'Are you sure you want to restore the last backup? The current ata will be lost'
]
