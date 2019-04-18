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
ERTestBackupAndRestore >> testBackupAfterRegisterGroupManager [
	|filesAfterBackup filesBeforeBackup|
	filesBeforeBackup := self filesSizeOfBackup.
	self registerAsGroupManager.
	(Delay forSeconds: 2) wait.
	filesAfterBackup := self filesSizeOfBackup.
	self assert: filesBeforeBackup < filesAfterBackup 
]
