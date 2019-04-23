"
Description
--------------------

A ERTestBackupAndRestore is a test class for testing the behavior of backup and restore of the page
"
Class {
	#name : #ERTestBackupAndRestore,
	#superclass : #ERTest,
	#category : #'ESUGApp-Test-UnitTest'
}

{ #category : #initialization }
ERTestBackupAndRestore >> backupDirectory [
	^ (FileSystem workingDirectory asFileReference /  'Backup')
		 ensureCreateDirectory
]

{ #category : #initialization }
ERTestBackupAndRestore >> filesSizeOfBackup [
	^ self backupDirectory files size
]

{ #category : #tests }
ERTestBackupAndRestore >> setUp [
	super setUp.
]

{ #category : #initialization }
ERTestBackupAndRestore >> testBackupAfterRegisterAttendee [
	|filesAfterBackup filesBeforeBackup|
	filesBeforeBackup := self filesSizeOfBackup.
	self registerAttendee.
	(Delay forSeconds: 2) wait.
	filesAfterBackup := self filesSizeOfBackup.
	self assert: filesBeforeBackup < filesAfterBackup 
]

{ #category : #initialization }
ERTestBackupAndRestore >> testBackupAfterRegisterAttendeeFromGroup [
	|filesAfterBackup filesBeforeBackup user group aController|
	user := self registerAsGroupManager.
	filesBeforeBackup := self filesSizeOfBackup.
	user := self registerAsGroupManager.
	group := self groupOfUser: user.
	aController := ERGroupManagerController new group: group.
	aController addAttendee: (self class testAttendee: 'test1@gmail.com').
	(Delay forSeconds: 2) wait.
	filesAfterBackup := self filesSizeOfBackup.
	self assert: filesBeforeBackup < filesAfterBackup 
]

{ #category : #initialization }
ERTestBackupAndRestore >> testBackupAfterRegisterGroupManager [
	|filesAfterBackup filesBeforeBackup|
	filesBeforeBackup := self filesSizeOfBackup.
	self registerAsGroupManager.
	(Delay forSeconds: 2) wait.
	filesAfterBackup := self filesSizeOfBackup.
	self assert: filesBeforeBackup < filesAfterBackup 
]

{ #category : #initialization }
ERTestBackupAndRestore >> testRestoreData [
	"This test verify that the state after restore is equal to data was removed"
	|stateBefore stateAfter|
	self registerAsGroupManager.
	(Delay forSeconds: 3) wait.
	stateBefore := ERBackupRestore new objectsToBackup.
	"Delete all data of database"
	self deleteAll.
	"Restore data"
	ESUGSetUp start.
	(Delay forSeconds: 3) wait.
	stateAfter := ERBackupRestore new objectsToBackup.
	self assert: stateBefore equals: stateAfter
]
