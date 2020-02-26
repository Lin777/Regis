"
Description
--------------------

I am a class that control the generation of backup of page.

Instance Variables
--------------------
	version: a Number with that each backup will be saved
"
Class {
	#name : #ERBackupRestore,
	#superclass : #Object,
	#instVars : [
		'version'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'ESUGApp-Core'
}

{ #category : #accessing }
ERBackupRestore class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := super new ]
]

{ #category : #'actions api' }
ERBackupRestore >> backup [ 	
	[[self lock critical: [ 
		self backupDirectory.
		
		"SDFuelSerializer new serialize:
			(self objectsToBackup) toFile: ('' join: {self nameDirectory .'/'.self fileNamePrefix.'.'.self incrementVersionNumber})"]] on: Error do: [ :error | ERException backupError signal ]]
		forkAt: Processor systemBackgroundPriority
		named: ('' join: {'backup:'.self version}).
		^ ('' join: {self fileNamePrefix.'.'.self version}) 
]

{ #category : #accessing }
ERBackupRestore >> backupDirectory [
	^ (FileSystem workingDirectory asFileReference / self nameDirectory)
		 ensureCreateDirectory
]

{ #category : #accessing }
ERBackupRestore >> backupFilenames [

	^ self backupDirectory files select: [ :fileName |
		(fileName path basename) beginsWith: self fileNamePrefix ]
]

{ #category : #accessing }
ERBackupRestore >> fileNamePrefix [
	^ 'esug'
]

{ #category : #updating }
ERBackupRestore >> incrementVersionNumber [
	^ version := self version + 1
]

{ #category : #accessing }
ERBackupRestore >> lastBackup [
	|lastBackup|
	lastBackup := self lastBackupFilename .
	lastBackup ifNil: [ ^ nil ].
	
	^ SDFuelSerializer new materializeFromFile: ('' join: {self nameDirectory .'/'.lastBackup path basename })
]

{ #category : #accessing }
ERBackupRestore >> lastBackupFilename [
	^ self backupFilenames detectMax: [ :fileName | 
		self versionOf: (fileName path basename)]
]

{ #category : #'actions api' }
ERBackupRestore >> lock [ 
	^ Semaphore forMutualExclusion 
]

{ #category : #accessing }
ERBackupRestore >> nameDirectory [
	^ 'Backup'
]

{ #category : #accessing }
ERBackupRestore >> objectsToBackup [
	^ OrderedCollection new
		add: ERFee findAll;
		add: ERUserAccount findAll;
		add: ERReductionTicket findAll;
		add: ERAttendee findAll;
		add: ERGroup findAll;
		add: ERAward findAll;
		add: ERTalk findAll;
		add: ERConference findAll;
		yourself
]

{ #category : #'actions api' }
ERBackupRestore >> restoreBackup [
	self updateVersionToLastVersionOfBackup.
	self lastBackup ifNotNil: [ :backup | backup do: 
		[ :aClass | aClass do: [ :anObject | anObject save ] ] ]
]

{ #category : #'actions api' }
ERBackupRestore >> restoreBackup: aFilePath [
	|aFile|
	self updateVersionToLastVersionOfBackup: aFilePath.
	["aFile := SDFuelSerializer new materializeFromFile: aFilePath".
	aFile ifNotNil: [ :backup | backup do: 
		[ :aClass | aClass do: [ :anObject | anObject save ] ] ]]
	on: FileDoesNotExistException 
	do: [ :exp | exp signal].
	
]

{ #category : #'actions api' }
ERBackupRestore >> updateVersionToLastVersionOfBackup [
	self version: ( self versionOf: self lastBackupFilename path basename)
]

{ #category : #'actions api' }
ERBackupRestore >> updateVersionToLastVersionOfBackup: aFilePath [
	|lastBackup|
	lastBackup := ERBackupRestore new lastBackupFilename.
	lastBackup ifNil: [ 
		self version: ( self versionOf: (aFilePath splitOn: '/')last) ]
	ifNotNil: [ 
		self version: ( self versionOf: lastBackup path basename) ]
]

{ #category : #accessing }
ERBackupRestore >> version [
	version ifNil: [ version := 0 ].
	 ^ version
]

{ #category : #accessing }
ERBackupRestore >> version: aNumber [
	version := aNumber
]

{ #category : #accessing }
ERBackupRestore >> versionOf: fileName [
	^ (fileName substrings: '.' ) last asInteger 
]
