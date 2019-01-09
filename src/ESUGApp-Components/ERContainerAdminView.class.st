Class {
	#name : #ERContainerAdminView,
	#superclass : #ERTabsContainerView,
	#instVars : [
		'controller',
		'callbackYes',
		'callbackNo'
	],
	#category : #'ESUGApp-Components'
}

{ #category : #'as yet unclassified' }
ERContainerAdminView class >> on: anAttendee withContent: aContent withController: aController [
	| form |
	form := self new.
	form attendee: anAttendee.
	form content: aContent.
	form controller: aController.
	form initializeTabForms .
	^ form
]

{ #category : #initialization }
ERContainerAdminView >> addTabsForAdmin [
	self renderBackupTab.
	self renderRestoreTab.
	self renderOpenCloseRegistration.
]

{ #category : #initialization }
ERContainerAdminView >> backUp [
]

{ #category : #actions }
ERContainerAdminView >> cancel [
]

{ #category : #initialization }
ERContainerAdminView >> closeRegistration [
	controller conference configuration openRegistration: false; save.
	
	
]

{ #category : #accessing }
ERContainerAdminView >> controller: anObject [
	controller := anObject
]

{ #category : #initialization }
ERContainerAdminView >> initializeTabForms [
	self addTab: (ERAdminUser on: attendee withContent: content).
	self addTab: (ERAdminChangePassword on: attendee withContent: content).
	self attendee userAccount isAdmin ifTrue: [ self addTabsForAdmin ].
	(self tabs at: 1) activate.
	
]

{ #category : #initialization }
ERContainerAdminView >> openRegistration [
	controller conference configuration
		openRegistration: true;
		save
]

{ #category : #initialization }
ERContainerAdminView >> renderBackupTab [
	self
		addTab:
			((ERTabYesNo on: attendee withContent: content)
				tabId: 'tabBackup';
				tabName: 'Backup';
				title: self titleBackup;
				callbackYes: callbackYes;
				callbackNo: callbackNo)
]

{ #category : #initialization }
ERContainerAdminView >> renderOpenCloseRegistration [
	self
		addTab:
			((ERTabYesNo on: attendee withContent: content)
				tabId: 'tabOpenClose';
				tabName: 'Open / Close registration';
				title: self titleOpenClose;
				callbackYes: callbackYes;
				callbackNo: callbackNo)
]

{ #category : #initialization }
ERContainerAdminView >> renderRestoreTab [
	self
		addTab:
			((ERTabYesNo on: attendee withContent: content)
				tabId: 'tabRestore';
				tabName: 'Restore';
				title: self titleRestore;
				callbackYes: callbackYes ;
				callbackNo: callbackNo )
]

{ #category : #initialization }
ERContainerAdminView >> restoreToLastBackup [
]

{ #category : #initialization }
ERContainerAdminView >> titleBackup [
	callbackYes := [ self backUp ].
	callbackNo := [ self cancel ].
	^ 'Are you sure want to do a backup?'
]

{ #category : #initialization }
ERContainerAdminView >> titleOpenClose [
	
	callbackNo := [ self cancel ].
	controller conferenceIsOpenRegistration
		ifTrue:
			[ callbackYes := [ self closeRegistration ].
			 ^ 'Registration is opened. Are you sure you want close it?' ]
		ifFalse: [ callbackYes := [ self openRegistration ].
			 ^ 'Registration is closed. Are you sure you want open it?' ]
]

{ #category : #initialization }
ERContainerAdminView >> titleRestore [
	callbackYes := [ self restoreToLastBackup ].
	callbackNo := [ self cancel ].
	^ 'Are you sure you want to restore the last backup? The current ata will be lost'
]
